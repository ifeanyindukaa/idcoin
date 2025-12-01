# idcoin

IdCoin is a simple fungible token implemented as a Clarity smart contract and managed with [Clarinet](https://docs.hiro.so/clarinet/). It is intended as a minimal, educational example of a SIP-010 style fungible token on the Stacks blockchain.

## Project structure

- `Clarinet.toml` – Clarinet project configuration.
- `contracts/idcoin.clar` – IdCoin Clarity smart contract.
- `settings/` – Network configuration (Devnet, Testnet, Mainnet).
- `tests/idcoin.test.ts` – Vitest-based simulation tests for the contract (initial scaffold).
- `package.json`, `tsconfig.json`, `vitest.config.ts` – TypeScript / test tooling.

## Prerequisites

- [Clarinet](https://docs.hiro.so/clarinet/how-to-guides/how-to-set-up-local-development-environment) installed and available on your `PATH`.
- Node.js (>= 18) and npm or pnpm for running tests.

You can verify your Clarinet installation with:

```bash path=null start=null
clarinet --version
```

## Getting started

Clone the repository and move into the project directory:

```bash path=null start=null
git clone <your-fork-or-origin-url>
cd idcoin
```

### Check the contract

Run Clarinet’s static checks against all contracts in `contracts/`:

```bash path=null start=null
clarinet check
```

If everything is configured correctly, this should complete without errors.

### Run tests

Install Node dependencies and run the Vitest test suite:

```bash path=null start=null
npm install
npm test
```

You can extend `tests/idcoin.test.ts` with additional tests for transfer, minting, and balance queries using the Clarinet JS SDK.

## Contract overview

The IdCoin contract is defined in `contracts/idcoin.clar` and provides:

- A fungible token named `IdCoin` with symbol `ID` and `u6` decimals.
- A `transfer` function for moving tokens between principals.
- A `mint` function for minting new tokens to a recipient (restricted to the contract principal).
- Read-only helpers for metadata and balances:
  - `get-name`
  - `get-symbol`
  - `get-decimals`
  - `get-total-supply`
  - `get-balance` (per principal)

### Key functions (high-level)

- `transfer(amount, sender, recipient)`
  - Requires that `tx-sender` matches `sender`.
  - Uses `ft-transfer?` under the hood.

- `mint(amount, recipient)`
  - Restricted to the contract principal (intended to be called by the contract itself or via administrative flows).
  - Mints `amount` IdCoin to `recipient` and updates `total-supply`.

## Development workflow

Common Clarinet commands you may find useful:

```bash path=null start=null
# Check contracts
clarinet check

# Open a REPL for interactive development
clarinet console

# Generate a new contract (already used to create idcoin)
clarinet contract new <name>
```

For more details, see the official Clarinet documentation: https://docs.hiro.so/clarinet/.
