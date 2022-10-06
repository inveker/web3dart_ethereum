import 'dart:typed_data';

import 'package:web3_ethereum/web3_ethereum.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

/// Custom Credentials compatible with web3dart library.
/// Responsible for signing/sending transactions to the network using the web3_ethereum library.
///
/// Usage example:
/// ```dart
/// final web3ethereum = Web3Ethereum();
/// final accounts = await web3ethereum.getAccounts();
/// final credentials = Web3EthereumCredentials(web3ethereum, addressHex: accounts.first);
/// ```
class Web3EthereumCredentials extends CredentialsWithKnownAddress implements CustomTransactionSender {
  @override
  final EthereumAddress address;

  final Web3Ethereum _web3ethereum;

  Web3EthereumCredentials(
    this._web3ethereum, {
    required String addressHex,
  }) : address = EthereumAddress.fromHex(addressHex);

  @override
  Future<String> sendTransaction(Transaction transaction) async {
    return _web3ethereum.request<String>(
      'eth_sendTransaction',
      params: [
        {
          'from': address.hex,
          'to': transaction.to?.hex,
          'gasPrice': _bigIntToQuantity(transaction.gasPrice?.getInWei),
          'gas': _intToQuantity(transaction.maxGas),
          'value': _bigIntToQuantity(transaction.value?.getInWei),
          'data': _bytesToData(transaction.data),
        },
      ],
    );
  }

  @override
  Future<MsgSignature> signToSignature(Uint8List payload, {int? chainId, bool isEIP1559 = false}) {
    throw UnsupportedError('Signing raw payloads is not supported');
  }
}

// Auxiliary local utilities

String? _bigIntToQuantity(BigInt? int) {
  return int != null ? '0x${int.toRadixString(16)}' : null;
}

String? _intToQuantity(int? int) {
  return int != null ? '0x${int.toRadixString(16)}' : null;
}

String? _bytesToData(Uint8List? data) {
  return data != null ? bytesToHex(data, include0x: true, padToEvenLength: true) : null;
}
