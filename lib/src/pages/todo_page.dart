import 'package:flutter/material.dart';

import 'package:toolbox/src/theme/theme.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      color:
          theme.extension<ExtensionColors>()!.backgroundGrey.withOpacity(0.05),
      child: const Center(child: Text('Todo')),
    );
  }
}
