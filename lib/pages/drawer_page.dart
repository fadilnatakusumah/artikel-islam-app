import 'package:flutter/material.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = TextStyle(
      color: Colors.black,
      fontSize: 20,
    );
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.black45),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: Text('CHECK'),
              ),
            ),
          ),
//          ListTile(
//            leading: Icon(
//              Icons.settings,
//              size: 24,
//              color: Colors.black,
//            ),
//            title: Text(
//              "Settings",
//              style: _textStyle,
//            ),
//          ),
          InkWell(
            onTap: () {
              print("TO ABOUT PAGE");
            },
            child: ListTile(
              leading: Icon(
                Icons.info,
                size: 20,
                color: Colors.black,
              ),
              title: Text(
                "About",
                style: _textStyle,
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('version 1.0.0'),
                Text(
                  'made by fadilnatakusumah',
                  style: TextStyle(color: Colors.black45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
