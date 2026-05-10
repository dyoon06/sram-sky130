import numpy as np

# All VM values are directly measured from ngspice .measure
# SNM values use unity gain method with transition region constraint

corners = {
    'SS': {'vm': 790.0, 'snm': 404.8, 'voh': 1800.0, 'vol': 0.0},
    'TT': {'vm': 785.0, 'snm': 579.7, 'voh': 1800.0, 'vol': 0.0},
    'FF': {'vm': 775.0, 'snm': 400.3, 'voh': 1800.0, 'vol': 0.0},
}

print("=" * 55)
print("Sky130 6T SRAM Cell — Corner Analysis Summary")
print("Cell ratio 2:1, VDD=1.8V, T=27°C")
print("=" * 55)
print(f"{'Corner':<10} {'VM (mV)':<12} {'SNM (mV)':<12} {'VOH (mV)':<12}")
print("-" * 55)
for corner, data in corners.items():
    print(f"{corner:<10} {data['vm']:<12.1f} {data['snm']:<12.1f} {data['voh']:<12.1f}")
print("=" * 55)

snm_vals = [d['snm'] for d in corners.values()]
print(f"\nWorst-case SNM: {min(snm_vals):.1f} mV ({list(corners.keys())[np.argmin(snm_vals)]} corner)")
print(f"Best-case SNM:  {max(snm_vals):.1f} mV ({list(corners.keys())[np.argmax(snm_vals)]} corner)")
print(f"SNM variation:  {max(snm_vals)-min(snm_vals):.1f} mV across SS/TT/FF")

print("\nNote: TT SNM measured directly from VTC unity-gain method.")
print("SS/FF SNM estimated using same method with transition-region")
print("constraint. TT result is most reliable.")

import matplotlib.pyplot as plt
import matplotlib.patches as mpatches

fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 5))

corner_names = list(corners.keys())
snm_values = [corners[c]['snm'] for c in corner_names]
vm_values  = [corners[c]['vm']  for c in corner_names]
colors = ['#D85A30', '#378ADD', '#3B6D11']

bars = ax1.bar(corner_names, snm_values, color=colors, width=0.5,
               edgecolor='white', linewidth=1.5)
ax1.set_ylabel('Hold-mode SNM [mV]', fontsize=12)
ax1.set_title('SNM vs Process Corner\nSky130 6T SRAM, VDD=1.8V, 27°C',
              fontsize=11)
ax1.set_ylim(0, 700)
ax1.grid(True, alpha=0.3, axis='y')
for bar, val in zip(bars, snm_values):
    ax1.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 10,
             f'{val:.1f} mV', ha='center', fontsize=11, fontweight='500')

ax2.plot(corner_names, vm_values, 'o-',
         color='steelblue', linewidth=2.5,
         markersize=10, markerfacecolor='white',
         markeredgewidth=2.5)
ax2.set_ylabel('VM — Inverter Switching Point [mV]', fontsize=12)
ax2.set_title('VM vs Process Corner\nSky130 6T SRAM, VDD=1.8V, 27°C',
              fontsize=11)
ax2.set_ylim(700, 850)
ax2.grid(True, alpha=0.3)
for i, (c, v) in enumerate(zip(corner_names, vm_values)):
    ax2.annotate(f'{v:.1f} mV', (c, v),
                textcoords="offset points",
                xytext=(0, 12), ha='center', fontsize=11)

plt.tight_layout()
plt.savefig('../results/corner_summary.png', dpi=150)
print("\nPlot saved to results/corner_summary.png")