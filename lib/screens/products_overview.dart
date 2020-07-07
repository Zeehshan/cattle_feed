import 'package:catlle_feed/providers/product_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_providers.dart';

import '../widgets/product_grid.dart';
import '../widgets/app_drawer.dart';
//ProductsOverview

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
 var _isInit = true;
var _isLoading = false;
@override
void initState(){

  super.initState();
}

@override
void didChangeDependencies(){

if(_isInit){
setState(() {
  _isLoading = true;
});


Provider.of<ProductProviders>(context).fetchAndSetProducts().then((_){

setState(() {
  _isLoading = false;
});


});
}

_isInit = false;
  super.didChangeDependencies();

}


@override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products'),
      ),
      drawer: AppDrawer(),
      body: _isLoading ? Center(child: CircularProgressIndicator(),): ProductGrid()
 );
  }
}

     