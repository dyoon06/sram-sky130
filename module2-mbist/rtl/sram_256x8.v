// Sky130 SRAM Memory Subsystem — Module 2
// Behavioral 256x8 SRAM with fault injection
// Synchronous write, always-on combinational read

module sram_256x8 #(
    parameter SAF_ADDR = -1,
    parameter SAF_BIT  =  0,
    parameter SAF_VAL  =  0,
    parameter TF_ADDR  = -1,
    parameter TF_BIT   =  0,
    parameter TF_DIR   =  0,
    parameter CF_AGG   = -1,
    parameter CF_VIC   = -1,
    parameter CF_BIT   =  0
)(
    input            clk,
    input            ce,
    input            we,
    input      [7:0] addr,
    input      [7:0] din,
    output     [7:0] dout
);

    reg [7:0] mem [0:255];
    reg [7:0] prev_val;
    integer i;

    initial begin
        for (i = 0; i < 256; i = i + 1)
            mem[i] = 8'h00;
    end

    // Synchronous write
    always @(posedge clk) begin
        if (ce && we) begin
            prev_val    = mem[addr];
            mem[addr]  <= din;

            // Transition fault
            if (TF_ADDR >= 0 && addr == TF_ADDR[7:0]) begin
                if (TF_DIR == 0 &&
                    prev_val[TF_BIT] == 1'b0 &&
                    din[TF_BIT]      == 1'b1)
                    mem[addr][TF_BIT] <= 1'b0;
                if (TF_DIR == 1 &&
                    prev_val[TF_BIT] == 1'b1 &&
                    din[TF_BIT]      == 1'b0)
                    mem[addr][TF_BIT] <= 1'b1;
            end

            // Coupling fault
            if (CF_AGG >= 0 && addr == CF_AGG[7:0] && CF_VIC >= 0)
                mem[CF_VIC[7:0]][CF_BIT] <= ~mem[CF_VIC[7:0]][CF_BIT];
        end
    end

    // Combinational read — always outputs mem[addr]
    reg [7:0] dout_raw;

    always @(*) begin
        dout_raw = mem[addr];
        if (SAF_ADDR >= 0 && addr == SAF_ADDR[7:0]) begin
            if (SAF_VAL == 0)
                dout_raw = mem[addr] & ~(8'h01 << SAF_BIT);
            else
                dout_raw = mem[addr] |  (8'h01 << SAF_BIT);
        end
    end

    assign dout = dout_raw;

endmodule