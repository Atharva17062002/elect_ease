import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';

class ElectionInfo extends StatefulWidget {
  const ElectionInfo({super.key, required this.ethClient, required this.electionName});

  final Web3Client ethClient;
  final String electionName;

  @override
  State<ElectionInfo> createState() => _ElectionInfoState();
}

class _ElectionInfoState extends State<ElectionInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Election Info')),
      body: Center(
        child: Text('Election Info'),
      ),
    );
  }
}
