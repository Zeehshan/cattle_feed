
import 'package:catlle_feed/providers/product_providers.dart';
import 'package:flutter/material.dart';
import '../screens/edit_product_screen.dart';
import 'package:provider/provider.dart';
class UserProductData extends StatelessWidget {
  final String id;
  final String name;
  final String imageUrl;


  UserProductData(this.id,this.name,this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(title: Text(name), leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl),
    ),
    trailing: Container(
      width: 100,
      child: Row(children: <Widget>[
      IconButton(icon: Icon(Icons.edit), onPressed: (){

        Navigator.of(context).pushNamed(EditProductScreen.routeName,arguments: id );
      },color: Theme.of(context).primaryColor),
      IconButton(icon: Icon(Icons.delete), onPressed: () async{
       try{
         await Provider.of<ProductProviders>(context,listen: false).deleteProduct(id);
      
      }catch(error){

 scaffold.showSnackBar(SnackBar(content: Text('Deleting Failed',textAlign: TextAlign.center,),),);
      }
        
      
      },color: Theme.of(context).errorColor,),
      
      ]),
    ),  
    );
  }
}