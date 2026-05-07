import numpy as np
import matplotlib.pyplot as plt
import re

# Load the raw ngspice output
with open('../results/inverter_raw.txt', 'r') as f:
    lines = f.readlines()

# Parse the data table
vin_vals = []
vout_vals = []

for line in lines:
    line = line.strip()
    match = re.match(
        r'^\d+\s+([\d.e+\-]+)\s+([\d.e+\-]+)\s+([\d.e+\-]+)',
        line
    )
    if match:
        vin_vals.append(float(match.group(2)))
        vout_vals.append(float(match.group(3)))

vin  = np.array(vin_vals)
vout = np.array(vout_vals)

# Find VM
vm_idx = np.argmin(np.abs(vout - vin))
vm = vin[vm_idx]

# Plot
fig, ax = plt.subplots(figsize=(7, 5))
ax.plot(vin, vout, color='steelblue', linewidth=2.5, label='V(out)')
ax.axvline(vm, color='red', linestyle='--', linewidth=1.5,
           label=f'VM = {vm:.3f} V')
ax.axhline(vm, color='gray', linestyle=':', linewidth=1.0)
ax.set_xlabel('Input Voltage V(in) [V]', fontsize=12)
ax.set_ylabel('Output Voltage V(out) [V]', fontsize=12)
ax.set_title('Sky130 CMOS Inverter — Voltage Transfer Characteristic\n'
             'NMOS W=0.65µm, PMOS W=1.0µm, L=0.15µm, VDD=1.8V',
             fontsize=11)
ax.set_xlim(0, 1.8)
ax.set_ylim(0, 1.8)
ax.legend(fontsize=11)
ax.grid(True, alpha=0.3)
plt.tight_layout()
plt.savefig('../results/inverter_vtc.png', dpi=150)
print(f"Plot saved to results/inverter_vtc.png")
print(f"VM (switching point) = {vm:.4f} V")
