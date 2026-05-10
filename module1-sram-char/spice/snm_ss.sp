* Sky130 6T SRAM — SNM direct measurement
* Using .measure to find switching voltages

.lib /home/dyoon06/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice ss

* Left inverter
XMP1 QB_out VQ VDD VDD sky130_fd_pr__pfet_01v8 W=1.0 L=0.15
XMN1 QB_out VQ GND GND sky130_fd_pr__nfet_01v8 W=2.0 L=0.15

* Right inverter  
XMP2 Q_out VQB VDD VDD sky130_fd_pr__pfet_01v8 W=1.0 L=0.15
XMN2 Q_out VQB GND GND sky130_fd_pr__nfet_01v8 W=2.0 L=0.15

VDD VDD GND 1.8
VQ  VQ  GND dc 0
VQB VQB GND 0

.dc VQ 0 1.8 0.005

* Measure VM — switching point of left inverter
.measure dc VM1 when V(QB_out)=V(VQ)

* Measure NML — noise margin low
* NML = VM - VOL (where VOL is output low level)
.measure dc VOL find V(QB_out) when V(VQ)=1.8

* Measure NMH — noise margin high  
.measure dc VOH find V(QB_out) when V(VQ)=0

.print dc V(VQ) V(QB_out)

.end