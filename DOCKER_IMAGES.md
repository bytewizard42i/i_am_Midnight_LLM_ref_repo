# Midnight Network - Official Docker Images

**Source**: Docker Hub `midnightnetwork/`  
**Last Updated**: January 3, 2026

---

## 📦 Official Images on Docker Hub

| Image | Description | Stars |
|-------|-------------|-------|
| `midnightnetwork/proof-server` | ZK proof generation server | 7 ⭐ |
| `midnightnetwork/midnight-node` | Midnight blockchain node | 3 ⭐ |
| `midnightnetwork/midnight-pubsub-indexer` | Event indexer for subscriptions | 1 ⭐ |
| `midnightnetwork/compactc` | Compact compiler (containerized) | 4 ⭐ |

---

## 🚀 Quick Start Commands

### Proof Server (Required for Development)

```bash
# Pull latest
docker pull midnightnetwork/proof-server:latest

# Run for testnet
docker run -d -p 6300:6300 \
  --name midnight-proof-server \
  midnightnetwork/proof-server \
  -- 'midnight-proof-server --network testnet'

# Check health
curl http://localhost:6300/health
```

### Midnight Node

```bash
# Pull latest
docker pull midnightnetwork/midnight-node:latest

# Run node (check docs for full config)
docker run -d \
  --name midnight-node \
  midnightnetwork/midnight-node
```

### Compact Compiler (Containerized)

```bash
# Pull latest
docker pull midnightnetwork/compactc:latest

# Compile a contract
docker run --rm -v $(pwd):/workspace midnightnetwork/compactc \
  compile /workspace/MyContract.compact /workspace/output/
```

### Pubsub Indexer

```bash
# Pull latest
docker pull midnightnetwork/midnight-pubsub-indexer:latest
```

---

## 🔍 Search for Updates

```bash
# Search Docker Hub for all midnight images
docker search midnightnetwork
```

---

## 📋 Notes

- **Proof Server**: Required for local development and testing
- **Node**: For running a full Midnight node (advanced)
- **Compactc**: Alternative to local `compact` CLI installation
- **Indexer**: For building apps that subscribe to blockchain events

---

**Maintained by**: bytewizard42i  
**Repository**: https://github.com/bytewizard42i/i_am_Midnight_LLM_ref_repo
