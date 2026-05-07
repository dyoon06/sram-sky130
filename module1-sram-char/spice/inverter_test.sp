* Sky130 CMOS Inverter - DC Sweep Smoke Test
* Purpose: verify ngspice + Sky130 PDK are working

.lib /home/dyoon06/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice tt

* PMOS pull-up: ports are drain gate source bulk
* Subcircuit call uses X prefix
XMP1 out in VDD VDD sky130_fd_pr__pfet_01v8 W=1.0 L=0.15

* NMOS pull-down: ports are drain gate source bulk
XMN1 out in GND GND sky130_fd_pr__nfet_01v8 W=0.65 L=0.15

* Power supply: 1.8V
VDD VDD GND 1.8

* Input voltage source for DC sweep
VIN in GND dc 0

* DC sweep: ramp VIN from 0V to 1.8V in 0.01V steps
.dc VIN 0 1.8 0.01

* Measure the switching point VM
.measure dc VM when V(out)=V(in)

* Save output voltage
.save V(out) V(in)
.print dc V(in) V(out)

.end