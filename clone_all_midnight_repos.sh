#!/bin/bash
# Clone all 24 Midnight Network repositories
# Target: /home/js/utils_Midnight/Midnight_reference_repos
# Naming: ref_<original-name>-johns-copy

set -e  # Exit on error

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Cloning All Midnight Repos${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo -e "${YELLOW}Target: $(pwd)${NC}"
echo -e "${YELLOW}Pattern: ref_<name>-johns-copy${NC}"
echo ""

# Counter
total=24
current=0

# Clone function
clone_repo() {
    local repo_name=$1
    local target_name="ref_${repo_name}-johns-copy"
    
    current=$((current + 1))
    echo -e "${BLUE}[${current}/${total}] Cloning ${repo_name}...${NC}"
    
    if [ -d "$target_name" ]; then
        echo -e "${YELLOW}  ⚠ Already exists, skipping${NC}"
    else
        git clone "https://github.com/midnightntwrk/${repo_name}.git" "$target_name" 2>&1 | grep -v "Receiving objects" || true
        echo -e "${GREEN}  ✅ Done${NC}"
    fi
    echo ""
}

# Examples (4 repos)
echo -e "${YELLOW}=== Examples ===${NC}"
clone_repo "example-counter"
clone_repo "example-bboard"
clone_repo "example-proofshare"
clone_repo "example-dex"

# Core Tools (5 repos)
echo -e "${YELLOW}=== Core Tools ===${NC}"
clone_repo "midnight-js"
clone_repo "compact"
clone_repo "midnight-docs"
clone_repo "midnight-indexer"
clone_repo "midnight-node-docker"

# Infrastructure (4 repos)
echo -e "${YELLOW}=== Infrastructure ===${NC}"
clone_repo "midnight-node"
clone_repo "midnight-ledger"
clone_repo "midnight-zk"
clone_repo "midnight-trusted-setup"

# Editor & Dev Tools (4 repos)
echo -e "${YELLOW}=== Editor & Dev Tools ===${NC}"
clone_repo "compact-tree-sitter"
clone_repo "compact-zed"
clone_repo "setup-compact-action"
clone_repo "upload-sarif-github-action"

# Community (4 repos)
echo -e "${YELLOW}=== Community ===${NC}"
clone_repo "community-hub"
clone_repo "midnight-awesome-dapps"
clone_repo "midnight-improvement-proposals"
clone_repo "midnight-template-repo"

# Crypto Libraries (3 repos)
echo -e "${YELLOW}=== Crypto Libraries ===${NC}"
clone_repo "halo2"
clone_repo "rs-merkle"
clone_repo "lfdt-project-proposals"

# Summary
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}✅ Cloning Complete!${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo -e "${YELLOW}Summary:${NC}"
echo "  Total repos cloned: ${total}"
echo "  Location: $(pwd)"
echo ""
echo -e "${YELLOW}Disk usage:${NC}"
du -sh . 2>/dev/null || echo "  (calculating...)"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "  1. Explore repos: cd $(pwd)"
echo "  2. Search all repos: grep -r 'pattern' */"
echo "  3. Update all: ./update_all_repos.sh"
echo ""
