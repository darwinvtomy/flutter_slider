import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  List _data = await getJson();
  print(_data);
//  print(_data[0]['data']);
  for (int i = 0; i < _data.length; i++) {
    print(_data[i]['season']);
  }

  runApp(new MaterialApp(
    home: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(
                text: "UPCOMING",
              ),
              Tab(
                text: "LIVE",
              ),
              Tab(
                text: "COMPLETED",
              ),
            ],
          ),
          title: Text('Games'),
        ),
        body: TabBarView(
          children: <Widget>[
            new Center(
              child: new ListView.builder(
                itemCount: _data.length,
                padding: const EdgeInsets.all(16.0),
                itemBuilder: (BuildContext context, int position) {
                  if (position.isOdd) {
                    return new Divider();
                  }
                  final index = position ~/ 2; //We are dividing position by 2

                  return new Card(
                      child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Align(
                        child: new Text(
                          '${_data[index]['season']}',
                          style: new TextStyle(fontSize: 23.0),
                          textAlign: TextAlign.center,
                        ), //so big text
                        alignment: FractionalOffset.topCenter,
                      ),
                      new Align(
                        child: new Text(
                          '${_data[index]['relatedName']}',
                        ),
                        alignment: FractionalOffset.topCenter,
                      ),
                      new Row(
                        children: [
                          new Padding(padding: new EdgeInsets.all(5.0)),
                          new Expanded(
                            child: new Row(
                              children: [
                                new Icon(
                                  Icons.pause_circle_filled,
                                  //TODO-------Just need to change to a flage image from API
                                  size: 50.2,
                                  color: Colors.green,
                                ),
                                new Container(
                                  child: new Text(
                                    '${_data[index]['teams']['a']['name']}',
                                    style: new TextStyle(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          new Align(
                            child: new Row(
                              children: [
                                new Container(
                                  child: new Text(
                                    '${_data[index]['teams']['b']['name']}',
                                    style: new TextStyle(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                new Icon(
                                  Icons.pause_circle_filled,
                                  //TODO-------Just need to change to a flage image from API
                                  size: 50.2,
                                  color: Colors.green,
                                ),
                                new Padding(padding: new EdgeInsets.all(5.0)),
                              ],
                            ),
                            alignment: FractionalOffset.bottomRight,
                          ),
                        ],
                      ),
                    ],
                  ));
                },
              ),
            ),
            new Column(
              children: <Widget>[
                new Align(
                  child: new Text(
                    "Centered Title ",
                    style: new TextStyle(fontSize: 40.0),
                  ), //so big text
                  alignment: FractionalOffset.topLeft,
                ),
                new Divider(
                  color: Colors.blue,
                ),
                new Align(
                  child: new Text("Subtitle "),
                  alignment: FractionalOffset.topLeft,
                ),
                new Divider(
                  color: Colors.blue,
                ),
                new Align(
                  child: new Text("More stuff "),
                  alignment: FractionalOffset.topLeft,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    //add some actions, icons...etc
                    new FlatButton(onPressed: () {}, child: new Text("EDIT")),
                    new FlatButton(
                        onPressed: () {},
                        child: new Text(
                          "DELETE",
                          style: new TextStyle(color: Colors.redAccent),
                        ))
                  ],
                ),
              ],
            ),
            /* new Icon((Icons.directions_transit)),*/
            new Icon((Icons.directions_bike)),
          ],
        ),
      ),
    ),
  ));
}

Future<List> getJson() async {
  String apiurl =
      "http://www.mocky.io/v2/5b2a3d5c3000004e009cd297"; //TODO-------PLEASE UPDATE THE URL IF MOCK DOESN'T WORK
  //TODO--SAMPLE CAN BE FOUND IN flutter_slider/SampleJSON/gameslist.json
  http.Response response = await http.get(apiurl);

  return json.decode(response.body)['data']; //Returns  list Type
}
