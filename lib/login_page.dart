import 'package:flutter/material.dart';
import 'package:votebreakfast/auth_service.dart';
import 'package:votebreakfast/login_page_1.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: h,
            width: w,
            child: Image.network('https://s2.best-wallpaper.net/wallpaper/iphone/1707/Bread-blue-cup-breakfast_iphone_640x1136.jpg')),
        Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Sign Up"),
          backgroundColor: Colors.blueAccent,
        ),
        body: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.only(
              left: 20, right: 20, top: size.height * 0.2, bottom: size.height * 0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Colors.white,
                child: const Text("Vote for Breakfast",
                    style: TextStyle(
                      color: Colors.blue,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                    )),
              ),
              GestureDetector(
                  onTap: () {
                    AuthService().signInWithGoogle();
                  },
                  child: Container(height: 50, child: Image.network('https://www.oncrashreboot.com/images/create-apple-google-signin-buttons-quick-dirty-way-google.png'))
              ),
              TextButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              }, child: Text('Login with SMS and OTP'))
            ],
          ),
        ),
      ),
    ],
    );
  }
}