* Sky130 6T SRAM Bitcell — Write 0 Operation
* Initial state: Q=1.8V, QB=0V (storing a 1)
* Write operation: force Q to 0V, QB to 1.8V

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

* ---- Wordline: goes HIGH at 2ns to enable access ----
* PULSE(start end delay rise fall pulsewidth period)
VWL WL GND PULSE(0 1.8 2n 0.1n 0.1n 10n 20n)

* ---- BL = 0V: pulls Q down during write ----
VBL BL GND 0

* ---- BLB = 1.8V: holds QB side ----
VBLB BLB GND 1.8

* ---- Initial condition: cell storing a 1 ----
.ic v(Q)=1.8 v(QB)=0

* ---- Transient: run 15ns to capture full write ----
.tran 1p 15n

* ---- Print all key nodes ----
.print tran V(Q) V(QB) V(WL)

.end