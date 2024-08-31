# PayPal Smart Contract Deployment

This README provides the necessary steps to clean, compile, deploy, and verify your PayPal smart contract on the Amoy testnet using Hardhat.

## Prerequisites

- **Node.js** and **npm** installed.
- **Hardhat** installed.
- An **Infura project ID** for connecting to the Amoy testnet.
- A **private key** for the deploying account, stored securely in a `.env` file.

## Setup

1. **Install Dependencies**

   Ensure all dependencies are installed:

   ```bash
   npm install
   ```

2. **Configure Environment Variables**

   Create a `.env` file in the root of your project and add the following:

   ```plaintext
   INFURA_URL=https://polygon-amoy.infura.io/v3/YOUR_INFURA_PROJECT_ID
   PRIVATE_KEY=your_private_key
   ETHERSCAN_API_KEY=your_etherscan_api_key (optional)
   ```

   Replace `YOUR_INFURA_PROJECT_ID` and `your_private_key` with your actual Infura project ID and private key.

## Commands

### 1. Clean the Project

Before compiling, it's a good idea to clean the project to remove any previous build artifacts:

```bash
npx hardhat clean
```

### 2. Compile the Contracts

Compile your smart contracts:

```bash
npx hardhat compile
```

### 3. Deploy the Contract

Deploy the contract using Hardhat Ignition:

```bash
npx hardhat ignition deploy ignition/modules/Deploy.js --network amoy
```

The contract will be deployed to the Amoy testnet. After deployment, you will receive a contract address.

### 4. Verify the Contract

To verify the contract on the Amoy testnet, use the following command. Replace the address with the actual deployed contract address if different:

```bash
npx hardhat verify 0xC218f04895585379438eBdAf99E55077B967801A --network amoy
```

### 5. View the Contract on Polygonscan

You can view your deployed contract on the Amoy testnet Polygonscan using the following link:

[View Contract on Amoy Polygonscan](https://amoy.polygonscan.com/address/0xC218f04895585379438eBdAf99E55077B967801A#code)

[View Contract on Amoy Polygonscan](https://amoy.polygonscan.com/address/0xb6b55d30fabE09863cF1E1d672D166268c034F23#code)

## Contract Address

Your deployed contract address is:

```plaintext
0xC218f04895585379438eBdAf99E55077B967801A
```

```plaintext
0xb6b55d30fabE09863cF1E1d672D166268c034F23
```

Make sure to replace this address with the one provided after your deployment if it's different.
