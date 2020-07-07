import 'package:catlle_feed/providers/product.dart';

import '../providers/cattle_type.dart';
import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../providers/product_providers.dart';

class SetFormula extends StatefulWidget {
  static const routeName = '/set_formula';
  @override
  _SetFormulaState createState() => _SetFormulaState();
}

class _SetFormulaState extends State<SetFormula>
    with SingleTickerProviderStateMixin {
  Product selectedType;
  var _editedProduct = CattleType(id: null, name: '', quantity: '');
  var _isInit = true;
  var _isLoading = false;
  bool proccessing = false;
  final  _keyScaffold = GlobalKey<ScaffoldState>();
  List<DropdownMenuItem> data = [DropdownMenuItem(
    child: Text("Choose Currency Type"),
    value: Text("Choose Currency Type"),
  )];

  TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productTypeId = ModalRoute.of(context).settings.arguments as String;
      _editedProduct = Provider.of<ProductProviders>(context, listen: false)
          .findByIde(productTypeId);

      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductProviders>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void addData(prod) {
    data = [];
    for (var i = 0; i < prod.length; i++) {
      data.add(
        DropdownMenuItem(
          child: Text(prod[i].name),
          value: "${prod[i].name}",
        ),
      );
    }
  }

  List<Product> _list = [];

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProviders>(context);
    final prod = productData.names;

    addData(prod);
// if(prod.length <= 0){

// Text('No data Available');
// }else {

//}

    return IgnorePointer(
      ignoring: proccessing,
      child: Scaffold(
        key: _keyScaffold,
          appBar: AppBar(
            title: Text('Formula'),
            //actions: <Widget>[
            //   IconButton(icon: Icon(Icons.save),
            //  // onPressed: _saveForm,
            //   )
            // ],
          ),
          drawer: AppDrawer(),
          body: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '\Formula of ${_editedProduct.name}',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.blue, fontSize: 25.0),
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(width: 20,),
                            Expanded(
                              flex: 2,
                              child: DropdownButton<Product>(
                                items: productData.names.map((Product value){
                                  return  DropdownMenuItem<Product>(
                                    value: value,
                                    child:  Text(value.name),
                                  );
                                }).toList(),
                                onChanged: (prod) {
                                  setState(() {
                                    selectedType = prod;
                                  });
                                },
                                value: selectedType,
                                isExpanded: false,
                                hint: new Text(
                                  "Choose Currency Type",
                                  style: TextStyle(color: Color(0xff11b719)),
                                ),
                              ),
                            ),
                            SizedBox(width: 20,),
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                //initialValue:  _inItValue['totalamount'],
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  labelText: 'Quantity',
                                ),
                                // textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(width: 20,),
                            Container(
                              width: 60,
                              margin: EdgeInsets.only(top: 10),
                              child: RaisedButton(
                                color: Colors.blue,
                                child:  Text("Ok"),
                                elevation: 8.0,
                                onPressed: selectedType == null ? null : () {
                                  setState(() {
                                    selectedType.qty = _controller.text;
                                    _list.add(selectedType);
                                    _controller.text = "";
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 10,),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Table(
                          border: TableBorder.all(),
                          children: [
                            TableRow(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).secondaryHeaderColor
                                ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Name",textAlign: TextAlign.center,style: TextStyle(fontStyle: FontStyle.italic),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Price",textAlign: TextAlign.center,style: TextStyle(fontStyle: FontStyle.italic),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Qty",textAlign: TextAlign.center,style: TextStyle(fontStyle: FontStyle.italic),),
                                ),
                              ]
                            ),
                          ],
                        ),
                       _list.isEmpty ? Container() : Expanded(
                          child: Table(
                            border: TableBorder.all(),
                            children: List.generate(_list.length, ((index){
                              return TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(_list[index].name,textAlign: TextAlign.center,style: TextStyle(fontStyle: FontStyle.italic),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(_list[index].price.toString(),textAlign: TextAlign.center,style: TextStyle(fontStyle: FontStyle.italic),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(_list[index].qty,textAlign: TextAlign.center,style: TextStyle(fontStyle: FontStyle.italic),),
                                  ),
                                ]
                              );
                            })),
                          ),
                        ),
                      ]),
                ),

              ),
              proccessing ?

                  Center(child: CircularProgressIndicator(),) : Container()
            ],
          ),
        bottomNavigationBar: Container(height: 60,color: Theme.of(context).secondaryHeaderColor,
        child: FlatButton(
          onPressed: (){
            setState(() {
              proccessing = true;
            });
            productData.AddOrder(_list,_editedProduct.id).then((value) {
              if(value == 200){
                setState(() {
                  _list = [];
                  selectedType = null;
                    proccessing = false;
                });
              }else{
                setState(() {
                  proccessing = false;
                });
                _keyScaffold.currentState.showSnackBar(SnackBar(
                  content: Text("Somtthing wrong try again"),
                ));
              }
            });
          },
          child: Row(
            children: <Widget>[
              Expanded(child: Text("Quantity : ${_list.fold(0,(a,b) => a +  int.parse(b.qty))}")),
              Expanded(child: Text("Total : ${_list.fold(0.0,(a,b) => a + (b.price))}")),
              Expanded(flex: 2,child: Text("price for 40KG : ${ _list.isEmpty ? "" : (_list.fold(0.0,(a,b) => a + (b.price)) / _list.fold(0,(a,b) => a +  int.parse(b.qty)) * 40).toString().split('.')[1].substring(0,4)} "   ))
            ],
          ),
        ),
        ),
      ),
    );
  }
}


