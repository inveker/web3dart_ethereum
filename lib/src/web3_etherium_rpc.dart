import 'package:web3_ethereum/web3_ethereum.dart';
import 'package:web3dart/json_rpc.dart';

/// Custom RpcService compatible with the web3dart library.
/// Proxy requests to the [ethereum] JavaScript object through the web3_ethereum library.
///
/// Usage example:
/// ```dart
/// final web3ethereum = Web3Ethereum();
/// final web3ethereumRpc = Web3EthereumRpc(web3ethereum);
/// final web3client = Web3Client.custom(web3ethereumRpc);
/// ```
class Web3EthereumRpc extends RpcService {
  final Web3Ethereum _web3ethereum;

  Web3EthereumRpc(this._web3ethereum);

  @override
  Future<RPCResponse> call(String function, [List? params]) async {
    final res = await _web3ethereum.request(function, params: params);
    return RPCResponse(0, res);
  }
}
