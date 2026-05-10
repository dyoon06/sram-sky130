// Sky130 SRAM Memory Subsystem — Module 2
// March C- MBIST Controller
// Fix: 2-bit phase for proper write timing
// phase=0: issue read
// phase=1: latch dout + check + setup write (addr stable)
// phase=2: write fires, then increment/decrement addr

module mbist_ctrl (
    input            clk,
    input            rst,
    input            start,
    input      [7:0] mem_dout,
    output reg [7:0] mem_addr,
    output reg [7:0] mem_din,
    output reg       mem_we,
    output reg       mem_ce,
    output reg       done,
    output reg       pass_fail,
    output reg [7:0] diag_addr
);

    localparam IDLE = 3'd0;
    localparam E0   = 3'd1;
    localparam E1   = 3'd2;
    localparam E2   = 3'd3;
    localparam E3   = 3'd4;
    localparam E4   = 3'd5;
    localparam DONE = 3'd6;

    reg [2:0] state;
    reg [1:0] phase;       // 2-bit phase
    reg       diag_captured;
    reg [7:0] read_data;

    // last address flag helpers
    wire at_top = (mem_addr == 8'hFF);
    wire at_bot = (mem_addr == 8'h00);

    always @(posedge clk) begin
        if (rst) begin
            state         <= IDLE;
            mem_addr      <= 8'h00;
            mem_din       <= 8'h00;
            mem_we        <= 1'b0;
            mem_ce        <= 1'b0;
            done          <= 1'b0;
            pass_fail     <= 1'b1;
            diag_addr     <= 8'hFF;
            diag_captured <= 1'b0;
            phase         <= 2'd0;
            read_data     <= 8'h00;
        end else begin
            case (state)

                // ----------------------------------------
                IDLE: begin
                    done          <= 1'b0;
                    pass_fail     <= 1'b1;
                    diag_captured <= 1'b0;
                    if (start) begin
                        state    <= E0;
                        mem_addr <= 8'h00;
                        mem_din  <= 8'h00;
                        mem_we   <= 1'b1;
                        mem_ce   <= 1'b1;
                        phase    <= 2'd0;
                    end
                end

                // ----------------------------------------
                // E0: up(w0) — write 0 to all ascending
                // Simple: one cycle per address, we=1 always
                E0: begin
                    mem_we  <= 1'b1;
                    mem_ce  <= 1'b1;
                    mem_din <= 8'h00;
                    // Write fires at current addr this cycle
                    if (at_top) begin
                        state    <= E1;
                        mem_addr <= 8'h00;
                        mem_we   <= 1'b0;
                        phase    <= 2'd0;
                    end else begin
                        mem_addr <= mem_addr + 1;
                    end
                end

                // ----------------------------------------
                // E1: up(r0,w1)
                // phase=0: issue read (we=0)
                // phase=1: latch + check + setup write (addr stable)
                // phase=2: write fires, advance addr
                E1: begin
                    mem_ce <= 1'b1;
                    case (phase)
                        2'd0: begin
                            mem_we    <= 1'b0;
                            phase     <= 2'd1;
                        end
                        2'd1: begin
                            // latch read data
                            read_data <= mem_dout;
                            // setup write to same addr
                            mem_we    <= 1'b1;
                            mem_din   <= 8'hFF;
                            phase     <= 2'd2;
                        end
                        2'd2: begin
                            // write fired at current addr
                            // check latched read data
                            if (read_data !== 8'h00) begin
                                pass_fail <= 1'b0;
                                if (!diag_captured) begin
                                    diag_addr     <= mem_addr;
                                    diag_captured <= 1'b1;
                                end
                            end
                            mem_we <= 1'b0;
                            phase  <= 2'd0;
                            if (at_top) begin
                                state    <= E2;
                                mem_addr <= 8'h00;
                            end else begin
                                mem_addr <= mem_addr + 1;
                            end
                        end
                        default: phase <= 2'd0;
                    endcase
                end

                // ----------------------------------------
                // E2: up(r1,w0)
                E2: begin
                    mem_ce <= 1'b1;
                    case (phase)
                        2'd0: begin
                            mem_we <= 1'b0;
                            phase  <= 2'd1;
                        end
                        2'd1: begin
                            read_data <= mem_dout;
                            mem_we    <= 1'b1;
                            mem_din   <= 8'h00;
                            phase     <= 2'd2;
                        end
                        2'd2: begin
                            if (read_data !== 8'hFF) begin
                                pass_fail <= 1'b0;
                                if (!diag_captured) begin
                                    diag_addr     <= mem_addr;
                                    diag_captured <= 1'b1;
                                end
                            end
                            mem_we <= 1'b0;
                            phase  <= 2'd0;
                            if (at_top) begin
                                state    <= E3;
                                mem_addr <= 8'hFF;
                            end else begin
                                mem_addr <= mem_addr + 1;
                            end
                        end
                        default: phase <= 2'd0;
                    endcase
                end

                // ----------------------------------------
                // E3: down(r0,w1)
                E3: begin
                    mem_ce <= 1'b1;
                    case (phase)
                        2'd0: begin
                            mem_we <= 1'b0;
                            phase  <= 2'd1;
                        end
                        2'd1: begin
                            read_data <= mem_dout;
                            mem_we    <= 1'b1;
                            mem_din   <= 8'hFF;
                            phase     <= 2'd2;
                        end
                        2'd2: begin
                            if (read_data !== 8'h00) begin
                                pass_fail <= 1'b0;
                                if (!diag_captured) begin
                                    diag_addr     <= mem_addr;
                                    diag_captured <= 1'b1;
                                end
                            end
                            mem_we <= 1'b0;
                            phase  <= 2'd0;
                            if (at_bot) begin
                                state    <= E4;
                                mem_addr <= 8'hFF;
                            end else begin
                                mem_addr <= mem_addr - 1;
                            end
                        end
                        default: phase <= 2'd0;
                    endcase
                end

                // ----------------------------------------
                // E4: down(r1) — read only, two phases
                E4: begin
                    mem_ce <= 1'b1;
                    mem_we <= 1'b0;
                    case (phase)
                        2'd0: begin
                            phase <= 2'd1;
                        end
                        2'd1: begin
                            read_data <= mem_dout;
                            phase     <= 2'd2;
                        end
                        2'd2: begin
                            if (read_data !== 8'hFF) begin
                                pass_fail <= 1'b0;
                                if (!diag_captured) begin
                                    diag_addr     <= mem_addr;
                                    diag_captured <= 1'b1;
                                end
                            end
                            phase <= 2'd0;
                            if (at_bot) begin
                                state <= DONE;
                            end else begin
                                mem_addr <= mem_addr - 1;
                            end
                        end
                        default: phase <= 2'd0;
                    endcase
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