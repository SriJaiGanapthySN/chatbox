import 'package:chat/components/chat_bubble.dart';
import 'package:chat/components/my_textfield.dart';
import 'package:chat/services/auth/auth_service.dart';
import 'package:chat/services/chats/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String recieveremail;
  final String recieverid;
  ChatPage({super.key, required this.recieveremail, required this.recieverid});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messagecontroller = TextEditingController();

  //instance
  final ChatService _chatService = new ChatService();

  final AuthService _authService = new AuthService();

  //textfield-focus

  FocusNode myfocusnode = FocusNode();
  @override
  void initState() {
    super.initState();
    myfocusnode.addListener(() {
      if (myfocusnode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
      }
    });
  }

  @override
  void dispose() {
    myfocusnode.dispose();
    _messagecontroller.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();

  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        curve: Curves.bounceIn, duration: const Duration(seconds: 1));
  }

  //sendmessages
  void sendmessages() async {
    if (_messagecontroller.text.isNotEmpty) {
      await _chatService.sendmessage(
          widget.recieverid, _messagecontroller.text);

      _messagecontroller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.recieveremail,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buidUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderid = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getmessages(widget.recieverid, senderid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("loading...");
        }

        return ListView(
          controller: _scrollController,
          children:
              snapshot.data!.docs.map((doc) => _buidMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buidMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data["senderid"] == _authService.getCurrentUser()!.uid;
    return Column(
      crossAxisAlignment:
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        ChatBubble(isCurrentUser: isCurrentUser, message: data["message"]),
      ],
    );
  }

  Widget _buidUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          Expanded(
              child: MyTextfield(
            hinttext: "Send A Message",
            obscure: false,
            controller: _messagecontroller,
            focusNode: myfocusnode,
          )),
          Container(
            decoration:
                const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            margin: const EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: sendmessages,
                icon: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                )),
          )
        ],
      ),
    );
  }
}
