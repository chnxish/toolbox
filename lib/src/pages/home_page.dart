import 'package:flutter/material.dart';

import 'package:toolbox/src/theme/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      color:
          theme.extension<ExtensionColors>()!.backgroundGrey.withOpacity(0.05),
      child: const Center(child: Text('Home')),
    );
  }
}
