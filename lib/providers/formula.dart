
import 'package:flutter/material.dart';


class Formula with ChangeNotifier{
final String id;
final String feedid;
//final List<Product> raw;
final String rawm;
final String quan;





Formula({
  @required this.id,
  @required this.feedid,
  this.rawm,
  this.quan,
  }
  );




}