# Midnight Network - LLM Quick Reference

**For AI assistants - essential patterns in minimal context**

---

## ⚡ CRITICAL: Always Do First

```typescript
import { setNetworkId, NetworkId } from '@midnight-ntwrk/network-id';
setNetworkId(NetworkId.TestNet); // MUST be first line!
// 0=Undeployed, 1=DevNet, 2=TestNet, 3=MainNet
```

---

## ⚠️ Version Warnings

| Component | Use | Avoid |
|-----------|-----|-------|
| **Compiler** | `0.25.0` | `0.26.0` (bugs) |
| **Pragma** | `>= 0.16 && <= 0.18` | Exact versions |

---

## 📦 Essential Packages

```bash
npm install @midnight-ntwrk/midnight-js-contracts @midnight-ntwrk/midnight-js-types @midnight-ntwrk/ledger @midnight-ntwrk/compact-runtime @midnight-ntwrk/network-id
```

---

## 🔧 Deploy Contract

```typescript
import { deployContract } from '@midnight-ntwrk/midnight-js-contracts';

const deployed = await deployContract({
  contract: CompiledContract,
  initialState: { /* public */ },
  privateState: { /* private */ },
  providers: { wallet, fetcher, submitter, zkConfigProvider }
});
```

---

## 📞 Call Contract

```typescript
import { call } from '@midnight-ntwrk/midnight-js-contracts';

const result = await call(contractAddress, 'circuitName', {
  arguments: [arg1, arg2],
  witnesses: { witnessName: value },
  providers
});
```

---

## 📝 Compact Contract Template

```compact
pragma language_version >= 0.16 && <= 0.18;
import CompactStandardLibrary;

// Private (witness) - ZK protected
witness secretData(): Field;

// Public (ledger) - on-chain
export ledger counter: Counter;
export ledger owner: Cell<Field>;

// Constructor
export constructor init(initialOwner: Field): [] {
  owner = initialOwner;
}

// Circuit - use disclose() for witness→ledger
export circuit increment(amount: Field): [] {
  counter += disclose(amount);
}
```

---

## 🔑 The disclose() Rule

```compact
// ❌ WRONG - witness directly to ledger
export circuit wrong(): [] {
  ledgerVar = getData();  // ERROR!
}

// ✅ CORRECT - wrap with disclose()
export circuit correct(): [] {
  ledgerVar = disclose(getData());
}

// ✅ NO disclose needed - hash functions auto-disclose
data = persistentHash(secretData);  // OK without disclose()
```

---

## 📊 Ledger ADT Types

| Type | Key Methods |
|------|-------------|
| `Cell<T>` | `write(v)`, `read()`, `resetToDefault()` |
| `Counter` | `increment(n)`, `decrement(n)`, `read()` |
| `Set<T>` | `insert(e)`, `remove(e)`, `member(e)`, `size()` |
| `Map<K,V>` | `insert(k,v)`, `lookup(k)`, `member(k)`, `remove(k)` |
| `MerkleTree<n,T>` | `insert(v)`, `checkRoot(r)`, `isFull()` |

---

## 🪙 Token Operations

```typescript
// Create native token
import { nativeToken, createCoinInfo } from '@midnight-ntwrk/ledger';
const coin = createCoinInfo(nativeToken(), 1000n);

// Custom token
const customType = tokenType('my-domain', contractAddress);
```

---

## 🔐 Signatures (BIP-340)

```typescript
import { sampleSigningKey, signData, verifySignature, signatureVerifyingKey } from '@midnight-ntwrk/ledger';

const key = sampleSigningKey();
const pubKey = signatureVerifyingKey(key);
const sig = signData(key, data);
const valid = verifySignature(pubKey, data, sig);
```

---

## 📁 File Structure

```
my-dapp/
├── contract/
│   └── src/
│       └── MyContract.compact
├── src/
│   ├── index.ts
│   └── providers.ts
├── package.json
└── tsconfig.json
```

---

## 🔗 Quick Links

- **Docs**: https://docs.midnight.network
- **GitHub**: https://github.com/midnightntwrk
- **Discord**: https://discord.com/invite/midnightnetwork
- **Tutorials**: https://youtube.com/playlist?list=PL_ynGy6ajzU-olXFF6gOAY1VF2n8hxgX4

---

**Full Reference**: See `i_am_Midnight_LLM_ref/MIDNIGHT_COMPLETE_SINGLE_FILE.md`
