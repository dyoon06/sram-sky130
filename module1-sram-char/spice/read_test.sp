* Sky130 6T SRAM Bitcell — Read Operation
* Initial state: Q=0V, QB=1.8V (storing a 0)
* BL and BLB pre-charged to 1.8V
* WL pulse at 2ns

.lib /home/dyoon06/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt

* ---- Storage Latch ----
XMP1 Q   QB  VDD VDD sky130_fd_pr__pfet_01v8 W=1.0 L=0.15
XMP2 QB  Q   VDD VDD sky130_fd_pr__pfet_01v8 W=1.0 L=0.15
XMN1 Q   QB  GND GND sky130_fd_pr__nfet_01v8 W=2.0 L=0.15
XMN2 QB  Q   GND GND sky130_fd_pr__nfet_01v8 W=2.0 L=0.15

* ---- Access Transistors ----
XMA1 BL  WL  Q   GND sky130_fd_pr__nfet_01v8 W=1.0 L=0.15
XMA2 BLB WL  QB  GND sky130_fd_pr__nfet_01v8 W=1.0 L=0.15

* ---- Supply ----
VDD VDD GND 1.8

* WL — pulse from 0 to 1.8V, starts at 2ns,
*       rise/fall=0.1ns, width=8ns, period=20ns
VWL WL GND PULSE(0 1.8 2n 0.1n 0.1n 10n 20n)

* BL and BLB — both pre-charged to 1.8V
VBL BL GND 1.8
VBLB BLB GND 1.8

* Initial conditions — storing a 0
* Q starts at 0V, QB starts at 1.8V
.ic v(Q)=0 v(QB)=1.8

* Transient — run for 15ns, timestep 1ps
.tran 1p 15n

* Print Q, QB, BL, and WL
.print tran v(q) v(qb) v(bl)

.end