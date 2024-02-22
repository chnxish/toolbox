import 'package:flutter/material.dart';

import 'package:toolbox/src/theme/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      color:
          theme.extension<ExtensionColors>()!.backgroundGrey.withOpacity(0.05),
      child: const Center(child: Text('Profile')),
    );
  }
}
