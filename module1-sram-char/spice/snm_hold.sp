* Sky130 6T SRAM — Hold-mode SNM Extraction
* Single sweep of left inverter VTC
* WL=0, no access transistors

.lib /home/dyoon06/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt

* ---- Left inverter ----
XMP1 QB_out VQ VDD VDD sky130_fd_pr__pfet_01v8 W=1.0 L=0.15
XMN1 QB_out VQ GND GND sky130_fd_pr__nfet_01v8 W=2.0 L=0.15

* ---- Right inverter ----
XMP2 Q_out VQB VDD VDD sky130_fd_pr__pfet_01v8 W=1.0 L=0.15
XMN2 Q_out VQB GND GND sky130_fd_pr__nfet_01v8 W=2.0 L=0.15

* ---- Supply ----
VDD VDD GND 1.8

* ---- Sweep VQ only ----
VQ  VQ  GND dc 0
VQB VQB GND 0.9

* ---- DC sweep ----
.dc VQ 0 1.8 0.005

* ---- Print ----
.print dc V(VQ) V(QB_out) V(Q_out)

.end