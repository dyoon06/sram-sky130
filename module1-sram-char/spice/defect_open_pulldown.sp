* Sky130 6T SRAM Bitcell — Defect-to-Fault Bridge
* Resistive open in the MN1 pull-down path, swept 1k to 10MEG
*
* Physical story: a weak via or contact in the pull-down path of the
* node storing 0 adds series resistance R_open. During a read, the
* bitline charge divider (BL -> MA1 -> Q -> MN1 -> R_open -> GND)
* bumps node Q higher as R_open grows. Past the cell trip point the
* read becomes destructive: the cell flips and later reads return 1.
* At the March-test level this manifests as the stuck-at / transition
* faults that r0 elements of March C- detect.
*
* Outputs per R value (written to results/defect_open_pulldown_raw.txt):
*   R_open   max V(Q) during WL pulse   final V(Q) after WL closes
* Cell has flipped when final V(Q) is near 1.8 V instead of 0 V.

.lib /home/dyoon06/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt

* ---- Storage Latch (identical sizing to read_test.sp) ----
XMP1 Q   QB  VDD VDD sky130_fd_pr__pfet_01v8 W=1.0 L=0.15
XMP2 QB  Q   VDD VDD sky130_fd_pr__pfet_01v8 W=1.0 L=0.15
* MN1 source lifted off GND -> defect resistor inserted in its path
XMN1 Q   QB  VS1 GND sky130_fd_pr__nfet_01v8 W=2.0 L=0.15
XMN2 QB  Q   GND GND sky130_fd_pr__nfet_01v8 W=2.0 L=0.15

* ---- Defect: resistive open in MN1 pull-down path ----
Ropen VS1 GND 1k

* ---- Access Transistors ----
XMA1 BL  WL  Q   GND sky130_fd_pr__nfet_01v8 W=1.0 L=0.15
XMA2 BLB WL  QB  GND sky130_fd_pr__nfet_01v8 W=1.0 L=0.15

* ---- Supply ----
VDD VDD GND 1.8

* WL pulse: high 2ns to 12ns (same as read_test.sp)
VWL WL GND PULSE(0 1.8 2n 0.1n 0.1n 10n 20n)

* BL and BLB pre-charged to 1.8V
VBL BL GND 1.8
VBLB BLB GND 1.8

* Initial conditions: storing a 0 (Q=0, QB=1.8)
.ic v(Q)=0 v(QB)=1.8

.control
set filetype = ascii
echo * R_open  Qmax_during_read(V)  Qfinal_after_read(V) > ../results/defect_open_pulldown_raw.txt
foreach rv 1k 2k 3k 4k 5k 6k 7k 8k 10k 30k 100k
  alter ropen = $rv
  tran 1p 20n
  meas tran qmax MAX v(q) from=2n to=12n
  meas tran qfin FIND v(q) at=19.5n
  echo $rv $&qmax $&qfin >> ../results/defect_open_pulldown_raw.txt
  destroy all
end
echo Done. Results in results/defect_open_pulldown_raw.txt
.endc

.end
