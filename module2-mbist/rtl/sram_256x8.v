// Sky130 SRAM Memory Subsystem — Module 2
// Behavioral 256x8 SRAM with fault injection
// Fault models: Stuck-At (SAF), Transition (TF), Coupling (CF)

module sram_256x8 #(
    // Stuck-At Fault parameters
    // Set SAF_ADDR >= 0 to inject a stuck-at fault
    parameter SAF_ADDR = -1,   // address of stuck-at fault (-1 = no fault)
    parameter SAF_BIT  =  0,   // which bit position (0-7) is stuck
    parameter SAF_VAL  =  0,   // stuck-at value: 0 or 1

    // Transition Fault parameters
    // Set TF_ADDR >= 0 to inject a transition fault
    parameter TF_ADDR  = -1,   // address of transition fault
    parameter TF_BIT   =  0,   // which bit cannot transition
    parameter TF_DIR   =  0,   // 0 = cannot go 0->1, 1 = cannot go 1->0

    // Coupling Fault parameters
    // Set CF_AGG >= 0 to inject a coupling fault
    parameter CF_AGG   = -1,   // aggressor address
    parameter CF_VIC   = -1,   // victim address
    parameter CF_BIT   =  0    // which bit of victim is coupled
)(
    input             clk,     // clock
    input             ce,      // chip enable (active high)
    input             we,      // write enable (1=write, 0=read)
    input      [7:0]  addr,    // 8-bit address (0-255)
    input      [7:0]  din,     // 8-bit data input
    output reg [7:0]  dout     // 8-bit data output
);

    // Memory array: 256 locations, 8 bits each
    reg [7:0] mem [0:255];

    // Previous value storage for transition fault detection
    reg [7:0] prev_val;

    integer i;

    // Initialize memory to 0
    initial begin
        for (i = 0; i < 256; i = i + 1)
            mem[i] = 8'h00;
        dout = 8'h00;
    end

    always @(posedge clk) begin
        if (ce) begin

            // ---- WRITE OPERATION ----
            if (we) begin
                // Store previous value for transition fault check
                prev_val = mem[addr];

                // Normal write
                mem[addr] <= din;

                // ---- Inject Transition Fault ----
                // If this address has a TF and the transition
                // direction matches, the write silently fails
                if (SAF_ADDR >= 0 && addr == SAF_ADDR[7:0]) begin
                    // SAF overrides write on read — handled below
                end

                if (TF_ADDR >= 0 && addr == TF_ADDR[7:0]) begin
                    // TF_DIR=0: cannot transition 0->1
                    if (TF_DIR == 0 &&
                        prev_val[TF_BIT] == 1'b0 &&
                        din[TF_BIT] == 1'b1) begin
                        // Write fails — bit stays at 0
                        mem[addr][TF_BIT] <= 1'b0;
                    end
                    // TF_DIR=1: cannot transition 1->0
                    if (TF_DIR == 1 &&
                        prev_val[TF_BIT] == 1'b1 &&
                        din[TF_BIT] == 1'b0) begin
                        // Write fails — bit stays at 1
                        mem[addr][TF_BIT] <= 1'b1;
                    end
                end

                // ---- Inject Coupling Fault ----
                // Writing to aggressor address flips victim bit
                if (CF_AGG >= 0 &&
                    addr == CF_AGG[7:0] &&
                    CF_VIC >= 0) begin
                    mem[CF_VIC[7:0]][CF_BIT] <=
                        ~mem[CF_VIC[7:0]][CF_BIT];
                end

            // ---- READ OPERATION ----
            end else begin
                dout <= mem[addr];

                // ---- Inject Stuck-At Fault on read ----
                if (SAF_ADDR >= 0 && addr == SAF_ADDR[7:0]) begin
                    if (SAF_VAL == 0)
                        dout <= mem[addr] & ~(8'h01 << SAF_BIT);
                    else
                        dout <= mem[addr] | (8'h01 << SAF_BIT);
                end
            end
        end
    end

endmodule