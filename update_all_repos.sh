#!/bin/bash
# Update all cloned Midnight repos

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

echo -e "${BLUE}Updating all Midnight repos...${NC}"
echo ""

for dir in ref_*-johns-copy; do
    if [ -d "$dir" ]; then
        echo -e "${YELLOW}Updating: $dir${NC}"
        cd "$dir"
        git pull --quiet
        echo -e "${GREEN}  ✅ Updated${NC}"
        cd ..
    fi
done

echo ""
echo -e "${GREEN}✅ All repos updated!${NC}"
