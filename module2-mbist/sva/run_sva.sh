#!/usr/bin/env bash
# Runs the MBIST SVA suite under Verilator (Icarus does not support SVA).
# Run from module2-mbist/:   bash sva/run_sva.sh
set -e

echo "=== [1/2] Fault-free run: all 12 assertions + pass-path covers ==="
verilator --binary --timing --assert -Wno-fatal \
    --top-module tb_mbist_basic -Mdir obj_sva -o sim_sva \
    tb/tb_mbist_basic.v rtl/mbist_ctrl.v rtl/sram_256x8.v \
    sva/mbist_sva.sv sva/mbist_bind.sv
./obj_sva/sim_sva | tee /tmp/sva_run1.log

echo ""
echo "=== [2/2] Injected SAF at 0x42: fail/diagnosis path (A10-A12) ==="
verilator --binary --timing --assert -Wno-fatal \
    --top-module tb_mbist_sva_fault -Mdir obj_sva_fault -o sim_sva_fault \
    tb/tb_mbist_sva_fault.v rtl/mbist_ctrl.v rtl/sram_256x8.v \
    sva/mbist_sva.sv sva/mbist_bind.sv
./obj_sva_fault/sim_sva_fault | tee /tmp/sva_run2.log

echo ""
if grep -q "%Error" /tmp/sva_run1.log /tmp/sva_run2.log; then
    echo "SVA RESULT: FAIL — assertion fired, see logs above"
    exit 1
else
    echo "SVA RESULT: PASS — 0 assertion errors across both runs"
fi
