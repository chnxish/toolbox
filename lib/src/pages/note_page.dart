import 'package:flutter/material.dart';

import 'package:toolbox/src/theme/theme.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      color:
          theme.extension<ExtensionColors>()!.backgroundGrey.withOpacity(0.05),
      child: const Center(child: Text('Note')),
    );
  }
}
