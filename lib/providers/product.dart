
import 'package:flutter/material.dart';

class Product with ChangeNotifier{

final String id;
final String name;
final double price;
final String imageUrl;
 double totalweight;
final double cp;
String qty;
//final List<CattleType> feedtypes ;





Product({
  @required this.id,
  @required this.name,
  @required this.price,
  @required this.imageUrl,
 @required this.totalweight,
  @required this.cp,
 //this.feedtypes,
  }
  );
}