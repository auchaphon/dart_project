import 'dart:convert';

import 'package:dart_app/models/Flight.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// UserTransactions
class Home extends StatefulWidget {
  static const routeName = '/home';
  final String title;
  final String message;
  const Home({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Flight> _flight = [];

  _HomeState() {
    fetchFlight();
  }

  @override
  void initState() {
    super.initState();
    fetchFlight();
  }

  Future<void> fetchFlight() async {
    final response =
        await http.get('https://flutter-lab-33921.firebaseio.com/Flight.json');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<dynamic> responseJson = json.decode(response.body);
      var lists = responseJson.map((m) => new Flight.fromJson(m)).toList();
      setState(() {
        _flight = lists;
      });

      // jsonResult.forEach((prodId, prodData) {
      //   // print(prodData);
      //   _flight.add(Flight(
      //     name: prodData['name'],
      //     logo: prodData['logo'],
      //     price: double.parse(prodData['price']),
      //     seat: int.parse(prodData['seat']),
      //     type: prodData['type'],
      //     date: DateTime.now(),
      //   ));
      // });

      // setState(() {});
      // var jsonResult = Flight.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  void navigateToLogin(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', false);
    Navigator.pop(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ..._flight.map((f) {
              return Row(
                children: <Widget>[
                  Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 5, right: 5),
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width - 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Image(
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                  image: NetworkImage(f.logo)),
                              Text(f.name)
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text("9:00"),
                              Text(f.type),
                              Text("6h 30m")
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text("BLR - DEL"),
                              FlatButton(
                                child: Text(f.price.toString()),
                                textColor: Colors.grey[800],
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.orange,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(50)),
                                // textColor: Colors.blueGrey[500],
                                color: Colors.orangeAccent[200],
                                onPressed: () => {},
                              ),
                            ],
                          )
                        ],
                      ))
                ],
              );
            }).toList(),
            FlatButton(
              child: Text('Logout'),
              textColor: Colors.red,
              color: Colors.orange,
              onPressed: () => navigateToLogin(context),
            ),
          ],
        ),
        padding: EdgeInsets.only(top: 20),
      ),
    );
  }
}
