# Medical Records — On-Chain Smart Contract

A Solidity smart contract for storing and retrieving patient medical records on the Ethereum blockchain. Each patient's history is kept as an append-only list of structured records, making entries tamper-evident and verifiable on-chain.

This is a proof-of-concept exploring how electronic health records can be represented and managed with smart contracts.

## What it does

- Stores medical records on-chain, keyed by patient ID
- Lets a record be added for a patient (appointment date, doctor notes, diagnosis, prescriptions, follow-up plan, doctor ID)
- Returns the full history of records for a given patient
- Keeps records as an append-only array per patient, so history is preserved

## Tech stack

- **Solidity** `^0.8.0` — smart contract
- **ethers.js** & **web3.js** — deployment scripts (TypeScript)
- **Remix IDE** — compilation and deployment environment

## Contract overview

`MedicalRecords.sol` exposes a `Record` struct and two functions:

```solidity
struct Record {
    uint256 appointmentDate;
    string  doctorNotes;
    string  diagnosis;
    string  prescriptions;
    string  followUpPlan;
    string  doctorId;
}
```

| Function | Type | Description |
| --- | --- | --- |
| `addRecord(patientId, appointmentDate, doctorNotes, diagnosis, prescriptions, followUpPlan, doctorId)` | write | Appends a new record to a patient's history |
| `getRecords(patientId)` | view | Returns the array of all records for a patient |

Records are stored in a private mapping `string => Record[]`, where the key is the patient ID.

## Project structure

```
contracts/
  MedicalRecords.sol      # the smart contract
scripts/
  deploy_with_ethers.ts   # deploy via ethers.js
  deploy_with_web3.ts     # deploy via web3.js
  ethers-lib.ts           # ethers helper
  web3-lib.ts             # web3 helper
```

## Running it

The contract can be compiled and deployed from [Remix IDE](https://remix.ethereum.org/):

1. Open the project in Remix.
2. Compile `contracts/MedicalRecords.sol`.
3. Deploy using the injected provider (e.g. MetaMask) or a Remix VM, or run one of the deploy scripts in `/scripts`.
4. Call `addRecord(...)` to store a record and `getRecords(patientId)` to read a patient's history.

## Possible improvements

This is an early version. Natural next steps for a real-world system:

- **Access control** — restrict who can add or read records (e.g. role-based access for doctors/patients), since the current version is open by design for demonstration.
- **Events** — emit an event on each new record for easier off-chain indexing.
- **Off-chain storage** — store large notes off-chain (e.g. IPFS) and keep only hashes on-chain to reduce gas costs and protect sensitive data.
- **Patient consent & ownership** — tie records to patient-owned addresses.
