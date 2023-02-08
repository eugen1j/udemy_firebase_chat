import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter chat'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
              items: [
                DropdownMenuItem(
                    value: 'logout',
                    child: Container(
                      child: Row(
                        children: const [
                          Icon(Icons.exit_to_app, color: Colors.black),
                          SizedBox(width: 8),
                          Text('Logout'),
                        ],
                      ),
                    ))
              ],
              onChanged: (val) {
                if (val == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
