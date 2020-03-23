import 'package:flutter/material.dart';

import '../data/data.dart';
import '../models/tile_model.dart';
import '../widgets/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  
  List<TileModel> visiblePairs = new List<TileModel>();

  @override
  void initState() {
    pairs = getPaire();
    pairs.shuffle();
    visiblePairs = pairs;
    selected = true;

    Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        visiblePairs = getQuestions();
        selected = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                '$points/100',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'CenturyGhotic'
                ),
              ),
              Text(
                'Points',
                style: TextStyle(
                  fontSize: 12
                ),
              ),
            ],
          ),
        ),
        
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 24.0,),
              GridView(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 100,
                  mainAxisSpacing: 0.0
                ),

                children: List.generate(visiblePairs.length, (index) {
                  return Tile(
                    imageAssetPath: visiblePairs[index].getImageAssetPath(),
                    // selected: visiblePairs[index].getIsSelected(),
                    tileIndex: index,
                    parent: this,
                  );
                })
              ),
            ],
          ),
        )
      ),
    );
  }
}


//class Tile

class Tile extends StatefulWidget {

  String imageAssetPath;
  int tileIndex;
  _HomeScreenState parent;

  Tile({this.imageAssetPath, this.parent, this.tileIndex});

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Image.asset(
          pairs[widget.tileIndex].getIsSelected() ? pairs[widget.tileIndex].getImageAssetPath() : widget.imageAssetPath
        ),
        
        onPressed: () {
          if(!selected) {
            
            setState(() {
              pairs[widget.tileIndex].setIsSelected(true);
            });
            print('Tile selected');
          }
        },
      )
    );
  }
}


      
