import 'package:flutter/material.dart';

import 'package:toolbox/src/theme/theme.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      color:
          theme.extension<ExtensionColors>()!.backgroundGrey.withOpacity(0.05),
      child: const Center(child: Text('Chat')),
    );
  }
}
