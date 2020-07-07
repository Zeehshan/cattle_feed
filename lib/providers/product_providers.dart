import './formula.dart';

import '../models/http_exception.dart';
import 'package:flutter/material.dart';
import './product.dart';
import 'package:http/http.dart' as http;
import 'cattle_type.dart';
import 'dart:convert';

class ProductProviders with ChangeNotifier {
  List<Product> _names = [];

  List<Product> get names {
    return _names;
  }

  List<CattleType> _feed = [];

  List<CattleType> get feed {
    return _feed;
  }

  List<Formula> _formula = [];

  List<Formula> get formula {
    return _formula;
  }

  CattleType findByIde(String id) {
    return _feed.firstWhere((prod) => prod.id == id);
  }

  Product findById(String id) {
    return _names.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchCattleType() async {
    const url = 'https://cattle-feed-9ad31.firebaseio.com/feeds.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<CattleType> loadedProductss = [];

      extractedData.forEach((prodId, prodData) {
        loadedProductss.add(CattleType(
          id: prodId,
          name: prodData['name'],
          quantity: prodData['quantity'],
        ));
      });
      _feed = loadedProductss;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetTypes() async {
    const url = 'https://cattle-feed-9ad31.firebaseio.com/feeds.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<CattleType> loadedProductss = [];

      extractedData.forEach((prodId, prodData) {
        loadedProductss.add(CattleType(
          id: prodId,
          name: prodData['name'],
          quantity: prodData['quantity'],
        ));
      });
      _feed = loadedProductss;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

// Future <void> addFormula (Formula type) async{
//   const url = 'https://cattle-feed-9ad31.firebaseio.com/formula.json';
//  try{
//    final response =await http.post(url, body: json.encode({
//     'feedid' : type.feedid,
//     'rawm': type.rawm,
//     'quan': type.quan,
//    }),
// );
// final hello = Formula(

//    feedid: type.feedid,
//    rawm: type.rawm,
//    quan: type.quan,

//  id: json.decode(response.body)[formula]

//  );
//   _formula.add(hello);
//   notifyListeners();

//  }
//  catch(error){
// print(error);
// throw error;
//  }
//   }

  Future<void> addTypeProduct(CattleType type) async {
    const url = 'https://cattle-feed-9ad31.firebaseio.com/feeds.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({'name': type.name, 'quantity': type.quantity}),
      );
      final newProduct = CattleType(
          name: type.name,
          quantity: type.quantity,
          id: json.decode(response.body)['name']);
      _feed.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchAndSetProducts() async {
    const url = 'https://cattle-feed-9ad31.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          imageUrl: prodData['imageUrl'],
          name: prodData['name'],
          price: prodData['price'],
          cp: prodData['cp'],
          totalweight: prodData['totalweight'],
        ));
      });
      _names = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://cattle-feed-9ad31.firebaseio.com/products.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': product.name,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'cp': product.cp,
          'totalweight': product.totalweight,
        }),
      );

      final newProduct = Product(
          name: product.name,
          price: product.price,
          imageUrl: product.imageUrl,
          cp: product.cp,
          totalweight: product.totalweight,
          id: json.decode(response.body)['name']);
      _names.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<int> AddOrder(List<Product> product) async {
    int statusCode;
    const url = 'https://cattle-feed-9ad31.firebaseio.com/oderplace.json';
    try {
      final response = await http.post(
        url,
        body: json.encode(
            {
              "order" : product.map((e){
                return {
                  "productname" : e.name,
                  "productprice" : e.price,
                  "productqty" : e.qty,
                };
              }).toList()
            }
        ),
      );
      statusCode = response.statusCode;
    } catch (error) {
      statusCode = 500;
      print(error);
      throw error;
    }

    return statusCode;
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _names.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = 'https://cattle-feed-9ad31.firebaseio.com/products/$id.json';
      await http.patch(url,
          body: json.encode({
            'name': newProduct.name,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
            'cp': newProduct.cp,
            'totalweight': newProduct.totalweight,
          }));
      _names[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void updateQuantity(String id, Product newProduct) {
    final prodIndex = _names.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = 'https://cattle-feed-9ad31.firebaseio.com/products/$id.json';
      http.patch(url,
          body: json.encode({
            'name': newProduct.name,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
            'cp': newProduct.cp,
            'totalweight': newProduct.totalweight,
          }));
      _names[prodIndex] = newProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://cattle-feed-9ad31.firebaseio.com/products/$id.json';
    final existingProductIndex = _names.indexWhere((prod) => prod.id == id);
    var existingProduct = _names[existingProductIndex];
    _names.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _names.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Product can not be deleted');
    }

    existingProduct = null;
  }
}
