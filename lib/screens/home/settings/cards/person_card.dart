import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  final String name;
  final Function delete;

  PersonCard({this.name, this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.not_interested),
            onPressed: delete,
          )
        ],
      ),
    );
  }
}
