#!/bin/bash
# ============================================================
# ioncountfindnumbers_+v.sh
# ============================================================
# Purpose
#   Finds word tokens common to all selection output files and prints
#   total/per-file counts. Intended for post-processing outputs from
#   `ioncount_+v.sh`.
#
# Inputs
#   - outSF_+v.ndx
#   - outEXT_+v.ndx
#   - outINT_+v.ndx
#
# Output
#   - Report to stdout (redirect to a file if desired)
#
# Usage
#   bash ioncountfindnumbers_+v.sh > ioncountresult_+v.txt
# ============================================================

files=( outSF_+v.ndx outEXT_+v.ndx outINT_+v.ndx )

# Function to find common words in any number of files
wcomm() {
    # If no files provided, exit the function.
    [ $# -lt 1 ] && return 1
    # Extract words from first file
    local common_words=$(grep -o "\w*" "$1" | sort -u)
    while [ $# -gt 1 ]; do
        # shift $1 to next file
        shift
        # Extract words from next file
        local next_words=$(grep -o "\w*" "$1" | sort -u)
        # Get only words in common from $common_words and $next_words
        common_words=$(comm -12 <(echo "${common_words,,}") <(echo "${next_words,,}"))
    done
    # Output the words common to all input files
    echo "$common_words"
}

# Output number of matches for each of the common words in total and per file
for w in $(wcomm "${files[@]}"); do
    echo $w:$(grep -oiw "$w" "${files[@]}" | wc -l);
    for f in "${files[@]}"; do
        echo $f:$(grep -oiw "$w" "$f" | wc -l);
    done;
    echo;
done

