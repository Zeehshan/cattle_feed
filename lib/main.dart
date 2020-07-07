
import './screens/set_formula.dart';

import './screens/add_mixture_screen.dart';

import './screens/add_feed_type.dart';
import './screens/show_feed.dart';

import './screens/edit_product_screen.dart';
import 'package:flutter/material.dart';
import './screens/products_overview.dart';
import './screens/products_details.dart';
import './providers/product_providers.dart';
import 'package:provider/provider.dart';
import './screens/manage_products.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
     create: (ctx) => ProductProviders(),
      
          child: MaterialApp(
        title: 'Cattle Feed',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.cyanAccent,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
         ProductsDetails.routeName: (ctx) => ProductsDetails(),
         ManageProducts.routeName: (ctx) => ManageProducts(),
         EditProductScreen.routeName: (ctx) => EditProductScreen(),
         AddFeedType.routeName: (ctx) => AddFeedType(),
         ShowFeed.routeName: (ctx) => ShowFeed(),
         AddMixtureScreen.routeName: (ctx) => AddMixtureScreen(),
         SetFormula.routeName: (ctx) => SetFormula(),
        },
      ),
    );
  }
}

 
