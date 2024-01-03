import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/provider/dark_mode.dart';

class DarkModePage extends StatelessWidget {
  const DarkModePage({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  _themeChanger.setTheme(ThemeMode.dark);
                },
                child: Text('Dark Mode')),
            ElevatedButton(
                onPressed: () {
                  _themeChanger.setTheme(ThemeMode.light);
                },
                child: Text('Light Mode'))
          ],
        ),
      )),
    );
  }
}
