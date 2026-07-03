#!/usr/bin/env python3
"""Plot the defect-to-fault bridge sweep.

Reads results/defect_open_pulldown_raw.txt (from defect_open_pulldown.sp)
and plots max V(Q) during the read and final V(Q) after the read versus
the pull-down open resistance. The crossing of the final value from ~0 V
to ~VDD marks the critical resistance where the read becomes destructive,
i.e. where a physical resistive-open defect turns into the logical
stuck-at / transition fault that March C- r0 elements catch.

Run from module1-sram-char/:  python3 scripts/plot_defect_bridge.py
"""

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

VDD = 1.8
TRIP = VDD / 2  # simple flip criterion

SUFFIX = {"k": 1e3, "meg": 1e6}


def parse_r(token):
    t = token.lower()
    for suf, mult in SUFFIX.items():
        if t.endswith(suf):
            return float(t[: -len(suf)]) * mult
    return float(t)


rows = []
with open("results/defect_open_pulldown_raw.txt") as f:
    for line in f:
        line = line.strip()
        if not line or line.startswith("*"):
            continue
        r, qmax, qfin = line.split()
        rows.append((parse_r(r), float(qmax), float(qfin)))

rows.sort()
r_vals = [r for r, _, _ in rows]
q_max = [q for _, q, _ in rows]
q_fin = [q for _, _, q in rows]

# critical resistance: first R where the cell state has flipped
r_crit = next((r for r, _, qf in rows if qf > TRIP), None)

fig, ax = plt.subplots(figsize=(8, 5))
ax.semilogx(r_vals, q_max, "o-", label="max V(Q) during read")
ax.semilogx(r_vals, q_fin, "s-", label="final V(Q) after read")
ax.axhline(TRIP, ls="--", lw=1, color="gray", label=f"trip point {TRIP:.1f} V")
if r_crit is not None:
    ax.axvline(r_crit, ls=":", lw=1.5, color="red",
               label=f"cell flips near R = {r_crit:,.0f} \u03a9")
ax.set_xlabel("Pull-down open resistance R_open (\u03a9)")
ax.set_ylabel("Node Q voltage (V)")
ax.set_title("Resistive-open defect \u2192 destructive read \u2192 "
             "March-detectable fault")
ax.grid(True, which="both", alpha=0.3)
ax.legend()
fig.tight_layout()
fig.savefig("results/defect_bridge.png", dpi=150)
print("Wrote results/defect_bridge.png")
if r_crit is not None:
    print(f"Critical resistance: cell flips near {r_crit:,.0f} ohms")
else:
    print("Cell never flipped in the swept range — extend the sweep upward")
