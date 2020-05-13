import 'package:dart_app/widgets/home/index.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// UserTransactions
class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  void _login() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIsLogin();
  }

  getIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('isLogin');
    if (isLogin == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  }

  void navigateToInside(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', true);
    Navigator.of(context).pushNamed(
      Home.routeName,
      arguments: {
        'id': 'xx',
        'title': 'yy',
      },
    );
  }

  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Login",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )),
            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Please sign in to continue",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                )),
            TextField(
              decoration: InputDecoration(labelText: 'EMAIL'),
              controller: userNameController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'PASSWORD'),
              controller: passwordController,
              obscureText: true,
            ),
            FlatButton(
              child: Text('Login'),
              textColor: Colors.red,
              color: Colors.orange,
              onPressed: () => navigateToInside(context),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Don't have any Account?",
                          textAlign: TextAlign.left,
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[500]),
                        ),
                        Text(
                          " Sign up",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.orangeAccent),
                        )
                      ],
                    )))
          ],
        ));
  }
}
