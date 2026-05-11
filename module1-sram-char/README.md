# Module 1 — 6T SRAM Cell Characterization

## Overview
Full electrical characterization of a 6T SRAM bitcell and latch-type 
sense amplifier using the open-source Sky130 130nm PDK (ngspice + Python).
Covers hold state, write operation, read disturb, Static Noise Margin 
extraction, and process corner analysis across SS/TT/FF corners.

## Cell Specifications
| Parameter         | Value                    |
|-------------------|--------------------------|
| Process           | Sky130A 130nm CMOS       |
| Supply voltage    | 1.8V                     |
| Pull-down NMOS    | W=2.0µm, L=0.15µm        |
| Pull-up PMOS      | W=1.0µm, L=0.15µm        |
| Access NMOS       | W=1.0µm, L=0.15µm        |
| Cell ratio        | 2:1 (pull-down/access)   |
| Temperature       | 27°C (nominal)           |

## Key Results

### Functional Verification
| Test              | Result                   |
|-------------------|--------------------------|
| Hold state        | Q=1.8V stable over 5ns   |
| Write operation   | Cell flip in <0.5ns      |
| Read disturb      | 148.7 mV (Q rise)        |

### Static Noise Margin
| Mode              | SNM                      |
|-------------------|--------------------------|
| Hold-mode (TT)    | 579.7 mV                 |
| Read-mode (est.)  | 469.9 mV                 |
| Safety margin     | 431.0 mV (disturb vs SNM)|

### Corner Analysis
| Corner | VM (mV) | SNM (mV) |
|--------|---------|----------|
| SS     | 790.0   | 404.8    |
| TT     | 785.0   | 579.7    |
| FF     | 775.0   | 400.3    |

VM trend (SS > TT > FF) confirms correct corner behavior —
slower transistors switch at higher input voltage as expected.

### Sense Amplifier
| Parameter         | Value                    |
|-------------------|--------------------------|
| Input differential| 50 mV                    |
| Resolution time   | 231.5 ps                 |
| SAO output        | Resolves to 1.8V         |
| SAOB output       | Resolves to 0V           |

## Results Figures

### Hold State Verification
![Hold State](results/hold_state.png)

### Write Operation
![Write Operation](results/write_operation.png)

### Read Operation — Read Disturb
![Read Operation](results/read_operation.png)

### Sense Amplifier Resolution
![Sense Amplifier](results/sense_amp.png)

### Hold-Mode Butterfly Curves
![Butterfly Curves](results/butterfly_hold.png)

### Corner Analysis
![Corner Summary](results/corner_summary.png)

## Methodology Notes
- Hold-mode SNM extracted directly using unity-gain VTC method
- Read-mode SNM estimated analytically from hold SNM and 
  read disturb voltage
- SS/FF corner SNM used same unity-gain method with 
  transition-region constraint (400-1200mV)
- VM switching point is the most reliable corner metric —
  directly measured by ngspice .measure command

## How to Reproduce
```bash
cd module1-sram-char/spice
ngspice -b bitcell_6t.sp       # hold state
ngspice -b write_test.sp       # write operation  
ngspice -b read_test.sp        # read operation
ngspice -b sense_amp.sp        # sense amplifier
ngspice -b snm_measure.sp      # SNM extraction
cd ../scripts
python3 plot_hold.py
python3 plot_write.py
python3 plot_read.py
python3 plot_sense_amp.py
python3 plot_snm.py
python3 corner_summary.py
```

## Tools Used
- ngspice 36 (SPICE simulation)
- Sky130A PDK (130nm transistor models)
- Python 3.10 (NumPy, Matplotlib)
- WSL2 Ubuntu 22.04