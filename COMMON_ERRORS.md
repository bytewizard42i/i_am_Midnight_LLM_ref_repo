# Midnight Network - Common Errors & Solutions

**Purpose**: Quick lookup for error messages and fixes  
**Format**: Error → Cause → Solution  
**Last Updated**: December 15, 2025

---

## 🔴 Compilation Errors

### "witness value not disclosed"
```
Error: Cannot assign witness value to ledger state without disclosure
```

**Cause**: Trying to assign a witness (private) value directly to ledger (public) state.

**Solution**:
```compact
// ❌ Wrong
export circuit bad(): [] {
  ledgerVar = witnessFunction();
}

// ✅ Correct - wrap with disclose()
export circuit good(): [] {
  ledgerVar = disclose(witnessFunction());
}
```

---

### "pragma version mismatch"
```
Error: Language version X.XX not supported
```

**Cause**: Using exact version or unsupported version in pragma.

**Solution**:
```compact
// ❌ Wrong
pragma language_version 0.18;

// ✅ Correct - use range
pragma language_version >= 0.16 && <= 0.18;
```

---

### "unknown import"
```
Error: Cannot resolve import 'SomeLibrary'
```

**Cause**: Missing or misspelled import.

**Solution**:
```compact
// Standard library import
import CompactStandardLibrary;

// Check spelling and available libraries
```

---

### "type mismatch"
```
Error: Expected type X but got type Y
```

**Cause**: Incompatible types in assignment or function call.

**Solution**: Check type annotations and ensure consistency:
```compact
// Types must match
ledger counter: Counter;      // Counter type
ledger value: Cell<Field>;    // Cell<Field> type
ledger flag: Cell<Boolean>;   // Cell<Boolean> type
```

---

## 🔴 Runtime Errors

### "network id not set"
```
Error: Network ID must be set before any Midnight operations
```

**Cause**: Forgot to call `setNetworkId()` first.

**Solution**:
```typescript
// MUST be first line
import { setNetworkId, NetworkId } from '@midnight-ntwrk/network-id';
setNetworkId(NetworkId.TestNet);

// Then other code...
```

---

### "provider not configured"
```
Error: Missing required provider: wallet/fetcher/submitter
```

**Cause**: Incomplete provider configuration.

**Solution**:
```typescript
const providers = {
  wallet: walletProvider,
  fetcher: fetcherProvider,
  submitter: submitterProvider,
  zkConfigProvider: zkConfigProvider
};

await deployContract({ contract, initialState, privateState, providers });
```

---

### "insufficient funds"
```
Error: Insufficient tDUST balance for transaction
```

**Cause**: Wallet doesn't have enough tDUST tokens.

**Solution**:
1. Get tDUST from faucet: https://midnight.network/faucet
2. Check wallet balance before transactions
3. Ensure correct network (TestNet vs DevNet)

---

### "transaction failed"
```
Error: Transaction submission failed
```

**Cause**: Various - network issues, invalid state, gas issues.

**Solution**:
1. Check network connectivity
2. Verify contract address is correct
3. Check transaction parameters
4. Review indexer status

---

### "contract not found"
```
Error: Contract at address X not found
```

**Cause**: Wrong address or contract not deployed.

**Solution**:
```typescript
// Verify address format
console.log('Contract address:', contractAddress);

// Check if deployed
const state = await getPublicStates(contractAddress, indexer);
```

---

## 🔴 Wallet Errors

### "wallet not connected"
```
Error: No wallet connection established
```

**Cause**: Lace wallet not connected or extension not installed.

**Solution**:
```typescript
// Check if wallet available
if (typeof window.midnight?.mnLace === 'undefined') {
  console.error('Lace wallet not installed');
  return;
}

// Request connection
await window.midnight.mnLace.enable();
```

---

### "user rejected"
```
Error: User rejected the transaction
```

**Cause**: User clicked "Reject" in wallet popup.

**Solution**: Handle rejection gracefully:
```typescript
try {
  const result = await call(address, circuit, options);
} catch (error) {
  if (error.message.includes('rejected')) {
    console.log('User cancelled transaction');
  }
}
```

---

## 🔴 Proof Errors

### "proof generation failed"
```
Error: Failed to generate zero-knowledge proof
```

**Cause**: Circuit constraints violated or ZK config issue.

**Solution**:
1. Verify witness values are valid
2. Check circuit logic for edge cases
3. Ensure zkConfigProvider is configured
4. Check CPU compatibility (needs Skylake+)

---

### "proof verification failed"
```
Error: Proof verification failed
```

**Cause**: Invalid proof or tampered data.

**Solution**:
1. Regenerate proof with correct inputs
2. Verify circuit hasn't changed
3. Check for data corruption

---

## 🟡 Warning Messages

### "deprecated API"
```
Warning: This API is deprecated, use X instead
```

**Solution**: Update to recommended API:
```typescript
// Check MIDNIGHT_COMPLETE_SINGLE_FILE.md for current APIs
// Or docs.midnight.network for latest
```

---

### "state sync pending"
```
Warning: Local state may be out of sync
```

**Solution**:
```typescript
// Force refresh state
const state = await getPublicStates(address, indexer);
```

---

## 🔧 Debug Tips

### Enable Verbose Logging
```typescript
// Add to your code for debugging
console.log('Contract address:', address);
console.log('Circuit name:', circuitName);
console.log('Arguments:', JSON.stringify(args));
console.log('Providers configured:', Object.keys(providers));
```

### Check Network Status
```typescript
import { getNetworkId, NetworkId } from '@midnight-ntwrk/network-id';
console.log('Current network:', getNetworkId());
// 0=Undeployed, 1=DevNet, 2=TestNet, 3=MainNet
```

### Verify Contract State
```typescript
const { ledger, blockNumber } = await getPublicStates(address, indexer);
console.log('Block number:', blockNumber);
console.log('Ledger state:', ledger);
```

---

## 📚 More Help

- **Discord**: https://discord.com/invite/midnightnetwork
- **Docs**: https://docs.midnight.network
- **Full Reference**: See `MIDNIGHT_COMPLETE_SINGLE_FILE.md`

---

**Maintained by**: bytewizard42i  
**Contributions welcome**: PR to add new errors and solutions
