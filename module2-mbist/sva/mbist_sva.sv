// Sky130 SRAM Memory Subsystem — Module 2
// SVA protocol checker for mbist_ctrl
//
// Bound into mbist_ctrl via bind (see mbist_bind.sv), so it can see
// internal signals (state, phase, diag_captured) as well as the ports.
//
// Run with Verilator:  --binary --timing --assert
// (Icarus Verilog does not support concurrent SVA; keep using iverilog
//  for the functional testbenches, Verilator for this checker.)

`timescale 1ns/1ps

module mbist_sva (
    input            clk,
    input            rst,
    input            start,
    input      [7:0] mem_addr,
    input      [7:0] mem_din,
    input            mem_we,
    input            mem_ce,
    input            done,
    input            pass_fail,
    input      [7:0] diag_addr,
    // internal signals of mbist_ctrl, visible through bind
    input      [2:0] state,
    input      [1:0] phase,
    input            diag_captured
);

    // Mirror of the FSM encoding in mbist_ctrl.v
    localparam IDLE = 3'd0;
    localparam E0   = 3'd1;
    localparam E1   = 3'd2;
    localparam E2   = 3'd3;
    localparam E3   = 3'd4;
    localparam E4   = 3'd5;
    localparam DONE = 3'd6;

    // Convenience: "read-modify-write" March elements
    wire rmw_state = (state == E1) || (state == E2) || (state == E3);
    wire active    = (state == E0) || rmw_state || (state == E4);

    // ------------------------------------------------------------------
    // A1 — FSM never reaches an illegal state (3'd7 is unused)
    // ------------------------------------------------------------------
    a1_state_legal: assert property (@(posedge clk) disable iff (rst)
        state <= DONE)
        else $error("A1: illegal FSM state %0d", state);

    // ------------------------------------------------------------------
    // A2 — phase never reaches its unused encoding (2'd3)
    // ------------------------------------------------------------------
    a2_phase_legal: assert property (@(posedge clk) disable iff (rst)
        phase != 2'd3)
        else $error("A2: illegal phase 3 in state %0d", state);

    // ------------------------------------------------------------------
    // A3 — reset drives the controller to a quiet IDLE
    // ------------------------------------------------------------------
    a3_reset_state: assert property (@(posedge clk)
        rst |=> (state == IDLE && !mem_we && !mem_ce && !done))
        else $error("A3: reset did not land in quiet IDLE");

    // ------------------------------------------------------------------
    // A4 — start handshake: start in IDLE launches element E0 at addr 0
    //      with a write of the 0x00 background
    // ------------------------------------------------------------------
    a4_start_launch: assert property (@(posedge clk) disable iff (rst)
        (state == IDLE && start) |=>
            (state == E0 && mem_addr == 8'h00 && mem_we && mem_ce
             && mem_din == 8'h00))
        else $error("A4: start did not launch E0 write-0 at addr 0");

    // ------------------------------------------------------------------
    // A5 — read/modify/write phase protocol inside E1/E2/E3:
    //      phase 0 (read issue) is followed by phase 1 with WE low,
    //      phase 1 (latch+setup) is followed by phase 2 with WE high
    // ------------------------------------------------------------------
    a5a_read_phase: assert property (@(posedge clk) disable iff (rst)
        (rmw_state && phase == 2'd0) |=> (!mem_we && phase == 2'd1))
        else $error("A5a: WE not low in read phase, state %0d", state);

    a5b_write_phase: assert property (@(posedge clk) disable iff (rst)
        (rmw_state && phase == 2'd1) |=> (mem_we && phase == 2'd2))
        else $error("A5b: WE not high in write phase, state %0d", state);

    // ------------------------------------------------------------------
    // A6 — address stability through a read-modify-write element:
    //      the address must not move between the read issue (phase 0)
    //      and the write fire (phase 2)
    // ------------------------------------------------------------------
    a6_addr_stable: assert property (@(posedge clk) disable iff (rst)
        (rmw_state && (phase == 2'd1 || phase == 2'd2)) |->
            mem_addr == $past(mem_addr))
        else $error("A6: addr moved mid-element, state %0d", state);

    // ------------------------------------------------------------------
    // A7 — E4 is a read-only element: WE must never assert
    // ------------------------------------------------------------------
    a7_e4_readonly: assert property (@(posedge clk) disable iff (rst)
        (state == E4) |-> !mem_we)
        else $error("A7: write asserted during read-only E4");

    // ------------------------------------------------------------------
    // A8 — chip enable is held through every active March element
    // ------------------------------------------------------------------
    a8_ce_active: assert property (@(posedge clk) disable iff (rst)
        active |-> mem_ce)
        else $error("A8: CE dropped during active state %0d", state);

    // ------------------------------------------------------------------
    // A9 — done is only ever asserted in the DONE state, and DONE is
    //      quiet on the memory interface
    // ------------------------------------------------------------------
    a9a_done_only_in_done: assert property (@(posedge clk) disable iff (rst)
        done |-> (state == DONE))
        else $error("A9a: done asserted outside DONE state");

    a9b_done_quiet: assert property (@(posedge clk) disable iff (rst)
        done |-> (!mem_we && !mem_ce))
        else $error("A9b: memory interface active while done");

    // ------------------------------------------------------------------
    // A10 — pass_fail is sticky-low while a test is running: once a
    //       failure is flagged it cannot clear until back in IDLE
    // ------------------------------------------------------------------
    a10_fail_sticky: assert property (@(posedge clk) disable iff (rst)
        (!pass_fail && state != IDLE) |=> !pass_fail)
        else $error("A10: pass_fail cleared mid-test");

    // ------------------------------------------------------------------
    // A11 — diagnosis log is write-once: after diag_captured is set,
    //       diag_addr must never change until reset/restart
    // ------------------------------------------------------------------
    a11_diag_write_once: assert property (@(posedge clk) disable iff (rst)
        (diag_captured && $past(diag_captured)) |->
            diag_addr == $past(diag_addr))
        else $error("A11: diag_addr overwritten after capture");

    // ------------------------------------------------------------------
    // A12 — a failure implies the diagnosis flag: pass_fail low means
    //       diag_captured must be set (checked one cycle later since
    //       both are registered in the same block)
    // ------------------------------------------------------------------
    a12_fail_has_diag: assert property (@(posedge clk) disable iff (rst)
        (!pass_fail && state != IDLE) |-> diag_captured)
        else $error("A12: failure flagged but no diag address captured");

    // ------------------------------------------------------------------
    // Coverage — prove the interesting paths were actually exercised.
    // ------------------------------------------------------------------
    c1_test_completes:   cover property (@(posedge clk) disable iff (rst)
        state == DONE && done);
    c2_pass_path:        cover property (@(posedge clk) disable iff (rst)
        done && pass_fail);
    c3_fail_path:        cover property (@(posedge clk) disable iff (rst)
        done && !pass_fail);
    c4_diag_captured:    cover property (@(posedge clk) disable iff (rst)
        diag_captured);
    c5_addr_wrap_up:     cover property (@(posedge clk) disable iff (rst)
        state == E0 && mem_addr == 8'hFF);
    c6_addr_wrap_down:   cover property (@(posedge clk) disable iff (rst)
        state == E4 && mem_addr == 8'h00);

endmodule
