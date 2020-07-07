
import 'package:flutter/material.dart';
import '../providers/product_providers.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';



class ProductsDetails extends StatefulWidget {
static const routeName = '/product_detail';
@override
_ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductsDetails>{

var z=0.0;

double sumquan = 0,x=0,diff =0;
final quanController = TextEditingController();
///
final _form = GlobalKey<FormState>();
 var _editedProduct = Product(id: null,name: '',price: 0,imageUrl: '',cp: 0,totalweight: 0);
  var _isInit = true;
  var ta = false,td = false ;
 //var _isLoading = false;
  // var _inItValue ={
  // 'name': '',
  // 'price': '',
  // 'imageUrl': '',
  // 'cp': '',
  // 'totalweight': '',
  
  // };
void quanCalculate(){
  setState(() {
    sumquan = x + double.parse(quanController.text);
    
  });
}
void diffCalculate(){
  setState(() {
    diff = x - double.parse(quanController.text);
    
  });
}



  @override
  void didChangeDependencies() {
  if(_isInit){
   final productId = ModalRoute.of(context).settings.arguments as String;
   if(productId != null){_editedProduct = Provider.of<ProductProviders>(context,listen: false).findById(productId);
//    _inItValue = {
// 'name': _editedProduct.name,
// 'cp': _editedProduct.cp.toString(),
// 'imageUrl': _editedProduct.imageUrl,
// 'price': _editedProduct.price.toString(),
// 'totalWeight': _editedProduct.totalweight.toString(),
// };
  
   }
  } 
  _isInit = false; 
    super.didChangeDependencies();
  } //ending edit part
    
    Future<void>  _saveForm() async{  //starting save 
      quanCalculate();
      final isValid =_form.currentState.validate();
      if(!isValid){
        return;
      }
      _form.currentState.save();
      setState(() {
        //_isLoading = true;
      });
   
         Provider.of<ProductProviders>(context,listen: false).updateQuantity(_editedProduct.id,_editedProduct);
    
 
         

         setState(() {
        //_isLoading = true;
      });
         ta = false;
         td = false;
         Navigator.of(context).pop();
          }



// void _saveForm() {  //starting save 
//       final productId = ModalRoute.of(context).settings.arguments as String;
//    if(productId != null){_editedProduct = Provider.of<ProductProviders>(context,listen: false).findById(productId);

//  }
//  sumquan = x + double.parse(quanController.text);
// Provider.of<ProductProviders>(context,listen: false).updateQuantity(_editedProduct.id,_editedProduct,sumquan);
        
//  Navigator.of(context).pop();
        
        
//     }

       
         

     
     
    

////

  @override
  Widget build(BuildContext context) {
   final String productId =ModalRoute.of(context).settings.arguments as String ; //gives as the id of product
   final loadedProduct = Provider.of<ProductProviders>(context,listen: false).findById(productId);
    z = loadedProduct.price * loadedProduct.totalweight;
    
  x = loadedProduct.totalweight;
   
    return Scaffold(appBar: AppBar(title: Text(loadedProduct.name),
    ),

    
    body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            // SizedBox(height: 10),
            Padding(padding: const EdgeInsets.all(15.0),
           child :
           Text(
              '\RS ${loadedProduct.price}/KG',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),

             ),
           Padding(padding: const EdgeInsets.all(15.0),
           child :
           Text(
              '\Weight ${loadedProduct.totalweight}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
           ),
         
           Padding(padding: const EdgeInsets.all(15.0),
           child :
           Text(
              "Total Material Of Amount : $z",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
           ),



           
           Padding(padding: const EdgeInsets.all(40.0),
           child : 
           Form( 
           key: _form,
           child:
           TextFormField(
             controller: quanController,
             keyboardType: TextInputType.number,
             decoration: new InputDecoration(hintText: "Enter Quantity"),
             validator: (value){
                if(value.isEmpty){
                  return 'Field is Empty' ;
                }
                return null;
             },
              onSaved: (value){
             
               if(ta == true){
              _editedProduct = Product(id: _editedProduct.id,name: _editedProduct.name,price:_editedProduct.price ,imageUrl: _editedProduct.imageUrl,cp: _editedProduct.cp,totalweight: sumquan);
               }
               if(td == true){
              _editedProduct = Product(id: _editedProduct.id,name: _editedProduct.name,price:_editedProduct.price ,imageUrl: _editedProduct.imageUrl,cp: _editedProduct.cp,totalweight: diff);
                 
               }
                
            
               },
           ),
           ),
           ),
//Padding(padding: const EdgeInsets.all(2.0),),

           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: <Widget>[
        MaterialButton(
          color: Colors.grey,
          child: Text('Add Qauntity'),
      
          onPressed: (){
            if(quanController.text != ""){
                      ta = true;
                       quanCalculate();
                   _saveForm();
            }else{

               showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Enter a Quantity"),
            );
          });
            }
                // Provider.of<ProductProviders>(context,listen: false).updateQuantity(productId,loadedProduct,sumquan);
           // Navigator.of(context).pop();
              },
               
          ),
          
          MaterialButton(
           
            color: Colors.grey,
          child: Text('Dec Qauntity'),
          onPressed: (){
         if(quanController.text != ""){
         if(x <= 0 || x < double.parse(quanController.text)){
          showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Add Quantity First"),
            );
          });
         }else{
             td =true;
           diffCalculate();
             _saveForm();
         }
         }else{
            showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Enter a Quantity"),
            );
          });
         }
              },
          )
          
             ]
           )




            // SizedBox(
            //   height: 10,
            // ),
           
          ],
        ),
      ),

    );
  }
}
