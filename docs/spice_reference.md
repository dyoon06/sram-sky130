# SPICE Quick Reference

## PDK Path
/home/dyoon06/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice

## Model Names
- NMOS 1.8V: sky130_fd_pr__nfet_01v8
- PMOS 1.8V: sky130_fd_pr__pfet_01v8

## Transistor Syntax
X[name] [drain] [gate] [source] [bulk] [model] W=[width] L=0.15

## Voltage Source Syntax
V[name] [pos node] [neg node] [value]

## Analysis Commands
.tran [timestep] [total time]
.dc [source] [start] [stop] [step]
.ic v(node)=value
.print tran V(node1) V(node2)
.measure tran [name] when V(node)=[value]

## Netlist Structure
1. Title comment (*)
2. .lib — load PDK
3. Components (X for transistors, V for sources)
4. Analysis command (.tran or .dc)
5. .print and .measure
6. .end