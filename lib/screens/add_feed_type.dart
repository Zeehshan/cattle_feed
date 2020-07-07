
import 'package:flutter/material.dart';
import '../providers/cattle_type.dart';
import 'package:provider/provider.dart';
import '../providers/product_providers.dart';
import '../widgets/app_drawer.dart';

class AddFeedType extends StatefulWidget {
  static const routeName = '/type_product';
  @override
  _AddFeedTypeState createState() => _AddFeedTypeState();
}

class _AddFeedTypeState extends State<AddFeedType>{


final _form = GlobalKey<FormState>();
var _typeProduct = CattleType(id: null,name: '',quantity: '0'); 
var _isLoading = false;




Future<void>  _saveForm() async{  //starting save 
      final isValid =_form.currentState.validate();
      if(!isValid){
        return;
      }
      _form.currentState.save();
      setState(() {
        _isLoading = true;
      });

    try{
        
       await Provider.of<ProductProviders>(context,listen: false).addTypeProduct(_typeProduct);
      
        }
        catch(error){
await showDialog<Null>(context: context,builder: (ctx) => AlertDialog(
           title: Text('An error occurred'), 
           content:Text('Something went wrong.'),
           actions: <Widget>[
             FlatButton(child: Text('Okay'), onPressed: () {
               Navigator.of(ctx).pop();
               },),
           ],
           ),
           );
     
     }
 
       setState(() {
        _isLoading = true;
      });
      Navigator.of(context).pop();
}
         
         





@override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(title: Text('Add Cattle Feed'),
     
      ), 
drawer: AppDrawer(),

body: _isLoading ? Center(child: CircularProgressIndicator(),)

  : SingleChildScrollView(
        child: Column(
          children: <Widget>[
      Padding(padding: const EdgeInsets.all(40.0),
           child : 
           Form( 
           key: _form,
           child:
           TextFormField(
            
             decoration: new InputDecoration(hintText: "Enter Name"),
             validator: (value){
                if(value.isEmpty){
                  return 'Field is Empty' ;
                }
                return null;
             },
              onSaved: (value){
             
              
              _typeProduct = CattleType(id: null,name: value,quantity: _typeProduct.quantity);
              },
           ),
           ),
           ),

           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: <Widget>[
        MaterialButton(
          color: Colors.grey,
          child: Text('Add'),
      
          onPressed: (){
            
                      
                  
                      _saveForm();
                      },
          
                 
          ),
             ]
           ),






], 
        
       
 ),
    
 
 
 
 
 ),
 
      
   
    );
}
}
