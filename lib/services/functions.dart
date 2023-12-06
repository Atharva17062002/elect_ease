import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

import '../utils/constants.dart';

Future<DeployedContract>loadContract() async{
  String abiCode = await rootBundle.loadString("assets/abi.json");
  String contractAddress = "0xd9145CCE52D386f254917e481eB44e9943F39138";
  //Change contractAddress to your contract address

  final contract = DeployedContract(ContractAbi.fromJson(abiCode, "Election"), EthereumAddress.fromHex(contractAddress));
  return contract;
}

Future<String> callFunction(String functionName, List<dynamic>args, Web3Client ethClient, String privateKey) async{
  EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
  DeployedContract contract = await loadContract();
  final ethFunction = contract.function(functionName);
  final result = await ethClient.sendTransaction(credentials, Transaction.callContract(
    contract: contract, function: ethFunction, parameters: args),chainId: null, fetchChainIdFromNetworkId: true );
  return result;
}

Future<String>startElection(String name, Web3Client ethClient) async{
  var response = await callFunction("startElection", [name], ethClient, owner_private_key);
  print('Election Started successfully');
  return response;
}

Future<String>addCandidate(String name, Web3Client ethClient) async{
  var response = await callFunction("addCandidate", [name], ethClient, owner_private_key);
  print('Candidate added successfully');
  return response;
}

Future<String>authoriseVoter(String address, Web3Client ethClient) async{
  var response = await callFunction("authoriseVoter", [EthereumAddress.fromHex(address)], ethClient, owner_private_key);
  print('Voter authorised successfully');
  return response;
}

Future<List>getCandidateNumber(Web3Client ethClient) async{
  List<dynamic> response = await ask("getCandidateNumber", [], ethClient);
  print('Voter authorised successfully');
  return response;
}

Future<List<dynamic>> ask(String functionName, List<dynamic> args, Web3Client ethClient) async{
  final contract = await loadContract();
  final ethFunction = contract.function(functionName);
  final result = await ethClient.call(contract: contract, function: ethFunction, params: args);
  return result;
}

Future<String> vote(int candidateId, Web3Client ethClient) async{
  var response = await callFunction("vote", [BigInt.from(candidateId)], ethClient, voter_private_key);
  print('Voted successfully');
  return response;
}