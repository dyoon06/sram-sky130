// Sky130 SRAM Memory Subsystem — Module 2
// March C- MBIST Controller
// Algorithm: up(w0) up(r0,w1) up(r1,w0) down(r0,w1) down(r1)
// Complexity: 10n operations for n-cell array

module mbist_ctrl (
    input        clk,           // clock
    input        rst,           // synchronous reset (active high)
    input        start,         // pulse high to begin test
    input  [7:0] mem_dout,      // data read back from SRAM
    output reg [7:0] mem_addr,  // address to SRAM
    output reg [7:0] mem_din,   // data written to SRAM
    output reg       mem_we,    // write enable to SRAM
    output reg       mem_ce,    // chip enable to SRAM
    output reg       done,      // high when test complete
    output reg       pass_fail, // 1=PASS, 0=FAIL
    output reg [7:0] diag_addr  // first failing address
);

    // ---- State encoding ----
    localparam IDLE = 3'd0;
    localparam E0   = 3'd1; // up(w0)      — write 0 ascending
    localparam E1   = 3'd2; // up(r0,w1)   — read 0, write 1 ascending
    localparam E2   = 3'd3; // up(r1,w0)   — read 1, write 0 ascending
    localparam E3   = 3'd4; // down(r0,w1) — read 0, write 1 descending
    localparam E4   = 3'd5; // down(r1)    — read 1 descending
    localparam DONE = 3'd6;

    // ---- State register ----
    reg [2:0] state;

    // ---- Sub-state: read before write ----
    // Some elements do read THEN write at same address
    // phase=0: do the read, phase=1: do the write
    reg phase;

    // ---- Diagnosis ----
    reg diag_captured; // have we captured first fail address yet

    // ---- Expected data for comparison ----
    reg [7:0] expected;

    // ---- Sequential logic: state + outputs ----
    always @(posedge clk) begin
        if (rst) begin
            state         <= IDLE;
            mem_addr      <= 8'h00;
            mem_din       <= 8'h00;
            mem_we        <= 1'b0;
            mem_ce        <= 1'b0;
            done          <= 1'b0;
            pass_fail     <= 1'b1; // optimistic: assume PASS
            diag_addr     <= 8'hFF;
            diag_captured <= 1'b0;
            phase         <= 1'b0;
        end else begin
            case (state)

                // ----------------------------------------
                IDLE: begin
                    done      <= 1'b0;
                    pass_fail <= 1'b1;
                    diag_captured <= 1'b0;
                    if (start) begin
                        state    <= E0;
                        mem_addr <= 8'h00;
                        mem_din  <= 8'h00;
                        mem_we   <= 1'b1;
                        mem_ce   <= 1'b1;
                        phase    <= 1'b0;
                    end
                end

                // ----------------------------------------
                // Element 0: up(w0) — write 0 to all ascending
                E0: begin
                    mem_we  <= 1'b1;
                    mem_ce  <= 1'b1;
                    mem_din <= 8'h00;
                    if (mem_addr == 8'hFF) begin
                        // Done with E0 — move to E1
                        state    <= E1;
                        mem_addr <= 8'h00;
                        mem_we   <= 1'b0; // first op in E1 is a read
                        phase    <= 1'b0;
                    end else begin
                        mem_addr <= mem_addr + 1;
                    end
                end

                // ----------------------------------------
                // Element 1: up(r0,w1) — read 0 then write 1 ascending
                E1: begin
                    mem_ce <= 1'b1;
                    if (phase == 1'b0) begin
                        // READ phase — check for 0
                        mem_we   <= 1'b0;
                        expected <= 8'h00;
                        phase    <= 1'b1;
                    end else begin
                        // WRITE phase — write 1, check read result first
                        // Check the read that just happened
                        if (mem_dout !== expected) begin
                            pass_fail <= 1'b0;
                            if (!diag_captured) begin
                                diag_addr     <= mem_addr;
                                diag_captured <= 1'b1;
                            end
                        end
                        mem_we  <= 1'b1;
                        mem_din <= 8'hFF;
                        phase   <= 1'b0;
                        if (mem_addr == 8'hFF) begin
                            state    <= E2;
                            mem_addr <= 8'h00;
                            mem_we   <= 1'b0;
                        end else begin
                            mem_addr <= mem_addr + 1;
                        end
                    end
                end

                // ----------------------------------------
                // Element 2: up(r1,w0) — read 1 then write 0 ascending
                E2: begin
                    mem_ce <= 1'b1;
                    if (phase == 1'b0) begin
                        mem_we   <= 1'b0;
                        expected <= 8'hFF;
                        phase    <= 1'b1;
                    end else begin
                        if (mem_dout !== expected) begin
                            pass_fail <= 1'b0;
                            if (!diag_captured) begin
                                diag_addr     <= mem_addr;
                                diag_captured <= 1'b1;
                            end
                        end
                        mem_we  <= 1'b1;
                        mem_din <= 8'h00;
                        phase   <= 1'b0;
                        if (mem_addr == 8'hFF) begin
                            state    <= E3;
                            mem_addr <= 8'hFF;
                            mem_we   <= 1'b0;
                        end else begin
                            mem_addr <= mem_addr + 1;
                        end
                    end
                end

                // ----------------------------------------
                // Element 3: down(r0,w1) — read 0 write 1 descending
                E3: begin
                    mem_ce <= 1'b1;
                    if (phase == 1'b0) begin
                        mem_we   <= 1'b0;
                        expected <= 8'h00;
                        phase    <= 1'b1;
                    end else begin
                        if (mem_dout !== expected) begin
                            pass_fail <= 1'b0;
                            if (!diag_captured) begin
                                diag_addr     <= mem_addr;
                                diag_captured <= 1'b1;
                            end
                        end
                        mem_we  <= 1'b1;
                        mem_din <= 8'hFF;
                        phase   <= 1'b0;
                        if (mem_addr == 8'h00) begin
                            state    <= E4;
                            mem_addr <= 8'hFF;
                            mem_we   <= 1'b0;
                        end else begin
                            mem_addr <= mem_addr - 1;
                        end
                    end
                end

                // ----------------------------------------
                // Element 4: down(r1) — read 1 descending
                E4: begin
                    mem_ce <= 1'b1;
                    mem_we <= 1'b0;
                    if (mem_dout !== 8'hFF) begin
                        pass_fail <= 1'b0;
                        if (!diag_captured) begin
                            diag_addr     <= mem_addr;
                            diag_captured <= 1'b1;
                        end
                    end
                    if (mem_addr == 8'h00) begin
                        state <= DONE;
                    end else begin
                        mem_addr <= mem_addr - 1;
                    end
                end

                // ----------------------------------------
                DONE: begin
                    mem_ce <= 1'b0;
                    mem_we <= 1'b0;
                    done   <= 1'b1;
                end

            endcase
        end
    end

endmodule