

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_providers.dart';
import '../widgets/user_product_data.dart';
import '../widgets/app_drawer.dart';
import './edit_product_screen.dart';
class ManageProducts extends StatelessWidget {
 static const routeName = '/user_products';


Future<void> _refreshProducts(BuildContext context) async{

  await Provider.of<ProductProviders>(context).fetchAndSetProducts();
}

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProviders>(context);
    return Scaffold(appBar: AppBar(
      title: const Text('Add Raw Material'),
      actions: <Widget>[
        IconButton(icon: const Icon(Icons.add), onPressed: (){
          Navigator.of(context).pushNamed(EditProductScreen.routeName);
},
        ),
      ],
    ),
    drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () =>_refreshProducts(context) ,
              child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(itemCount: productData.names.length,
          itemBuilder:(_,i)=>Column(
            children: <Widget>[
              UserProductData(
                productData.names[i].id,
                productData.names[i].name,
                productData.names[i].imageUrl),
                Divider(),
            ],
          ),
            ),
        ),
      ),
    );
  }
}