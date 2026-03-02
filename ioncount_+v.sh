#!/bin/bash
# ============================================================
# ioncount_+v.sh
# ============================================================
# Purpose
#   Generates three GROMACS selection outputs (via `gmx select`) that identify
#   K+ ions in three spatial regions relative to reference atoms, then writes
#   a summary report using `ioncountfindnumbers_+v.sh`.
#
# What it does
#   1) Runs three `gmx select` commands to create:
#        - outSF_+v.ndx   (SF region window)
#        - outEXT_+v.ndx  (extracellular-side window)
#        - outINT_+v.ndx  (intracellular-side window)
#   2) Runs `ioncountfindnumbers_+v.sh` and saves output to:
#        - ioncountresult_+v.txt
#
# Inputs
#   - v+center.xtc   trajectory
#   - topol.tpr      topology
#
# Outputs
#   - outSF_+v.ndx, outEXT_+v.ndx, outINT_+v.ndx
#   - ioncountresult_+v.txt
#
# Notes
#   - Selections use COM coordinates of specific atom numbers (atomnr ...).
#     These atom numbers are system-dependent.
#   - Requires GROMACS in PATH (uses `gmx`).
#
# Usage
#   chmod +x ioncount_+v.sh ioncountfindnumbers_+v.sh
#   ./ioncount_+v.sh
# ============================================================

echo "atomname K and ( z > z of com of atomnr 1738 ) and ( z < z of com of atomnr 1671 ) and ( y > y of com of atomnr 1738 ) and ( y < y of com of atomnr 3671 )" | gmx select -f v+center.xtc -s topol.tpr -on outSF_+v.ndx
echo "atomname K and ( z < z of com of atomnr 1738 ) and ( z > z of com of atomnr 1146 )" | gmx select -f v+center.xtc -s topol.tpr -on outEXT_+v.ndx
echo "atomname K and ( z > z of com of atomnr 1671 ) and ( z < z of com of atomnr 2224 )" | gmx select -f v+center.xtc -s topol.tpr -on outINT_+v.ndx
bash ioncountfindnumbers_+v.sh > ioncountresult_+v.txt
