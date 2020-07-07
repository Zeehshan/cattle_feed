import 'package:flutter/material.dart';
import '../screens/products_details.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';



class ProductItems extends StatelessWidget {
  //final String id;
  //final String name;
  //final String imageUrl;

  //ProductItems(this.id,this.name,this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
    child: GestureDetector(
      onTap: (){
       
        Navigator.of(context).pushNamed(ProductsDetails.routeName,arguments: product.id);
      },
    child: Image.network(product.imageUrl,fit: BoxFit.cover,
    ),
    ),
    footer: GridTileBar( 
      backgroundColor: Colors.black87,
      title: Text(product.name,textAlign: TextAlign.center),
      subtitle: Text(product.price.toString(),textAlign: TextAlign.center),
      
      ) ,
    
    
    ),
    );
  }
}