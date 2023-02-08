import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String username;
  final String userImage;
  final bool isMe;

  const MessageBubble(this.message, this.username, this.userImage, this.isMe,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final textStyle = isMe
        ? null
        : theme.textTheme.bodyText2?.copyWith(
            color: theme.colorScheme.onSecondary,
          );

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isMe ? Colors.grey : theme.colorScheme.secondary,
              ),
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: textStyle?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    message,
                    style: textStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -10,
          right: isMe ? 120 : null,
          left: isMe ? null : 120,
          child: CircleAvatar(backgroundImage: NetworkImage(userImage)),
        ),
      ],
    );
  }
}
