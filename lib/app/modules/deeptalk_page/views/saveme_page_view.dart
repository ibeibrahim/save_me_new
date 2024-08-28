import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:save_me_new/app/modules/auth/auth_service.dart';
import 'package:save_me_new/app/modules/deeptalk_page/chat_service.dart';
import 'package:save_me_new/app/modules/deeptalk_page/views/chat_page.dart';
import 'package:save_me_new/app/modules/deeptalk_page/views/user_tile.dart';

class SavemePageView extends StatelessWidget {
  SavemePageView({super.key});
  // chat & auth service
  final AuthService _authService = AuthService();
  final ChatService _chatService = ChatService();
  final String receiverEmail = "admin@gmail.com";
  final String receiverID = "H1LHN3qD5tUnUslOWFycmAqZIQv2";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Save Me', style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colors.white,
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
    if (userData['uid'] != _authService.getCurrentUser()!.uid &&
        userData['uid'] == receiverID) {
      return UserTile(
        text: userData['name'],
        onTap: () {
          Get.to(
              ChatPage(receiverEmail: receiverEmail, receiverID: receiverID));
        },
      );
    } else {
      return Container();
    }
  }
}
