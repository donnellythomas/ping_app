import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        title: Text(
          'Messages',
          style: TextStyle(
            fontSize: 35,
            color: Colors.deepPurple,
            fontFamily: 'futura',
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ListView(),
    );
  }
}
