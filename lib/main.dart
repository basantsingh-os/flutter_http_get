import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MaterialApp(
      home: new HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  final String url = "https://reqres.in/api/users?page=1";
  List data;
  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(

        ///Encode Url
        Uri.encodeFull(url),

        /// accept json only
        headers: {"Accept": "application/json"});
    print(response.body);
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson["data"];
    });
    return "Success";
  }

  @override
  Widget build(BuildContext build) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("JSON HTTP get"),
        ),
        body: new ListView.builder(
          itemCount:data==null?0:data.length,
          
          itemBuilder: (BuildContext context, int index) {
            return new Container(
                child: new Center(
                    child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Card(
                    child: new Container(
                  child: new Text("FirstName: "+data[index]["first_name"] +"LastName :"+ data[index]["last_name"]),
                  padding: const EdgeInsets.all(20),
                ))
              ],
            )));
          },
        ));
  }
}






