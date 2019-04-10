#!/usr/bin/env bash

# this script converts SHOW GLOBAL STATUS into a tabulated format, one line
# per sample in the input, with the metrics divided by the time elapsed
# between samples.

awk '
    BEGIN {
        printf "#ts date time load QPS";
        fmt = " %.2f";
    }
    /^TS { # The timestamp lines begin with TS.
        ts = substr($2, 1, index($2, ".") -1);
        load = NF - 2;
        diff = ts - prev_ts;
        prev_ts = ts;
        printf "\n%s %s %s", ts, $3, $4, substr($load, 1, length($load)-1);
    }
    /Queries/ {
        printf fmt, ($2-Queries)/diff;
        Queries=$2
    }
' "$@"

# ./monitor/mysql/analyze_show_global_status_to_qps.sh 5-sec-status-2000-01-01

