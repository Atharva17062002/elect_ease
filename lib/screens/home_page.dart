import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

import '../services/functions.dart';
import '../utils/constants.dart';
import 'election_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Client? httpClient;
  Web3Client? ethClient;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(infura_url, httpClient!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Start Election')),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: 'Enter candidate name',
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 35,
              child: ElevatedButton(
                onPressed: ()  {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ElectionInfo(
                          ethClient: ethClient!,
                          electionName: controller.text),
                    ),
                  );
                  // if (controller.text.isNotEmpty) {
                  //   await startElection(controller.text, ethClient!);
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => ElectionInfo(
                  //           ethClient: ethClient!,
                  //           electionName: controller.text),
                  //     ),
                  //   );
                  // }
                },
                child: const Text('Start Election'),
              ),
            )
          ],
          // mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
