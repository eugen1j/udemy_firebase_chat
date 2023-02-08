import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Container();
    }

    return StreamBuilder<QuerySnapshot<Map>>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, snapshot) {
        final data = snapshot.data;

        if (snapshot.connectionState == ConnectionState.waiting ||
            data == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
            itemCount: data.docs.length,
            reverse: true,
            itemBuilder: (_, idx) {
              final msg = data.docs[idx];
              final dt = msg.data();
              return MessageBubble(
                dt['text'] ?? '',
                dt['username'] ?? '',
                dt['userImage'] ?? '',
                dt['userId'] == user.uid,
                key: ValueKey(msg.id),
              );
            });
      },
    );
  }
}
