import 'package:flutter/material.dart';
import 'package:tasklist_app/bottom_nav_bar.dart';
import 'package:tasklist_app/constants.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  TextEditingController messageController = TextEditingController();
  List<Widget> messages = [];
  WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse(wsUrl),
  );

  @override
  void initState() {
    super.initState();
    channel.stream.listen((message) {
      getMessages(message, Colors.blue);
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Room'),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 3),
      body: Padding(
        padding: const EdgeInsets.only(
          bottom: 50,
          right: 20,
          left: 20,
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          hintText: 'Enter message',
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        getMessages(
                          messageController.text,
                          Colors.black54,
                        );
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.purple[200],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getMessages(
    String message,
    Color color,
  ) {
    setState(() {
      messages.add(
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            message,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    });
  }
}
