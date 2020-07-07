import '../widgets/feed_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_providers.dart';

import '../widgets/app_drawer.dart';


import './add_feed_type.dart';


class ShowFeed extends StatefulWidget {

static const routeName = '/show_feed';

  @override
  _ShowFeedState createState() => _ShowFeedState();
}

class _ShowFeedState extends State<ShowFeed> {
 



  @override
  void initState() {

    Provider.of<ProductProviders>(context,listen: false).fetchAndSetTypes();
    super.initState();
   
  }

    @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProviders>(context);
   
    return Scaffold(appBar: AppBar(
      title: const Text('Cattle Feed'),
         actions: <Widget>[
        IconButton(icon: const Icon(Icons.add), onPressed: (){
          Navigator.of(context).pushNamed(AddFeedType.routeName);
},
    ),
         ]
    ),
    drawer: AppDrawer(),
      body: 
      //  RefreshIndicator(
      //    onRefresh: () =>_refreshProductss(context) ,
      //          child: 
              Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(itemCount: productData.feed.length,
          itemBuilder:(_,i)=>Column(
            children: <Widget>[
              FeedTypeData(
                productData.feed[i].id,
                productData.feed[i].name,
                productData.feed[i].quantity
                ),
                Divider(),
            ],
          ),
            ),
        ),
     // ),
    );
  }

 
}