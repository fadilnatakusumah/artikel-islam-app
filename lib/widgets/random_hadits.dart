import 'dart:math';

import 'package:artikel_islam/constants/strings.dart';
import 'package:artikel_islam/utlis/theme.dart';
import 'package:flutter/material.dart';

class RandomHadits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int index = random.nextInt(9);
    // int index = 0;

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black12, width: 1)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
          bottom: 15,
        ),
        child: Column(
          children: [
            Row(children: [
              Icon(Icons.ac_unit_sharp),
              SizedBox(width: 10),
              Text(
                "Nasihat Hadits",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyTheme.secondaryLight,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    LIST_HADITS[index].text,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(height: 8),
                  Text(
                    LIST_HADITS[index].translate,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    LIST_HADITS[index].reference,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
