#!/bin/bash

# --- CONFIGURATION ---
REMOTE_USER="bitroidprod"
REMOTE_HOST="193.16.34.10"
REMOTE_CRED="uhZtofOcNnzoH6F5-m0bzsLvCqIjzNFG"
REMOTE_DIR="/home/bitroidprod/logs"
LOCAL_DIR="/home/bitroidprod/logs"
# ---------------------

# Initialize variables
INPUT_DATE=""

# 1. Parse command line options
while getopts "p:" opt; do
  case $opt in
    p)
      INPUT_DATE="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# Shift arguments to reach the 'fetch' command
shift $((OPTIND-1))
ACTION=$1

# 2. Validation
if [ -z "$INPUT_DATE" ]; then
    echo "Error: Date is missing. Use -p <YYYYMMDD>"
    exit 1
fi

if [ "$ACTION" != "fetch" ]; then
    echo "Error: Invalid action. Only 'fetch' is supported."
    echo "Usage: $0 -p <YYYYMMDD> fetch"
    exit 1
fi

# 3. Execution Logic
echo "Starting SCP fetch..."

# Construct the filename: bitroid + date + wildcard (for extensions)
# Example: -p 20231219 -> bitroid20231219*
FILE_PATTERN="bitroid${INPUT_DATE}*"

echo "Targeting file(s): $FILE_PATTERN"

# Execute SCP
scp "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/${FILE_PATTERN}" "$LOCAL_DIR"

# Check status
if [ $? -eq 0 ]; then
    echo "✅ Download successful for ${FILE_PATTERN}"
else
    echo "❌ SCP failed. Check if file exists or connection is valid."
    exit 1
fi
