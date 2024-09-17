import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_scanner/db%20services/db_services.dart';
import 'package:qr_scanner/views/settings.dart';
import '../Components/button.dart';
import '../Components/textfield.dart';
import '../db services/database_helper.dart';
import '../main.dart';
import 'menu.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final usrName = TextEditingController();
  final password = TextEditingController();
  bool isChecked = false;
  bool isLoginTrue = false;

  final db = DatabaseHelper();
  final gradient = LinearGradient(colors: [
    Colors.blueAccent,
    Colors.redAccent,
    Colors.amber,
  ]);
  final textstyle =
      TextStyle(fontSize: 35, fontWeight: FontWeight.bold, shadows: [
    BoxShadow(
      color: Colors.white,
      spreadRadius: 5,
      offset: Offset(1, 1),
    ),
  ]);
  DB database = DB();
  void loginadmin() {
    String name = "admin";
    String Password = "123";
    if (usrName.text.isNotEmpty && password.text.isNotEmpty) {
      if (usrName.text == name && password.text == Password) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Menu()));
      } else {
        //Otherwise show the error message
        setState(() {
          isLoginTrue = true;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please Enter  username and password")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("LOGIN", style: textstyle),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.red,
            ),
            onPressed: () {
              navigatorKey.currentState?.push(MaterialPageRoute(
                  builder: (_) => Settings(
                        database: database,
                      )));
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (bounds) {
                return gradient.createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height));
              },
              // child: Text(
              //  "Login",
              //  style: textstyle ),
            ),
            Expanded(child: Image.asset("assets/startup.jpg")),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputField(
                    hint: "Username",
                    icon: Icons.account_circle,
                    controller: usrName),
                InputField(
                    hint: "Password",
                    icon: Icons.lock,
                    controller: password,
                    passwordInvisible: true),

                SizedBox(
                  height: 35,
                ),

                //Our login button
                Button(
                    label: "LOGIN",
                    press: () {
                      // login();
                      loginadmin();
                    }),

                Button(
                    label: "EXIT",
                    press: () {
                      SystemNavigator.pop();
                    }),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Text("Don't have an account?",style: TextStyle(color: Colors.grey),),
                //     TextButton(
                //         onPressed: (){
                //           Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignupScreen()));
                //         },
                //         child: const Text("SIGN UP"))
                //   ],
                // ),

                isLoginTrue
                    ? Text(
                        "Username or password is incorrect",
                        style: TextStyle(color: Colors.red.shade900),
                      )
                    : const SizedBox(),
              ],
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
