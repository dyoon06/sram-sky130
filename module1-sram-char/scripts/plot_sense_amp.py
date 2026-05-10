import numpy as np
import matplotlib.pyplot as plt

with open('../results/sense_amp_raw.txt', 'r') as f:
    lines = f.readlines()

time_vals = []
sao_vals  = []
saob_vals = []
sae_vals  = []

for line in lines:
    parts = line.strip().split()
    if len(parts) >= 4:
        try:
            int(parts[0])
            time_vals.append(float(parts[1]))
            sao_vals.append(float(parts[2]))
            saob_vals.append(float(parts[3]))
            if len(parts) >= 5:
                sae_vals.append(float(parts[4]))
        except ValueError:
            continue

time = np.array(time_vals) * 1e9
sao  = np.array(sao_vals)
saob = np.array(saob_vals)

print(f"Total data points: {len(time)}")
print(f"Time range: {time[0]:.3f} to {time[-1]:.3f} ns")
print(f"SAO  range: {sao.min()*1000:.1f} mV to {sao.max()*1000:.1f} mV")
print(f"SAOB range: {saob.min()*1000:.1f} mV to {saob.max()*1000:.1f} mV")

# Find resolution time
sae_start = 2.0
sao_resolved  = time[sao  > 1.7]
saob_resolved = time[saob < 0.1]
if len(sao_resolved) > 0 and len(saob_resolved) > 0:
    t_resolved = max(sao_resolved[0], saob_resolved[0])
    resolution_time = t_resolved - sae_start
    print(f"\nSAE fires at: {sae_start:.1f} ns")
    print(f"Outputs resolved at: {t_resolved:.3f} ns")
    print(f"Resolution time: {resolution_time*1000:.1f} ps")

fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(9, 6), sharex=True)

ax1.plot(time, sao*1000,  color='steelblue', linewidth=2.5,
         label='V(SAO) — input 0.9V → resolves HIGH')
ax1.plot(time, saob*1000, color='coral',     linewidth=2.5,
         label='V(SAOB) — input 0.8V → resolves LOW')
ax1.axvline(2.0, color='green', linestyle='--',
            linewidth=1.5, label='SAE fires at 2ns')
ax1.set_ylabel('Output Voltage [mV]', fontsize=11)
ax1.set_ylim(-100, 2000)
ax1.legend(fontsize=10)
ax1.grid(True, alpha=0.3)
ax1.set_title('Sky130 Latch-Type Sense Amplifier\n'
              'Input differential = 100mV (SAO=0.9V, SAOB=0.8V)',
              fontsize=11)

if len(sae_vals) > 0:
    sae = np.array(sae_vals)
    ax2.plot(time, sae*1000, color='green', linewidth=2.5,
             label='V(SAE)')
    ax2.set_ylabel('SAE [mV]', fontsize=11)
    ax2.set_xlabel('Time [ns]', fontsize=11)
    ax2.set_ylim(-100, 2000)
    ax2.legend(fontsize=10)
    ax2.grid(True, alpha=0.3)
else:
    ax2.set_ylabel('SAE', fontsize=11)
    ax2.set_xlabel('Time [ns]', fontsize=11)
    ax2.text(7, 0.5, 'SAE data not captured in print statement',
             ha='center', fontsize=10, color='gray')

plt.tight_layout()
plt.savefig('../results/sense_amp.png', dpi=150)
print("Plot saved to results/sense_amp.png")
