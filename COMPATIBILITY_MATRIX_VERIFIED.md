# Midnight Network Compatibility Matrix - Verified

**Source:** https://docs.midnight.network/relnotes/support-matrix  
**Last Updated:** March 14, 2026  
**Network:** Preprod  
**Verified By:** AgenticDID.io Team (Penny on artpro WSL)

---

## ✅ Official Compatibility Matrix (March 2026)

| Component | Latest Stable | Our Version | Status | Notes |
|-----------|--------------|-------------|--------|-------|
| **Network** | Preprod | Preprod | ✅ | Current network (not "Testnet_02") |
| **Compactc** | 0.29.0 | 0.29.0 | ✅ | Language 0.21.0. Installed on artpro WSL |
| **Language Version** | 0.21.0 | >= 0.20 | ✅ | `pragma language_version >= 0.20;` |
| **Compact-runtime** | 0.14.0 | 0.14.0 | ✅ | npm package |
| **Compact-js** | 2.4.3 | 2.4.3 | ✅ | npm package |
| **Ledger** | 7.0.3 | 7.0.3 | ✅ | `@midnight-ntwrk/ledger-v7` |
| **Midnight.js** | 3.2.0 | 3.2.0 | ✅ | All `@midnight-ntwrk/midnight-js-*` packages |
| **Wallet SDK Facade** | 2.0.0 | 2.0.0 | ✅ | Major bump from 1.0.0 in March 2026 |
| **Wallet SDK HD** | 3.0.1 | 3.0.1 | ✅ | |
| **Wallet SDK Shielded** | 2.0.0 | 2.0.0 | ✅ | Major bump from 1.0.0 |
| **Wallet SDK Unshielded** | 2.0.0 | 2.0.0 | ✅ | Major bump from 1.0.0 |
| **Wallet SDK Dust** | 2.0.0 | 2.0.0 | ✅ | Major bump from 1.0.0 |
| **Proof Server** | 7.0.0 | 7.0.0 | ✅ | Docker: `midnightntwrk/proof-server:7.0.0` |
| **Token** | tDUST | tDUST | ✅ | NOT tNight |
| **Faucet** | — | — | ✅ | https://faucet.preprod.midnight.network/ |

---

## 🔢 Compiler → Language Version Mapping

| Compiler | Language | Notes |
|----------|----------|-------|
| 0.25.0 | 0.17.0 | Stable, older |
| 0.26.0 | 0.18.0 | Had bugs, now superseded |
| 0.28.0 | 0.20.0 | Major jump |
| **0.29.0** | **0.21.0** | **← LATEST, use this** |

---

## 📦 npm Package Versions (Verified March 14, 2026)

### Frontend DApp Dependencies (browser)
```json
{
  "@midnight-ntwrk/compact-runtime": "0.14.0",
  "@midnight-ntwrk/compact-js": "2.4.3",
  "@midnight-ntwrk/ledger-v7": "7.0.3",
  "@midnight-ntwrk/midnight-js-contracts": "3.2.0",
  "@midnight-ntwrk/midnight-js-http-client-proof-provider": "3.2.0",
  "@midnight-ntwrk/midnight-js-indexer-public-data-provider": "3.2.0",
  "@midnight-ntwrk/midnight-js-level-private-state-provider": "3.2.0",
  "@midnight-ntwrk/midnight-js-network-id": "3.2.0",
  "@midnight-ntwrk/midnight-js-types": "3.2.0",
  "@midnight-ntwrk/midnight-js-utils": "3.2.0",
  "@midnight-ntwrk/wallet-sdk-facade": "2.0.0",
  "@midnight-ntwrk/wallet-sdk-hd": "3.0.1",
  "@midnight-ntwrk/wallet-sdk-shielded": "2.0.0",
  "@midnight-ntwrk/wallet-sdk-unshielded-wallet": "2.0.0",
  "@midnight-ntwrk/wallet-sdk-dust-wallet": "2.0.0",
  "rxjs": "^7.8.0"
}
```

---

## 🔗 Lace Wallet Browser Integration (Confirmed)

**Source:** MCP TypeScript search — confirmed from working DApps:
- `ErickRomeroDev/naval-battle-game_v2` (battle-naval.tsx)
- `midnames/core` (api.ts)
- `nel349/midnight-bank` (DeployedAccountProviderContext.tsx)

### Correct Pattern
```typescript
// The Lace Midnight extension injects window.midnight.mnLace
// NOT window.midnight directly!
const mnLace = (window as any).midnight?.mnLace;

// Check if Lace is available
function isLaceAvailable(): boolean {
  return typeof window !== 'undefined' && !!(window as any).midnight?.mnLace;
}

// Connect to wallet
const compatibleConnectorAPIVersion = '1.x';
const wallet = await mnLace.enable(compatibleConnectorAPIVersion);

// Get wallet state (includes coinPublicKey and serviceUriConfig)
const walletState = await wallet.state();
const publicKey = walletState?.coinPublicKey;

// The wallet also provides service URIs (indexer, proof server, node)
// which can be used instead of hardcoding them
```

### Common Mistakes
- ❌ `window.midnight.enable()` — wrong API path
- ❌ `window.midnight.getPublicKey()` — doesn't exist
- ✅ `window.midnight.mnLace.enable('1.x')` — correct
- ✅ `wallet.state().coinPublicKey` — correct way to get public key

---

## 🌐 Preprod Network URLs

```
Indexer (GraphQL):  https://indexer.preprod.midnight.network/api/v3/graphql
Indexer (WS):       wss://indexer.preprod.midnight.network/api/v3/graphql/ws
RPC Node:           https://rpc.preprod.midnight.network
Faucet:             https://faucet.preprod.midnight.network/
Proof Server:       http://localhost:6300 (local Docker)
```

---

## 🚨 Known Issues

### Proof Server CPU Compatibility (Still Relevant)
```
Proof Server 7.0.0 may require modern CPU instructions.
- Intel Haswell (i7-4770) on Chuck: Too old for zkir generation
- Needs Skylake (6th gen) or newer for full ZK proof generation
- ARM Linux binary now available as of compiler 0.29.0
```

### Midnight MCP Hosted Compiler (March 2026)
```
Issue filed: https://github.com/Olanetsoft/midnight-mcp/issues/35
- MCP's hosted compiler runs language 0.18.0 (compiler ~0.26.0)
- Cannot validate contracts using pragma >= 0.20
- Workaround: use local `compact compile +0.29.0` instead
- MCP's static analysis also misses ledger declarations
```

---

## 🔧 Compile Command

```bash
# Compile a contract (using installed compiler 0.29.0)
compact compile +0.29.0 src/contracts/my-contract.compact src/managed/my-contract

# Update compiler (needs GitHub token)
GITHUB_TOKEN=<token> compact update
```

---

## 📊 Full Compatibility Status (March 2026)

```
✅ VERIFIED WORKING:
- Compact compiler 0.29.0 (language 0.21.0)
- Pragma: >= 0.20 (open-ended, forward-compatible)
- All midnight-js packages at 3.2.0
- All wallet-sdk packages at 2.0.0
- compact-runtime 0.14.0, compact-js 2.4.3, ledger-v7 7.0.3
- Proof server 7.0.0 (Docker)
- Preprod network
- Lace wallet integration via window.midnight.mnLace

⚠️ KNOWN LIMITATIONS:
- Chuck (Haswell i7-4770): Too old for zkir — use artpro or cloud
- Midnight MCP hosted compiler: Stuck on 0.18.0 (issue #35 filed)
- MCP static analysis: Misses ledger declarations
```

---

**Last Verified:** March 14, 2026  
**Systems:** ASUS Pro Art (artpro) WSL, Chuck (Ubuntu 24.04)  
**Network:** Preprod  
**Status:** ✅ All compatible and working
