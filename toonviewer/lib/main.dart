import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

// flutter is all about widget
// StatelessWidget show screens
class App extends StatelessWidget {
  // must build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      'Hey Halo',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Welcome back',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
