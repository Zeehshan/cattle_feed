

import '../screens/add_mixture_screen.dart';
import 'package:flutter/material.dart';
import '../screens/manage_products.dart';
import '../screens/show_feed.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(child: Column(children: <Widget>[
AppBar(
  title: Text('Cattle Feed'),
  automaticallyImplyLeading: false,
),
Divider(),
ListTile(
  leading: Icon(Icons.home),
  title: Text('Home'),
  onTap: (){
Navigator.of(context).pushReplacementNamed('/');

  },
),
Divider(),
ListTile(
  leading: Icon(Icons.edit),
  title: Text('Raw Material List'),
  onTap: (){
Navigator.of(context).pushReplacementNamed(ManageProducts.routeName);

  },
),


Divider(),
ListTile(
  leading: Icon(Icons.edit),
  title: Text(' Cattle Feed'),
  onTap: (){
Navigator.of(context).pushReplacementNamed(ShowFeed.routeName);

  },
),

Divider(),
ListTile(
  leading: Icon(Icons.add),
  title: Text('Add Mixtures'),
  onTap: (){
Navigator.of(context).pushReplacementNamed(AddMixtureScreen.routeName);

  },
),





    ]
    ),
      );
  }
}