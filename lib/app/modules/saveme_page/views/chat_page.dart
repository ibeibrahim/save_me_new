import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:save_me_new/app/modules/auth/auth_service.dart';
import 'package:save_me_new/app/modules/saveme_page/chat_service.dart';
import 'package:save_me_new/component/GlobalFunction.dart';
import 'package:save_me_new/component/chat_bubble.dart';
import 'package:save_me_new/component/my_textfield.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // for textfield focus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // add listener to focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        // cause a delay to keyboar show up
        // the amount of remaining space will be calculated
        // then scroll down
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });

    // wait a bit for list view built
    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  // send message
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverID, _messageController.text);

      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: Column(
          children: [
            // display all messages
            Expanded(
              child: _buildMessageList(),
            ),
            // user input
            _buildUserInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurretUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(widget.receiverID, senderID),
        builder: (context, snapshot) {
          // errors
          if (snapshot.hasError) {
            return const Text('error');
          }
          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }
          // return list view
          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurretUser()!.uid;

    // align message to the right if sender is the current user, otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: ChatBubble(message: data['message'], isCurrentUser: isCurrentUser),
    );
  }

  // build message input
  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
          child: MyTextField(
            focusNode: myFocusNode,
            controller: _messageController,
            hintText: "Type a message",
            obsecureText: false,
          ),
        ),
        // send button
        Container(
          decoration: BoxDecoration(
            color: PRIMARY_COLOR,
            shape: BoxShape.circle,
          ),
          margin: EdgeInsets.only(right: 25.0),
          child: IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.arrow_upward,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
