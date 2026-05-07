* Sky130 6T SRAM Bitcell — Hold State Verification
* Nodes: Q QB BL BLB WL VDD GND
* Cell ratio: MN/MA = 2.0/1.0 = 2:1

.lib /home/dyoon06/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt

* ---- Storage Latch ----
* Pull-up PMOS: source=VDD, drain=storage node
* MP1: left inverter pull-up
XMP1 Q   QB  VDD VDD sky130_fd_pr__pfet_01v8 W=1.0 L=0.15
* MP2: right inverter pull-up
XMP2 QB  Q   VDD VDD sky130_fd_pr__pfet_01v8 W=1.0 L=0.15

* Pull-down NMOS: source=GND, drain=storage node
* MN1: left inverter pull-down
XMN1 Q   QB  GND GND sky130_fd_pr__nfet_01v8 W=2.0 L=0.15
* MN2: right inverter pull-down
XMN2 QB  Q   GND GND sky130_fd_pr__nfet_01v8 W=2.0 L=0.15

* ---- Access Transistors ----
* MA1: connects Q to BL
XMA1 BL  WL  Q   GND sky130_fd_pr__nfet_01v8 W=1.0 L=0.15
* MA2: connects QB to BLB
XMA2 BLB WL  QB  GND sky130_fd_pr__nfet_01v8 W=1.0 L=0.15

* ---- Supply ----
VDD VDD GND 1.8

* ---- Hold state: WL=0, access transistors OFF ----
VWL  WL  GND 0
VBL  BL  GND 1.8
VBLB BLB GND 1.8

* ---- Initial conditions: store a 1 at Q ----
.ic v(Q)=1.8 v(QB)=0

* ---- Transient simulation: run for 5ns ----
* If the cell holds, Q stays near 1.8V the whole time
.tran 1p 5n

* ---- Print both storage nodes ----
.print tran V(Q) V(QB)

.end