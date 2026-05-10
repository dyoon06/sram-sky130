* Sky130 6T SRAM — Read-mode SNM
* Proper loading: Q node driven through resistor
* WL=1.8V, BL=BLB=1.8V

.lib /home/dyoon06/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt

* ---- Left inverter ----
XMP1 QB_out Q_node VDD VDD sky130_fd_pr__pfet_01v8 W=1.0 L=0.15
XMN1 QB_out Q_node GND GND sky130_fd_pr__nfet_01v8 W=2.0 L=0.15

* ---- Access transistor loading Q node ----
XMA1 BL WL Q_node GND sky130_fd_pr__nfet_01v8 W=1.0 L=0.15

* ---- Right inverter ----
XMP2 Q_out  QB_node VDD VDD sky130_fd_pr__pfet_01v8 W=1.0 L=0.15
XMN2 Q_out  QB_node GND GND sky130_fd_pr__nfet_01v8 W=2.0 L=0.15

* ---- Access transistor loading QB node ----
XMA2 BLB WL QB_node GND sky130_fd_pr__nfet_01v8 W=1.0 L=0.15

* ---- Drive Q_node through large resistor ----
* This lets the access transistor actually load the node
VQ_src VQ_src GND dc 0
RQ VQ_src Q_node 1Meg

* ---- Drive QB_node through large resistor ----
VQB_src VQB_src GND 0.9
RQB VQB_src QB_node 1Meg

* ---- Supply and control ----
VDD VDD GND 1.8
VWL WL  GND 1.8
VBL  BL  GND 1.8
VBLB BLB GND 1.8

* ---- Sweep VQ_src ----
.dc VQ_src 0 1.8 0.005

* ---- Print Q_node voltage (actual loaded node) ----
.print dc V(VQ_src) V(Q_node) V(QB_out)

.end