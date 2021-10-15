#!/bin/bash
# Reset the log files
printf '' > info-log.txt > debug-log.txt

# Tail the info logfile as a background process so the contents of the
# info logfile are output to stdout.
tail -f info-log.txt &

# Set an EXIT trap to ensure your background process is
# cleaned-up when the script exits
trap "pkill -P $$" EXIT

# Redirect both stdout and stderr to write to the debug logfile
exec 1>>debug-log.txt 2>>debug-log.txt

cd synopses/
git pull
cd ..
git fetch upstream
git merge upstream/main
git add --all
git commit --allow-empty -m "Update forks"
git push origin main

