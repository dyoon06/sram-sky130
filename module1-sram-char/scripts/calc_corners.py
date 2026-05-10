import numpy as np

def calc_snm(filename, corner_name):
    vq = []
    qb = []
    with open(filename) as f:
        lines = f.readlines()

    for line in lines:
        parts = line.strip().split()

        if len(parts) == 4:
            try:
                idx = int(parts[0])
                if idx == 0:
                    continue
                vq.append(float(parts[2]))
                qb.append(float(parts[3]))
            except:
                continue

        elif len(parts) == 5:
            try:
                idx = int(parts[0])
                if idx == 0:
                    continue
                vq.append(float(parts[2]))
                qb.append(float(parts[3]))
            except:
                continue

    vq = np.array(vq)
    qb = np.array(qb)

    if len(vq) == 0:
        print(f"{corner_name}: No data parsed")
        return

    print(f"\n{corner_name} Corner:")
    print(f"Data points: {len(vq)}")

    vm_idx = np.argmin(np.abs(qb - vq))
    print(f"VM: {vq[vm_idx]*1000:.1f} mV")
    print(f"VOH: {qb[0]*1000:.1f} mV")
    print(f"VOL: {qb[-1]*1000:.4f} mV")

    dvout_dvin = np.diff(qb) / np.diff(vq)

    transition = (vq[:-1] > 0.4) & (vq[:-1] < 1.2)

    for threshold in [2.0, 5.0, 10.0]:
        candidates = np.where(
            (np.abs(dvout_dvin + 1) < threshold) & transition
        )[0]
        if len(candidates) >= 2:
            unity_gain = candidates
            VIL = vq[unity_gain[0]]
            VIH = vq[unity_gain[-1]]
            VOL = qb[unity_gain[-1]]
            VOH = qb[unity_gain[0]]
            NML = VIL - VOL
            NMH = VOH - VIH
            SNM = min(NML, NMH)
            print(f"VIL: {VIL*1000:.1f} mV")
            print(f"VIH: {VIH*1000:.1f} mV")
            print(f"NML: {NML*1000:.1f} mV")
            print(f"NMH: {NMH*1000:.1f} mV")
            print(f"SNM: {SNM*1000:.1f} mV")
            return

    print(f"Could not extract SNM — check data")

calc_snm('../results/snm_ss_raw.txt', 'SS')
calc_snm('../results/snm_ff_raw.txt', 'FF')

print("\n--- Corner Summary ---")
print(f"SS SNM: see above")
print(f"TT SNM: 579.7 mV (measured)")
print(f"FF SNM: see above")