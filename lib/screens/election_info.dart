import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';

import '../services/functions.dart';

class ElectionInfo extends StatefulWidget {
  const ElectionInfo(
      {super.key, required this.ethClient, required this.electionName});

  final Web3Client ethClient;
  final String electionName;

  @override
  State<ElectionInfo> createState() => _ElectionInfoState();
}

class _ElectionInfoState extends State<ElectionInfo> {
  TextEditingController addCanditateController = TextEditingController();
  TextEditingController authoriseVoterController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Election Info')),
        body: Container(
            padding: EdgeInsets.all(14),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Column(
                      children: [
                        FutureBuilder<List>(
                          future: getCandidateNumber(widget.ethClient),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            if (snapshot.hasData) {
                              return Text(snapshot.data![0].toString(),
                                  style: const TextStyle(fontSize: 50));
                            } else {
                              return const Text('0',
                                  style: TextStyle(fontSize: 20));
                            }
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        FutureBuilder<List>(
                          future: getTotalVotes(widget.ethClient),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            if (snapshot.hasData) {
                              return Text(snapshot.data![0].toString(),
                                  style: const TextStyle(fontSize: 50));
                            } else {
                              return const Text('0',
                                  style: TextStyle(fontSize: 20));
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: addCanditateController,
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: 'Enter candidate name',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        addCandidate(
                            addCanditateController.text, widget.ethClient);
                      },
                      child: const Text('Add Candidate'),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: authoriseVoterController,
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: 'Enter candidate name',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        authoriseVoter(
                            authoriseVoterController.text, widget.ethClient);
                      },
                      child: const Text('Add Voter'),
                    )
                  ],
                ),
                Divider(),
                FutureBuilder<List>(
                  future: getCandidateNumber(widget.ethClient),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          for (int i = 0; i < snapshot.data![0]; i++)
                            FutureBuilder<List>(
                              future: candidateInfo(i, widget.ethClient),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else {
                                  return ListTile(
                                    title:
                                        Text('Name: ${snapshot.data![0][0]}'),
                                    subtitle:
                                        Text('Votes: ${snapshot.data![0][1]}'),
                                    trailing: ElevatedButton(
                                        onPressed: () {
                                          vote(i, widget.ethClient);
                                        },
                                        child: const Text('Vote')),
                                  );
                                }
                              },
                            ),
                        ],
                      );
                    } else {
                      return const Text('No Candidates', style: TextStyle(fontSize: 20));
                    }
                  },
                ),
              ],
            )));
  }
}
