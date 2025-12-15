# Midnight Network Community Resources

**Last Updated:** December 15, 2025  
**Curated By:** AgenticDID.io Team

A curated list of community-built tools, templates, and examples for Midnight Network development.

---

## 🚀 Quick Start Templates

| Repo | Description | Updated | Stars |
|------|-------------|---------|-------|
| [create-mn-app](https://github.com/Olanetsoft/create-mn-app) | Scaffold Midnight Network applications (like create-react-app) | Nov 2025 | - |
| [midnight-quick-starter](https://github.com/luislucena16/midnight-quick-starter) | Modern dApp template with contracts, backend, CLI, and frontend | Oct 2025 | - |
| [midnight-devkit](https://github.com/depapp/midnight-devkit) | Comprehensive developer toolkit for privacy-first blockchain dev | Aug 2025 | - |

---

## 🏗️ Infrastructure & Tools

| Repo | Description | Updated |
|------|-------------|---------|
| [midnight-local-network](https://github.com/bricktowers/midnight-local-network) | Local test network setup by Brick Towers | Dec 2025 |
| [midnight-ntwrk/releases](https://github.com/midnight-ntwrk/releases) | Official Midnight releases (proof server, node, etc.) | Oct 2025 |

---

## 🎮 Example dApps

### Brick Towers Collection
Brick Towers is an active Midnight builder with several reference implementations:

| Repo | Description | Use Case |
|------|-------------|----------|
| [midnight-seabattle](https://github.com/bricktowers/midnight-seabattle) | Sea Battle Game on Midnight | Gaming / ZK proofs |
| [midnight-identity](https://github.com/bricktowers/midnight-identity) | Identity Verification | KYC / Credentials |
| [midnight-rwa](https://github.com/bricktowers/midnight-rwa) | Real World Assets | Tokenization |

### Other Community Examples

| Repo | Description |
|------|-------------|
| [midnight-frontend](https://github.com/Prashant-koi/midnight-frontend) | Anonymous talent matching platform |

---

## 📚 Official Resources

### Documentation
- **Docs**: https://docs.midnight.network
- **Website**: https://midnight.network
- **Discord**: https://discord.gg/midnightnetwork

### Official Repos (in this collection)
See `ref_*` directories for official Midnight repositories including:
- `ref_midnight-docs-johns-copy` - Documentation source
- `ref_midnight-js-johns-copy` - JavaScript SDK
- `ref_example-*` - Official example apps

---

## 🔧 Development Notes

### Current Testnet
- **Network**: Testnet_02
- **Compiler**: compactc 0.26.0 (but 0.25.0 is more stable)
- **Language**: Minokawa v0.18.0+

### Known Issues
- Proof Server 4.0.0 requires AVX-512 CPU (use 3.0.7 for older CPUs)
- See `COMPATIBILITY_MATRIX_VERIFIED.md` for full compatibility info

### Pragma Format
```compact
pragma language_version >= 0.16 && <= 0.18;
```
**Note**: Use range format, NOT exact version.

---

## 🤝 Contributing

Found a great Midnight community project? Submit a PR to add it here!

---

*Part of the i_am_Midnight_LLM_ref_repo collection*
