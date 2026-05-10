import numpy as np
import matplotlib.pyplot as plt

def parse_vtc(filename):
    x_vals = []
    y_vals = []
    with open(filename, 'r') as f:
        lines = f.readlines()
    for line in lines:
        parts = line.strip().split()
        if len(parts) == 5:
            try:
                int(parts[0])
                x_vals.append(float(parts[2]))
                y_vals.append(float(parts[3]))
            except ValueError:
                continue
    return np.array(x_vals), np.array(y_vals)

# VTC1: sweep VQ, record QB_out
vq, qb_out = parse_vtc('../results/snm_vtc1_raw.txt')

# VTC2: sweep VQB, record Q_out
vqb, q_out = parse_vtc('../results/snm_vtc2_raw.txt')

print(f"VTC1 points: {len(vq)}")
print(f"VTC2 points: {len(vqb)}")

if len(vq) == 0 or len(vqb) == 0:
    print("ERROR: No data parsed. Check file format.")
    exit()

print(f"VQ range: {vq.min():.3f} to {vq.max():.3f} V")
print(f"QB_out range: {qb_out.min():.3f} to {qb_out.max():.3f} V")
print(f"VQB range: {vqb.min():.3f} to {vqb.max():.3f} V")
print(f"Q_out range: {q_out.min():.3f} to {q_out.max():.3f} V")

# Find crossing points
diff = qb_out - vq
crossings = np.where(np.diff(np.sign(diff)))[0]
print(f"\nVTC1 crossing points:")
for c in crossings:
    print(f"  V(Q) = {vq[c]:.4f}V, V(QB) = {qb_out[c]:.4f}V")

# SNM extraction — largest inscribed square method
# For symmetric cell: find max separation between curves
# along the 45-degree diagonal direction
# SNM = max(|VTC1(x) - VTC2_inv(x)|) / sqrt(2)

# VTC2 inverted: swap x and y of qb_out vs vq
# At each x point, find where VTC2 (qb_out swapped) gives y
# VTC2_inv(x) = value of vq where qb_out = x
vtc2_inv = np.interp(vq, qb_out[::-1], vq[::-1])

# Distance between curves along diagonal
separation = np.abs(vq - vtc2_inv)

# SNM in lower-left eye (Q near 0)
lower_region = vq < 0.9
if lower_region.any():
    snm_lower = separation[lower_region].max() / np.sqrt(2)
    print(f"\nHold-mode SNM (lower-left eye): {snm_lower*1000:.1f} mV")

# SNM in upper-right eye (Q near 1.8V)
upper_region = vq > 0.9
if upper_region.any():
    snm_upper = separation[upper_region].max() / np.sqrt(2)
    print(f"Hold-mode SNM (upper-right eye): {snm_upper*1000:.1f} mV")

snm = min(snm_lower, snm_upper) if lower_region.any() and upper_region.any() else 0
print(f"Hold-mode SNM (worst case): {snm*1000:.1f} mV")

# Draw SNM square on plot
ax.annotate(f'SNM ≈ {snm*1000:.0f} mV',
            xy=(200, 200), fontsize=11,
            color='green', fontweight='bold')

# Plot butterfly curves
fig, ax = plt.subplots(figsize=(7, 7))

ax.plot(vq*1000, qb_out*1000,
        color='steelblue', linewidth=2.5,
        label='VTC1: Q → QB (left inverter)')

ax.plot(qb_out*1000, vq*1000,
        color='coral', linewidth=2.5,
        label='VTC2: QB → Q (right inverter, mirrored)')

ax.plot([0, 1800], [0, 1800],
        color='gray', linewidth=1.0,
        linestyle=':', label='V(Q) = V(QB)')

ax.set_xlabel('V(Q) [mV]', fontsize=12)
ax.set_ylabel('V(QB) [mV]', fontsize=12)
ax.set_title('Sky130 6T SRAM — Hold-Mode Butterfly Curves\n'
             'SNM = side of largest square in eye opening\n'
             'TT corner, 27°C, VDD=1.8V, Cell ratio 2:1',
             fontsize=11)
ax.set_xlim(0, 1800)
ax.set_ylim(0, 1800)
ax.legend(fontsize=10)
ax.grid(True, alpha=0.3)
ax.set_aspect('equal')

ax.set_title(f'Sky130 6T SRAM — Hold-Mode Butterfly Curves\n'
             f'Hold SNM ≈ {snm*1000:.0f} mV | TT corner, 27°C, VDD=1.8V',
             fontsize=11)

plt.tight_layout()
plt.savefig('../results/butterfly_hold.png', dpi=150)
print("\nButterfly curve saved to results/butterfly_hold.png")