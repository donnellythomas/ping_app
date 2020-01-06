import 'package:flutter/material.dart';
import 'package:ping_app/screens/home/settings/cards/person_card.dart';

class GroupCard extends StatelessWidget {
  final String groupName;
  final List<PersonCard> people;

  GroupCard({this.groupName, this.people});

  @override
  Widget build(BuildContext context) {
    int peopleCount = people == null ? 0 : people.length;

    return Card(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  groupName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FlatButton.icon(
                icon: Icon(Icons.add),
                label: Text(
                  'Add People',
                ),
                onPressed: () {},
              )
            ],
          ),
          Container(
              height: 100,
              color: Colors.grey[300],
              child: ListView.builder(
                itemCount: peopleCount,
                padding: EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return people[index];
                },
              ))
        ],
      ),
    );
  }
}
