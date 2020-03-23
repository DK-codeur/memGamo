import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {

    bool inter = false;

    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Theme.of(context).accentColor
        ),       

        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget> [
                Container(
                  height: 160,
                  width: double.infinity,
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  color: Theme.of(context).accentColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 44,
                        child: FlutterLogo(
                          size: 42.0,
                        )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'MemGamo',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Pacifico',
                              fontSize: 18,
                              // fontWeight: FontWeight.w700
                            )
                          ),
                          SizedBox(width: 8.0,),
                          Text(
                            'Player',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'CenturyGhotic',
                              fontSize: 15
                            )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About game'),
                ),

                ListTile(
                  leading: Icon(Icons.brightness_6),
                  title: Text('Dark mode'),
                  trailing: Switch(
                    value: inter,
                    onChanged: (bool b) {
                      setState(() {
                        inter = b;
                      });
                    },
                  ),
                ),
                

              ]
            ),

            Text('build 1.0.1')
          ],
        ), 
      ),
    );
  }
}