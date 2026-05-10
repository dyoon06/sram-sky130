`timescale 1ns/1ps
module debug_test;

    reg clk, rst, start;
    wire [7:0] mem_addr, mem_din, mem_dout, diag_addr;
    wire mem_we, mem_ce, done, pass_fail;
    integer cycle_count;

    mbist_ctrl uut(
        .clk(clk), .rst(rst), .start(start),
        .mem_dout(mem_dout), .mem_addr(mem_addr),
        .mem_din(mem_din), .mem_we(mem_we),
        .mem_ce(mem_ce), .done(done),
        .pass_fail(pass_fail), .diag_addr(diag_addr)
    );

    sram_256x8 #(.SAF_ADDR(-1),.TF_ADDR(-1),.CF_AGG(-1)) mem(
        .clk(clk), .ce(mem_ce), .we(mem_we),
        .addr(mem_addr), .din(mem_din), .dout(mem_dout)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial cycle_count = 0;
    always @(posedge clk) begin
        cycle_count = cycle_count + 1;
        if (cycle_count % 100 == 0)
            $display("cycle=%0d addr=%0d we=%b ce=%b done=%b pf=%b",
                cycle_count, mem_addr, mem_we, mem_ce, done, pass_fail);
        if (cycle_count >= 20000) begin
            $display("TIMEOUT at cycle %0d", cycle_count);
            $finish;
        end
    end

    initial begin
        rst   = 1;
        start = 0;
        repeat(5) @(posedge clk); #1;
        rst = 0;
        repeat(3) @(posedge clk); #1;
        start = 1;
        @(posedge clk); #1;
        start = 0;
        wait(done == 1);
        #10;
        $display("DONE: pass_fail=%b diag=%0d", pass_fail, diag_addr);
        $finish;
    end

endmodule