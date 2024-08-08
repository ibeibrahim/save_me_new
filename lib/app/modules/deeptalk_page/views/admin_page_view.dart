import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_me_new/app/modules/auth/auth_service.dart';
import 'package:save_me_new/app/modules/deeptalk_page/chat_service.dart';
import 'package:save_me_new/app/modules/deeptalk_page/views/chat_page.dart';
import 'package:save_me_new/app/modules/deeptalk_page/views/user_tile.dart';
import 'package:save_me_new/component/GlobalFunction.dart';

class AdminPageView extends StatelessWidget {
  AdminPageView({super.key});

  // chat & auth service
  final AuthService _authService = AuthService();
  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Save Me | Deep Talk',
          style: TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.bold),
        ),
      ),
      body: _buildUserList(),
    );
  }

  // build a list of users except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return const Text('Error');
        }
        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
        // return list view
      },
    );
  }

  // build individual list tile for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData['uid'] != _authService.getCurrentUser()!.uid) {
      if (userData['name'] == null) {
        return const SizedBox(
          height: 20,
        );
      }
      return UserTile(
        text: userData['name'].toString(),
        onTap: () {
          Get.to(ChatPage(
              receiverEmail: userData['name'], receiverID: userData['uid']));
        },
      );
    } else {
      return Container();
    }
  }
}
