import numpy as np
import matplotlib.pyplot as plt
import re

with open('../results/hold_test_raw.txt', 'r') as f:
    lines = f.readlines()

time_vals = []
q_vals = []
qb_vals = []

for line in lines:
    line = line.strip()
    parts = line.split()
    if len(parts) == 4:
        try:
            idx  = int(parts[0])
            t    = float(parts[1])
            q    = float(parts[2])
            qb   = float(parts[3])
            time_vals.append(t)
            q_vals.append(q)
            qb_vals.append(qb)
        except ValueError:
            continue

time = np.array(time_vals) * 1e9
q    = np.array(q_vals)
qb   = np.array(qb_vals)

fig, ax = plt.subplots(figsize=(8, 4))
ax.plot(time, q,  color='steelblue', linewidth=2.5, label='V(Q) stored 1')
ax.plot(time, qb, color='coral',     linewidth=2.5, label='V(QB) stored 0')
ax.set_xlabel('Time [ns]', fontsize=12)
ax.set_ylabel('Voltage [V]', fontsize=12)
ax.set_title('Sky130 6T SRAM Bitcell - Hold State Verification\nWL=0V, Cell ratio 2:1, VDD=1.8V, TT corner 27C', fontsize=11)
ax.set_ylim(-0.1, 2.0)
ax.set_xlim(0, 5)
ax.legend(fontsize=11)
ax.grid(True, alpha=0.3)
plt.tight_layout()
plt.savefig('../results/hold_state.png', dpi=150)
print("Plot saved to results/hold_state.png")
print(f"V(Q)  final value: {q[-1]:.6f} V")
print(f"V(QB) final value: {qb[-1]:.6f} V")