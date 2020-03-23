import 'package:flutter/material.dart';

import '../data/data.dart';
import '../widgets/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void initial() {
    points = 0;
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
}

  @override
  void initState() {
    initial();

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
                '$points/80',
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
              points != 80
              ? GridView(
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
              )
              : Column(
                children: <Widget>[
                  Text(
                    'You are finish !',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'CenturyGhotic',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Column(
                       children: <Widget>[
                          Text(
                          'Your score',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontFamily: 'CenturyGhotic',
                          ),
                        ),
                        Text(
                          '70',
                          style: TextStyle(
                            // fontSize: 11.0,
                            fontFamily: 'CenturyGhotic',
                            fontWeight: FontWeight.bold,
                            fontSize: 16.5,
                          ),
                        )
                       ],
                      ),
                      new Text('|'),
                      new Column(
                       children: <Widget>[
                          Text(
                          'Best score',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontFamily: 'CenturyGhotic',
                          ),
                        ),
                        Text(
                          '80',
                          style: TextStyle(
                            // fontSize: 11.0,
                            fontFamily: 'CenturyGhotic',
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 16.5,
                          ),
                        )
                       ],
                      ),
                    ],
                  ),

                  SizedBox(height: 40),

                  CircleAvatar(
                    radius: 56,
                    backgroundColor: Colors.purple[200],
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.purple[300],
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.purple[400],
                        child: IconButton(
                          icon: Icon(Icons.replay, size: 36, color: Colors.white),
                          onPressed: () {
                            // initial();
                          }
                        ),
                      ),
                    ),
                  )
                ],
              )
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
        child: pairs[widget.tileIndex].getImageAssetPath() != ''
        ? Image.asset(
          pairs[widget.tileIndex].getIsSelected() ? pairs[widget.tileIndex].getImageAssetPath() : widget.imageAssetPath
        )
        : Image.asset('assets/images/answerPoint.png'),
        
        onPressed: () {
          if(!selected) {
            if(selectedImageAssetPath != '') {

              if(selectedImageAssetPath == pairs[widget.tileIndex].getImageAssetPath()) {
                //correct choice
                print('correct');
                selected = true;
                Future.delayed(const Duration(seconds: 2), () {
                  points = points + 10;
                  selected = false;
                  widget.parent.setState((){
                    pairs[widget.tileIndex].setImageAssetPath('');
                    pairs[selectedTileIndex].setImageAssetPath('');
                  });
                  selectedImageAssetPath = '';
                });
              } else {
                //wrong choice
                print('wrong');
                selected = true;
                Future.delayed(const Duration(seconds: 2), () {
                  selected = false;
                  widget.parent.setState((){
                    pairs[widget.tileIndex].setIsSelected(false);
                    pairs[selectedTileIndex].setIsSelected(false);
                  });
                  selectedImageAssetPath = '';
                });
              }
              
            } else {
              selectedTileIndex = widget.tileIndex;
              selectedImageAssetPath = pairs[widget.tileIndex].getImageAssetPath();
            }

            setState(() {
              pairs[widget.tileIndex].setIsSelected(true);
            });
            // print('Tile selected');
          }
        },
      )
    );
  }
}


      
