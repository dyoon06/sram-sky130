import matplotlib.pyplot as plt
import numpy as np

fault_types = ['SAF\n(Stuck-At)', 'TF\n(Transition)', 'CF\n(Coupling)']
detected    = [50, 50, 36]
total       = [50, 50, 50]
coverage    = [100, 100, 72]
colors      = ['#3B6D11', '#3B6D11', '#D85A30']

fig, ax = plt.subplots(figsize=(8, 5))

x = np.arange(len(fault_types))
bars = ax.bar(x, coverage, color=colors, width=0.5,
              edgecolor='white', linewidth=1.5)

ax.set_ylabel('Fault Coverage [%]', fontsize=12)
ax.set_xlabel('Fault Model', fontsize=12)
ax.set_title('March C\u2212 Fault Coverage Analysis\n'
             'Sky130 256\u00d78 SRAM — 150 Fault Scenarios',
             fontsize=12)
ax.set_xticks(x)
ax.set_xticklabels(fault_types, fontsize=11)
ax.set_ylim(0, 115)
ax.axhline(100, color='gray', linestyle='--',
           linewidth=1.0, alpha=0.5, label='100% target')
ax.grid(True, alpha=0.3, axis='y')

for bar, cov, det, tot in zip(bars, coverage, detected, total):
    ax.text(bar.get_x() + bar.get_width()/2,
            bar.get_height() + 2,
            f'{cov}%\n({det}/{tot})',
            ha='center', fontsize=11, fontweight='500')

ax.text(0.98, 0.05,
        f'Overall: 136/150 = 90%',
        transform=ax.transAxes,
        ha='right', fontsize=11,
        bbox=dict(boxstyle='round', facecolor='wheat', alpha=0.5))

ax.legend(fontsize=10)
plt.tight_layout()
plt.savefig('../results/fault_coverage.png', dpi=150)
print("Coverage chart saved to results/fault_coverage.png")
print("\nMarch C- Coverage Summary:")
print(f"  SAF: 100% — catches all stuck-at faults by design")
print(f"  TF:  100% — both 0->1 and 1->0 transitions covered")
print(f"  CF:   72% — inversion coupling faults partially missed")
print(f"  Why CF < 100%: March C- does not generate all")
print(f"  aggressor-victim sequence pairs needed to detect")
print(f"  all coupling fault types. March SS closes this gap.")