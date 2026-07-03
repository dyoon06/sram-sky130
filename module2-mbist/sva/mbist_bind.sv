// Binds the SVA checker into every mbist_ctrl instance.
// Because the checker is bound inside the module scope, it can connect
// to internal signals (state, phase, diag_captured) by name.

bind mbist_ctrl mbist_sva sva_i (
    .clk           (clk),
    .rst           (rst),
    .start         (start),
    .mem_addr      (mem_addr),
    .mem_din       (mem_din),
    .mem_we        (mem_we),
    .mem_ce        (mem_ce),
    .done          (done),
    .pass_fail     (pass_fail),
    .diag_addr     (diag_addr),
    .state         (state),
    .phase         (phase),
    .diag_captured (diag_captured)
);
