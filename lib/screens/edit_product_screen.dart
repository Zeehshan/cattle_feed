import '../providers/product_providers.dart';
import 'package:flutter/material.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
 static const routeName = '/edit_product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen>{
  final _priceFocusNode = FocusNode();
  final _amountFocusNode = FocusNode();
  final _weightFocusNode = FocusNode();
  final _carriageFocusNode = FocusNode();
  final _bagsFocusNode = FocusNode();
    final _cpFocusNode = FocusNode();
  final _labourFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(id: null,name: '',price: 0,imageUrl: '',cp: 0,totalweight: 0);
  var _isInit = true;
  var _isLoading = false;
  var _inItValue ={
  'name': '',
  'price': '',
  'imageUrl': '',
  'cp': '',
  'totalweight': '',
  
  };
double amount=0,weight=0,z=0,carr =0,unloading =0;
 final amountController = TextEditingController();
 final weightController = TextEditingController();
 final rateController = TextEditingController();
 final carriageController = TextEditingController();
 final unloadingController = TextEditingController();

 void calculateRate(){
setState(() {
  amount = double.parse(amountController.text);
  weight = double.parse(weightController.text);
  carr = double.parse(carriageController.text);
  unloading = double.parse(unloadingController.text);
  z = (amount/weight)+(carr/weight)+(unloading/weight);
  //rateController.text = z.toString() ;

});
}


 


  
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void dispose(){
_imageUrlFocusNode.dispose();
_priceFocusNode.dispose();
_amountFocusNode.dispose();
_weightFocusNode.dispose();
_carriageFocusNode.dispose();
_bagsFocusNode.dispose();
_labourFocusNode.dispose();
_cpFocusNode.dispose();
_imageUrlController.dispose();
_imageUrlFocusNode.removeListener(_updateImageUrl);
rateController.dispose();
weightController.dispose();
amountController.dispose();
unloadingController.dispose();
carriageController.dispose();
    super.dispose();
  }

  void _updateImageUrl(){
   if(!_imageUrlFocusNode.hasFocus)
   setState(() {
      });}

      @override
  void didChangeDependencies() {
  if(_isInit){
   final productId = ModalRoute.of(context).settings.arguments as String;
   if(productId != null){_editedProduct = Provider.of<ProductProviders>(context,listen: false).findById(productId);
   _inItValue = {
'name': _editedProduct.name,
'cp': _editedProduct.cp.toString(),
};
   _imageUrlController.text = _editedProduct.imageUrl;
   rateController.text = _editedProduct.price.toString();
   weightController.text = _editedProduct.totalweight.toString();
   }
  } 
  _isInit = false; 
    super.didChangeDependencies();
  } //ending edit part
    
    Future<void>  _saveForm() async{  //starting save 
      final isValid =_form.currentState.validate();
      if(!isValid){
        return;
      }
      _form.currentState.save();
      setState(() {
        _isLoading = true;
      });
      if(_editedProduct.id != null){
       await  Provider.of<ProductProviders>(context,listen: false).updateProduct(_editedProduct.id,_editedProduct);
         }else{
        try{
          await Provider.of<ProductProviders>(context,listen: false)
        .addProduct(_editedProduct);
       
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
         }

         setState(() {
        _isLoading = true;
      });
         Navigator.of(context).pop();

     
     
    }




@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Raw Material'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.save), 
        onPressed: _saveForm,
        )
      ],
      
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator(),)
      : Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              
             TextFormField(
               initialValue:  _inItValue['name'],
               decoration: InputDecoration(labelText: 'Name'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_){
                FocusScope.of(context).requestFocus(_cpFocusNode);
               },
               validator: (value){
                if(value.isEmpty){
                  return 'Field is Empty' ;
                }
                return null;
               },
               onSaved: (value){
                 _editedProduct = Product(id: _editedProduct.id,name: value,price: _editedProduct.price,imageUrl: _editedProduct.imageUrl,cp: _editedProduct.cp,totalweight: _editedProduct.totalweight);
               },
               ),

                   TextFormField(
                 initialValue:  _inItValue['cp'],
                 decoration: InputDecoration(labelText: 'Crude Protein'),
                 textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _cpFocusNode,
              onSaved: (value){
                 _editedProduct = Product(id: _editedProduct.id,name: _editedProduct.name,price:_editedProduct.price ,imageUrl: _editedProduct.imageUrl,cp: double.parse(value),totalweight: _editedProduct.totalweight);
               },
               ),

               TextFormField(
                 controller: amountController,
                 //initialValue:  _inItValue['totalamount'],
                 decoration: InputDecoration(labelText: 'Total Amount'),
                 textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _amountFocusNode,
              
               ),


               TextFormField(
               controller: weightController,
                // initialValue:  _inItValue['totalweight'],
                 decoration: InputDecoration(labelText: 'Total Weight'),
                 textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _weightFocusNode,
              onSaved: (value){
                 _editedProduct = Product(id: _editedProduct.id,name: _editedProduct.name,price: _editedProduct.price,imageUrl: _editedProduct.imageUrl,cp: _editedProduct.cp,totalweight: double.parse(value));
               },
               ),

               TextFormField(
                 controller: carriageController,
                 //initialValue:  _inItValue['carriage'],
                 decoration: InputDecoration(labelText: 'Carriage'),
                 textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _carriageFocusNode,
             
               ),


               
               TextFormField(
                 controller: unloadingController,
                 //initialValue:  _inItValue['unloadinglabour'],
                 decoration: InputDecoration(labelText: 'Unloading Labour'),
                 textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _labourFocusNode,
              
               ),

               TextFormField(
                 readOnly: true,
                 controller: rateController,
                 //initialValue:  _inItValue['price'],
                 decoration: InputDecoration(labelText: 'Rate/Kg'),
                 textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              onSaved: (value){
                  calculateRate();
                 _editedProduct = Product(id: _editedProduct.id,name: _editedProduct.name,price: z,imageUrl: _editedProduct.imageUrl,cp: _editedProduct.cp,totalweight: _editedProduct.totalweight);
               },
               ),
              
              



               Row(
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: <Widget>[
                 Container(
                   width: 100,
                   height: 100,
                   margin: EdgeInsets.only(top: 8,right: 10,),
                   decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.grey),
                   ),
                   child: _imageUrlController.text.isEmpty ? Text('Enter a Url') : FittedBox(child: Image.network(_imageUrlController.text,fit: BoxFit.cover,),),
                 ),
                Expanded(
                                    child: TextFormField(
                                      //initialValue:  _inItValue['imageUrl'],
                                      decoration: InputDecoration(labelText: 'Image Url'),
                   keyboardType: TextInputType.url,
                   textInputAction: TextInputAction.done,
                   controller: _imageUrlController,
                   focusNode: _imageUrlFocusNode,
                   onFieldSubmitted: (_){
                     _saveForm();
                   },
                   onSaved: (value){
                 _editedProduct = Product(id: _editedProduct.id,name: _editedProduct.name,price: _editedProduct.price,imageUrl: value,cp: _editedProduct.cp,totalweight: _editedProduct.totalweight);
               },
                   ),
                 )
               ],
               ),



        ],
        ),
        ),
      )
      
    );
  }
}