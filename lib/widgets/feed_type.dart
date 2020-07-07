import '../screens/set_formula.dart';
import 'package:flutter/material.dart';

class FeedTypeData extends StatelessWidget {
  final String id;
  final String name;
  final String quan;

  FeedTypeData(this.id, this.name, this.quan);
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    quan,
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                ]),
            trailing: Container(
                width: 100,
                child: Row(children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(SetFormula.routeName, arguments: id);
                      },
                      color: Theme.of(context).primaryColor)
                ]))));
  }
}
