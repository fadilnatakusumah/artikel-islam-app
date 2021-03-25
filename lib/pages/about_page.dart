import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          "Tentang aplikasi",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Image.asset(
                "assets/artikel_islam.png",
                width: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: RichText(
                softWrap: true,
                textAlign: TextAlign.justify,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text:
                            "Artikel Islam adalah aplikasi android untuk membantu mencari referensi bacaan atau tulisan islam. Dikembangkan oleh ",
                        style: TextStyle(color: Colors.black87, fontSize: 16)),
                    TextSpan(
                        text: "fadilnatakusumah",
                        style:
                            TextStyle(color: Colors.blue[900], fontSize: 16)),
                  ],
                ),
              ),
            )
            // Container(
            //   constraints: BoxConstraints(
            //       maxWidth: MediaQuery.of(context).size.width - 84),
            //   child:
            // )
          ],
        ),
      ),
    );
  }
}
