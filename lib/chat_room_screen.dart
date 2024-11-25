import 'package:flutter/material.dart';
import 'package:tasklist_app/bottom_nav_bar.dart';
import 'package:tasklist_app/constants.dart';
import 'package:web_socket_channel/io.dart';
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
  // late WebSocketChannel channel;
  late IOWebSocketChannel ioChannel;

  @override
  void initState() {
    super.initState();

    initializeStream();

    print('g2g');
  }

  Future<void> initializeStream() async {
    print('init stream');
    try {
      // channel = WebSocketChannel.connect(
      //   Uri.parse(wsUrl),
      // );
      ioChannel = IOWebSocketChannel.connect(
        Uri.parse(wsUrl),
      );
      // await channel.ready;
      await ioChannel.ready;
      print('channel ready');

      ioChannel.stream.listen((message) {
        print('trigger stream');
        getMessages(message, Colors.blue);
      }).onError((err) {
        print('err: $err');
      });
    } catch (err) {
      print('error getting ready: $err');
      if (err is WebSocketChannelException) {
        print('derp');
        if (err.inner != null) {
          final e = err.inner as dynamic;
          print('Websocket inner error: ${e.message.toString()}');
        }
        print('Websocket error: ${err.message}');
      }
    }
  }

  @override
  void dispose() {
    ioChannel.sink.close();
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: messages,
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
                        ioChannel.sink.add(messageController.text);
                        messageController.clear();
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

  // SocketChannel getChannel() {
  //   return SocketChannel();
  // }
}

// TODO: potential follow-up, rxdart: ^0.28.0
// https://medium.com/@ilia_zadiabin/websocket-reconnection-in-flutter-35bb7ff50d0d

// class SocketChannel {
//   SocketChannel(this._getIOWebSocketChannel) {
//     _startConnection();
//   }

//   final IOWebSocketChannel Function() _getIOWebSocketChannel;

//   late IOWebSocketChannel _ioWebSocketChannel;

//   WebSocketSink get _sink => _ioWebSocketChannel.sink;

//   late Stream<dynamic> _innerStream;

//   final _outerStreamSubject = BehaviorSubject<dynamic>();

//   Stream<dynamic> get stream => _outerStreamSubject.stream;
// }
