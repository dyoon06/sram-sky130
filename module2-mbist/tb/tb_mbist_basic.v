// Testbench: MBIST controller + fault-free SRAM
// Expected result: pass_fail=1 (PASS), done=1

`timescale 1ns/1ps

module tb_mbist_basic;

    // ---- Clock and control signals ----
    reg clk;
    reg rst;
    reg start;

    // ---- MBIST controller outputs ----
    wire [7:0] mem_addr;
    wire [7:0] mem_din;
    wire       mem_we;
    wire       mem_ce;
    wire       done;
    wire       pass_fail;
    wire [7:0] diag_addr;

    // ---- SRAM output ----
    wire [7:0] mem_dout;

    // ---- Instantiate MBIST controller ----
    mbist_ctrl uut (
        .clk      (clk),
        .rst      (rst),
        .start    (start),
        .mem_dout (mem_dout),
        .mem_addr (mem_addr),
        .mem_din  (mem_din),
        .mem_we   (mem_we),
        .mem_ce   (mem_ce),
        .done     (done),
        .pass_fail(pass_fail),
        .diag_addr(diag_addr)
    );

    // ---- Instantiate fault-free SRAM ----
    // All fault parameters left at default (-1 = no fault)
    sram_256x8 #(
        .SAF_ADDR(-1),
        .TF_ADDR (-1),
        .CF_AGG  (-1)
    ) mem (
        .clk  (clk),
        .ce   (mem_ce),
        .we   (mem_we),
        .addr (mem_addr),
        .din  (mem_din),
        .dout (mem_dout)
    );

    // ---- Clock generation ----
    initial clk = 0;
    always #5 clk = ~clk; // 10ns period = 100MHz

    // ---- Timeout watchdog ----
    // March C- on 256x8 = ~5000 clock cycles
    // Timeout after 20000 cycles to catch infinite loops
    initial begin
        #200000;
        $display("TIMEOUT — simulation ran too long");
        $finish;
    end

    // ---- Test stimulus ----
    initial begin
        // Initialize
        rst   = 1;
        start = 0;

        // Hold reset for 3 clock cycles
        @(posedge clk); #1;
        @(posedge clk); #1;
        @(posedge clk); #1;

        // Release reset
        rst = 0;
        @(posedge clk); #1;

        // Pulse start for one clock cycle
        start = 1;
        @(posedge clk); #1;
        start = 0;

        // Wait for done signal
        @(posedge done);
        #10; // wait a bit after done

        // Report result
        $display("=================================");
        $display("MBIST Test Complete");
        $display("Result: %s", pass_fail ? "PASS" : "FAIL");
        $display("Diag addr: %0d", diag_addr);
        $display("=================================");

        if (pass_fail == 1'b1)
            $display("CORRECT: fault-free memory passed");
        else
            $display("ERROR: fault-free memory should PASS");

        $finish;
    end

    // ---- Optional waveform dump ----
    initial begin
        $dumpfile("tb_mbist_basic.vcd");
        $dumpvars(0, tb_mbist_basic);
    end

endmodule