import numpy as np
import matplotlib.pyplot as plt

with open('../results/write_test_raw.txt', 'r') as f:
    lines = f.readlines()

time_vals = []
q_vals = []
qb_vals = []
wl_vals = []

for line in lines:
    parts = line.strip().split()
    if len(parts) == 5:
        try:
            int(parts[0])
            time_vals.append(float(parts[1]))
            q_vals.append(float(parts[2]))
            qb_vals.append(float(parts[3]))
            wl_vals.append(float(parts[4]))
        except ValueError:
            continue

time = np.array(time_vals) * 1e9
q    = np.array(q_vals)
qb   = np.array(qb_vals)
wl   = np.array(wl_vals)

fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(9, 6), sharex=True)

ax1.plot(time, q,  color='steelblue', linewidth=2.5, label='V(Q)')
ax1.plot(time, qb, color='coral',     linewidth=2.5, label='V(QB)')
ax1.set_ylabel('Storage Nodes [V]', fontsize=11)
ax1.set_ylim(-0.1, 2.0)
ax1.legend(fontsize=11)
ax1.grid(True, alpha=0.3)
ax1.set_title('Sky130 6T SRAM — Write 0 Operation\n'
              'Initial state Q=1.8V, Write: BL=0V, BLB=1.8V, WL pulse at 2ns',
              fontsize=11)

ax2.plot(time, wl, color='green', linewidth=2.5, label='V(WL)')
ax2.set_ylabel('Wordline [V]', fontsize=11)
ax2.set_xlabel('Time [ns]', fontsize=11)
ax2.set_ylim(-0.1, 2.0)
ax2.legend(fontsize=11)
ax2.grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig('../results/write_operation.png', dpi=150)
print("Plot saved to results/write_operation.png")

if len(q_vals) > 0:
    q_arr = np.array(q_vals)
    t_arr = np.array(time_vals) * 1e9
    flip_idx = np.where(q_arr < 0.9)[0]
    if len(flip_idx) > 0:
        print(f"Q crosses 0.9V (midpoint) at: {t_arr[flip_idx[0]]:.3f} ns")
        print(f"Time from WL rising to Q flip: {t_arr[flip_idx[0]] - 2.0:.3f} ns")
