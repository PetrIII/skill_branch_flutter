import 'package:flutter/material.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            FlatButton(
              color: Colors.green,
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text('Click me'),
            )
          ],
        ),
      ),
    );
  }
}
