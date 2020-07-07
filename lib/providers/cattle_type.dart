import 'package:flutter/material.dart';

class CattleType with ChangeNotifier{


final String id;
final String name;
final String quantity;




CattleType({
  @required this.id,
  @required this.name,
  @required this.quantity
   
}
);
}