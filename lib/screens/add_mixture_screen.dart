import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../providers/product_providers.dart';
import '../providers/cattle_type.dart';

class AddMixtureScreen extends StatefulWidget {
 static const routeName = '/add_mixture';

  @override
  _AddMixtureScreenState createState() => _AddMixtureScreenState();
}

class _AddMixtureScreenState extends State<AddMixtureScreen>with SingleTickerProviderStateMixin {
  List<CattleType> data ;

  @override
  void initState() {
    Provider.of<ProductProviders>(context,listen: false).fetchCattleType();
    super.initState();
    
  }

  var type = ['super','plus','meat'];
 
  var currentItemSelected ;


@override
  Widget build(BuildContext context) {
final _types = Provider.of<ProductProviders>(context);


   return Scaffold(appBar: AppBar(
      title: const Text('Add Mixture'),
   ),
drawer: AppDrawer(),

body: Container(
  alignment: Alignment.center,
  child: Column(children: <Widget>[

DropdownButton<String>(

items: type.map((String dropDownStringItem){

return DropdownMenuItem<String>(
  value: dropDownStringItem,
  child: Text(dropDownStringItem),
);


}).toList() ,
onChanged: (String newValueSelected){

setState(() {
  this.currentItemSelected = newValueSelected;
});


},

value: currentItemSelected,

hint: Text("Select the Cattle Feed"),
),






  ]
),
),






   );
  }
}