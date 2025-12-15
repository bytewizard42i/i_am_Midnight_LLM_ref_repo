# Midnight Network - Known Issues & Workarounds

**Purpose**: Document known bugs, gotchas, and their solutions  
**Last Updated**: December 15, 2025

---

## ⚠️ Critical Issues

### Compiler Version 0.26.0 Has Bugs
| Severity | Affected | Status |
|----------|----------|--------|
| 🔴 Critical | compactc 0.26.0 | Active |

**Problem**: Compiler version 0.26.0 has known bugs that can cause compilation failures or incorrect code generation.

**Workaround**: 
```bash
# Use version 0.25.0 instead
compactc --version  # Should show 0.25.0
```

**Fix ETA**: TBD - check official releases

---

### Exact Pragma Versions Don't Work
| Severity | Affected | Status |
|----------|----------|--------|
| 🔴 Critical | Compact contracts | By design |

**Problem**: Using exact version in pragma causes issues:
```compact
// ❌ WRONG - exact version
pragma language_version 0.18;
```

**Workaround**:
```compact
// ✅ CORRECT - use range
pragma language_version >= 0.16 && <= 0.18;
```

---

### Network ID Must Be Set First
| Severity | Affected | Status |
|----------|----------|--------|
| 🔴 Critical | All Midnight.js apps | By design |

**Problem**: Any Midnight.js operation fails if network ID isn't set first.

**Workaround**:
```typescript
// MUST be the first line of your app
import { setNetworkId, NetworkId } from '@midnight-ntwrk/network-id';
setNetworkId(NetworkId.TestNet);

// Now other imports and code...
```

---

## 🟡 Hardware Limitations

### Haswell CPUs Cannot Run zkir
| Severity | Affected | Status |
|----------|----------|--------|
| 🟡 Medium | Intel 4th gen (Haswell) | Hardware limitation |

**Problem**: Zero-knowledge proof generation (zkir) requires CPU instructions not available on Haswell architecture (e.g., i7-4770).

**Affected Systems**:
- Intel 4th generation Core processors
- Optiplex 9020 and similar era machines

**Workaround**: 
- Use Skylake (6th gen) or newer CPU
- Or use a cloud VM with modern CPU for zkir operations

---

## 🟡 Development Gotchas

### Witness Values Must Be Disclosed
| Severity | Affected | Status |
|----------|----------|--------|
| 🟡 Medium | Compact contracts | By design |

**Problem**: Witness (private) values cannot directly assign to ledger (public) state.

```compact
// ❌ WRONG - direct assignment
witness getData(): Field;
export ledger data: Cell<Field>;

export circuit wrong(): [] {
  data = getData();  // ERROR!
}
```

**Workaround**:
```compact
// ✅ CORRECT - use disclose()
export circuit correct(): [] {
  data = disclose(getData());
}
```

**Exception**: Hash functions auto-disclose (no wrapper needed):
```compact
// ✅ OK without disclose() - hash protects privacy
data = persistentHash(getData());
```

---

### Counter Cannot Go Negative
| Severity | Affected | Status |
|----------|----------|--------|
| 🟡 Medium | Counter ADT | By design |

**Problem**: `Counter.decrement()` will fail if result would be negative.

**Workaround**:
```compact
// Check before decrementing
if (counter.lessThan(amount) == false) {
  counter -= amount;
}
```

---

### Map.lookup() Returns Maybe
| Severity | Affected | Status |
|----------|----------|--------|
| 🟢 Low | Map ADT | By design |

**Problem**: `lookup()` returns `Maybe<V>`, not `V` directly.

**Workaround**:
```compact
const result = myMap.lookup(key);
// Handle Maybe type appropriately
```

---

## 🟢 Environment Issues

### Docker Required for Compact Compiler
| Severity | Affected | Status |
|----------|----------|--------|
| 🟢 Low | Development setup | By design |

**Problem**: Compact compiler runs in Docker container.

**Workaround**: Ensure Docker is installed and running:
```bash
docker --version
# If not installed, install Docker Desktop or docker-ce
```

---

### Node.js Version Compatibility
| Severity | Affected | Status |
|----------|----------|--------|
| 🟢 Low | Midnight.js | Compatibility |

**Recommended**: Node.js 18.x or 20.x LTS

```bash
node --version  # Should be v18.x or v20.x
```

---

## 📋 Issue Tracking

For official issue tracking, see:
- [midnight-node issues](https://github.com/midnightntwrk/midnight-node/issues)
- [midnight-js issues](https://github.com/midnightntwrk/midnight-js/issues)
- [compact issues](https://github.com/midnightntwrk/compact/issues)
- [contributor-hub issues](https://github.com/midnightntwrk/contributor-hub/issues) (191 open)

---

## 🔄 Reporting New Issues

Found a new issue? 
1. Check [contributor-hub](https://github.com/midnightntwrk/contributor-hub/issues) first
2. Ask in [Discord](https://discord.com/invite/midnightnetwork)
3. Open issue in appropriate repo

---

**Maintained by**: bytewizard42i  
**Contributions welcome**: PR to add new known issues
