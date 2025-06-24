import 'package:flutter/material.dart';

void main() {
  runApp(Contain_Ex());
}

class Contain_Ex extends StatelessWidget {
  const Contain_Ex({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Containers spacing",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          backgroundColor: Colors.orangeAccent,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Center(
              child: Container(
                //Box 1
                child: Text(
                  "Box 1",
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                height: 200.0,
                width: 300.0,
                margin: EdgeInsets.only(top: 20.0),
                padding: EdgeInsets.only(
                  top: 50.0,
                ), //for the child inside the container, here it is text widget
                color: Colors.yellowAccent,
              ),
            ),
            SizedBox(height: 30.0), //Space between containers
            Container(
              //Box 2
              height: 200.0,
              width: 300.0,
              color: Colors.yellowAccent,
              child: Column(
                //For adding text inside box 2
                children: [
                  Text(
                    "Box 2",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    //for adding 3 containers inside box 2 in a row
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween, //gives spaces between the containers inside box 2
                    children: [
                      Expanded(
                        child: Container(
                          height: 100,
                          //width: 500, //if you want the containers to auto-resize equally within the Row (which is usually the goal with 3 boxes like this), then use Expanded and remove the width
                          color: Colors.grey,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                        ),
                      ),
                      //Spacer(flex: 1), Spacer has more priority than mainAxisAlignment
                      Expanded(
                        child: Container(
                          height: 100,
                          //width: 500,
                          color: Colors.grey,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                        ),
                      ),
                      //Spacer(flex: 1),
                      Expanded(
                        child: Container(
                          height: 100,
                          //width: 500,
                          color: Colors.grey,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
