import 'package:chat/components/user_tile.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/services/auth/auth_service.dart';
import 'package:chat/components/my_drawer.dart';
import 'package:chat/services/chats/chat_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  //chat_services & auth instances
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: _buildUserList(),
      drawer: MyDrawer(),
    );
  }
  //build user list except the logged in user

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return Text('Error');
          }
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }
          //user
          return ListView(
              children: snapshot.data!
                  .map<Widget>(
                      (userData) => _buildUserListItem(userData, context))
                  .toList());
        });
  }

  //build induvidual item
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    recieveremail: userData["email"],
                    recieverid: userData["uid"],
                  ),
                ));
          },
          text: userData["email"]);
    } else {
      return SizedBox.shrink();
    }
  }
}
