* Sky130 Latch-Type Sense Amplifier — Clean Version
* Pre-charge to 1.8V, then sense 50mV differential

.lib /home/dyoon06/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt

* ---- Pre-charge PMOS ----
XPC1 SAO  SAE VDD VDD sky130_fd_pr__pfet_01v8 W=2.0 L=0.15
XPC2 SAOB SAE VDD VDD sky130_fd_pr__pfet_01v8 W=2.0 L=0.15

* ---- Weak keeper PMOS ----
* These hold the HIGH output at VDD during sensing
XKP1 SAO  SAOB VDD VDD sky130_fd_pr__pfet_01v8 W=0.5 L=0.15
XKP2 SAOB SAO  VDD VDD sky130_fd_pr__pfet_01v8 W=0.5 L=0.15

* ---- Cross-coupled NMOS latch ----
XSN1 SAO  SAOB GND_SENSE GND sky130_fd_pr__nfet_01v8 W=1.0 L=0.15
XSN2 SAOB SAO  GND_SENSE GND sky130_fd_pr__nfet_01v8 W=1.0 L=0.15

* ---- Enable NMOS ----
XEN GND_SENSE SAE GND GND sky130_fd_pr__nfet_01v8 W=2.0 L=0.15

* ---- Supply ----
VDD VDD GND 1.8

* ---- SAE pulse: LOW until 2ns, then HIGH ----
VSAE SAE GND PULSE(0 1.8 2n 0.1n 0.1n 10n 20n)

* ---- Input capacitors to hold differential ----
* CSAO is slightly larger — holds SAO slightly lower
* This creates the input offset the latch resolves
CSAO  SAO  GND 10f
CSAOB SAOB GND 9f

* ---- Initial conditions ----
* Both start pre-charged, SAO slightly lower
.ic v(SAO)=1.75 v(SAOB)=1.8 v(GND_SENSE)=0

* ---- Transient ----
.tran 1p 15n

* ---- Print ----
.print tran v(SAO) v(SAOB) v(SAE)

.end