# Description

Implementing a web3dart connection with browser extension (Metamask etc)

# Installation

pubspec.yaml

```yaml
dependencies:
    web3dart_ethereum:
        git: https://github.com/inveker/web3dart_ethereum
```

# Usage

## Web3EthereumCredentials

```dart
final web3ethereum = Web3Ethereum();
final accounts = await web3ethereum.getAccounts();
final credentials = Web3EthereumCredentials(web3ethereum, addressHex: accounts.first);
```

## Web3EthereumRpc

```dart
final web3ethereum = Web3Ethereum();
final web3ethereumRpc = Web3EthereumRpc(web3ethereum);
final web3client = Web3Client.custom(web3ethereumRpc);
```