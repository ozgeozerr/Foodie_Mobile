import 'package:flutter/material.dart';

class UserSettingsPage extends StatelessWidget {
  const UserSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Settings'),
      ),
      body: Center(
        child: Text(' User Settings Page'),
      ),
    );
  }
}
