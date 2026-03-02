# K⁺ region counting with GROMACS selections

Two small Bash scripts to identify and summarize **K⁺ ions** in three spatial regions of a system using **GROMACS `gmx select`** outputs.

- `ioncount_+v.sh` — generates region selections and produces a summary report
- `ioncountfindnumbers_+v.sh` — helper that finds common ion identifiers across region files and counts occurrences

## Requirements

- GROMACS (`gmx`)
- Bash + coreutils (`grep`, `sort`, `comm`, `wc`)

## Inputs (expected in the working directory)

- `v+center.xtc` — trajectory
- `topol.tpr` — topology

## Outputs

Running `ioncount_+v.sh` generates:

- `outSF_+v.ndx`
- `outEXT_+v.ndx`
- `outINT_+v.ndx`
- `ioncountresult_+v.txt`

## Usage

```bash
chmod +x ioncount_+v.sh ioncountfindnumbers_+v.sh
./ioncount_+v.sh
```

## Notes

- The region definitions use COM coordinates of specific **atom numbers** (`atomnr ...`). These are system-dependent.
  If you change your topology, update the atom numbers in `ioncount_+v.sh` accordingly.
- The helper script extracts “word” tokens from the `.ndx`-like outputs and reports tokens common to all three region files.
