 import 'package:flutter/material.dart';
 import 'package:provider/provider.dart';
 import './product_items.dart';

 import '../providers/product_providers.dart';
 class ProductGrid extends  StatelessWidget{
        
      @override
      Widget build(BuildContext context){
      final productData = Provider.of<ProductProviders>(context);
      final products = productData.names;
      return GridView.builder(
        padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx,i) => ChangeNotifierProvider.value( 
        value: products[i], 
        child: ProductItems(
          //products[i].id,
          //products[i].name,
          //products[i].imageUrl),
          ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 3 / 2,mainAxisSpacing: 10,),
      );
      
     }
  }