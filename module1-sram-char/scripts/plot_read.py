import numpy as np
import matplotlib.pyplot as plt

with open('../results/read_test_raw.txt', 'r') as f:
    lines = f.readlines()

time_vals = []
q_vals = []
qb_vals = []
bl_vals = []

for line in lines:
    parts = line.strip().split()
    if len(parts) == 4:
        try:
            int(parts[0])
            time_vals.append(float(parts[1]))
            q_vals.append(float(parts[2]))
            qb_vals.append(float(parts[3]))
        except ValueError:
            continue
    elif len(parts) == 5:
        try:
            int(parts[0])
            time_vals.append(float(parts[1]))
            q_vals.append(float(parts[2]))
            qb_vals.append(float(parts[3]))
            bl_vals.append(float(parts[4]))
        except ValueError:
            continue

time = np.array(time_vals) * 1e9
q    = np.array(q_vals)
qb   = np.array(qb_vals)

print(f"Total data points: {len(time)}")
print(f"Time range: {time[0]:.3f} ns to {time[-1]:.3f} ns")
print(f"Q range: {q.min()*1000:.2f} mV to {q.max()*1000:.2f} mV")
print(f"QB range: {qb.min():.4f} V to {qb.max():.4f} V")

fig, ax1 = plt.subplots(figsize=(9, 5))

ax1.plot(time, q*1000,  color='coral',     linewidth=2.5,
         label='V(Q) — stored 0 [mV]')
ax1.plot(time, qb*1000, color='steelblue', linewidth=2.5,
         label='V(QB) — stored 1 [mV]')

ax1.set_ylabel('Voltage [mV]', fontsize=11)
ax1.set_xlabel('Time [ns]', fontsize=11)
ax1.legend(fontsize=10)
ax1.grid(True, alpha=0.3)
ax1.set_title('Sky130 6T SRAM — Read Operation\n'
              'Initial state Q=0V (storing 0), BL/BLB pre-charged to 1.8V',
              fontsize=11)

plt.tight_layout()
plt.savefig('../results/read_operation.png', dpi=150)
print("Plot saved to results/read_operation.png")

max_q = q.max()
print(f"\nMax Q voltage during simulation: {max_q*1000:.2f} mV")
if max_q < 0.9:
    print("Cell held its state — NO read disturb flip")
else:
    print("WARNING — cell flipped during read")
