import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final TextEditingController messageController =
  TextEditingController();

  void sendMessage() async {

    if (messageController.text.isEmpty) return;

    await FirebaseFirestore.instance
        .collection('messages')
        .add({

      'message': messageController.text,
      'sender': 'Parent',
      'time': FieldValue.serverTimestamp(),
    });

    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(

        backgroundColor: Colors.black,
        elevation: 0,

        title: const Text(

          "Chat Support",

          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [

          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .orderBy('time')
                  .snapshots(),

              builder: (context, snapshot) {

                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: messages.length,

                  itemBuilder: (context, index) {

                    final data = messages[index];

                    return Align(
                      alignment:
                      data['sender'] == 'Parent'
                          ? Alignment.centerRight
                          : Alignment.centerLeft,

                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        padding: const EdgeInsets.all(12),

                        decoration: BoxDecoration(
                          color:
                          data['sender'] == 'Parent'
                              ? Colors.yellow
                              : const Color(0xFF1E1E1E),

                          borderRadius:
                          BorderRadius.circular(12),
                        ),

                        child: Text(
                          data['message'],

                          style: TextStyle(
                            color:
                            data['sender'] == 'Parent'
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),

            child: Row(
              children: [

                Expanded(
                  child: TextField(
                    controller: messageController,

                    decoration: InputDecoration(

                      hintText: "Type message...",

                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),

                      filled: true,

                      fillColor: const Color(0xFF1E1E1E),

                      border: OutlineInputBorder(

                        borderRadius:
                        BorderRadius.circular(20),

                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                FloatingActionButton(

                  backgroundColor: Colors.yellow,

                  onPressed: sendMessage,

                  child: const Icon(
                    Icons.send,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}