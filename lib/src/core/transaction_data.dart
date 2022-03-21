part of 'package:web3dart/web3dart.dart';

class TransactionData {
  final Web3Client client;
  final DeployedContract contract;
  final ContractFunction function;
  final List parameters;
  final Transaction transaction;

  TransactionData({
    required this.client,
    required this.contract,
    required this.function,
    this.parameters = const [],
    required this.transaction,
  });

  @override
  String toString() {
    return 'TransactionData(contract: $contract, function: $function, parameters: $parameters, transaction: $transaction)';
  }

  TransactionData copyWith({
    Web3Client? client,
    DeployedContract? contract,
    ContractFunction? function,
    List? parameters,
    Transaction? transaction,
  }) {
    return TransactionData(
      client: client ?? this.client,
      contract: contract ?? this.contract,
      function: function ?? this.function,
      parameters: parameters ?? this.parameters,
      transaction: transaction ?? this.transaction,
    );
  }

  Future<String> sendTransaction(Credentials credentials, [int? chainId]) {
    return client.sendTransaction(
      credentials,
      transaction,
      chainId: chainId,
      fetchChainIdFromNetworkId: chainId == null,
    );
  }

  Future<BigInt> estimateGas(
    Credentials credentials, {
    EtherAmount? gasPrice,
    int? chainId,
  }) {
    return client.estimateGas(
      sender: transaction.from,
      to: transaction.to,
      value: transaction.value,
      amountOfGas:
          transaction.maxGas != null ? BigInt.from(transaction.maxGas!) : null,
      gasPrice: gasPrice ?? transaction.gasPrice,
      maxFeePerGas: transaction.maxFeePerGas,
      maxPriorityFeePerGas: transaction.maxPriorityFeePerGas,
      data: transaction.data,
    );
  }
}
