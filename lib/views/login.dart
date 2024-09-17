// import 'package:flutter/material.dart';
// import 'package:qr_scanner/views/home1.dart';
//
// import 'package:shared_preferences/shared_preferences.dart';
// import '../Components/button.dart';
// import '../Components/colors.dart';
// import '../Components/textfield.dart';
// import '../JSON/users.dart';
// import '../db services/database_helper.dart';
// import 'home.dart';
//
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   //Our controllers
//   //Controller is used to take the value from user and pass it to database
//   final usrName = TextEditingController();
//   final password = TextEditingController();
//
//   bool isChecked = false;
//   bool isLoginTrue = false;
//
//   final db = DatabaseHelper();
//   //Login Method
//   //We will take the value of text fields using controllers in order to verify whether details are correct or not
//   login() async {
//     Users? usrDetails = await db.getUser(usrName.text);
//     var res = await db
//         .authenticate(Users(usrName: usrName.text, password: password.text));
//     if (res == true) {
//       //If result is correct then go to profile or home
//       if (!mounted) return;
//       //Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile(profile: usrDetails)));
//     } else {
//       //Otherwise show the error message
//       setState(() {
//         isLoginTrue = true;
//       });
//     }
//   }
//
//   void loginadmin() async {
//     String name = "admin";
//     String Password = "123";
//     if (usrName.text == name && password.text == Password) {
//       SharedPreferences sp = await SharedPreferences.getInstance();
//       sp.setString("userName", usrName.text);
//       sp.setString("password", password.text);
//       Navigator.push(context, MaterialPageRoute(builder: (context) => Home1()));
//     } else {
//       //Otherwise show the error message
//       setState(() {
//         isLoginTrue = true;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.sizeOf(context);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//          centerTitle: true,
//
//       ),
//       body: Center(
//         child: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//                 Expanded(child: Image.asset("assets/Smart pro logo.jpg")),
//
//               InputField(
//                   hint: "Username",
//                   icon: Icons.account_circle,
//                   controller: usrName),
//               InputField(
//                   hint: "Password",
//                   icon: Icons.lock,
//                   controller: password,
//                   passwordInvisible: true),
//               const  SizedBox(
//                 height:50,
//               ),
//
//
//               //Our login button
//               Button(
//                   label: "LOGIN",
//                   press: () {
//                     // login();
//                     loginadmin();
//                   }),
//               SizedBox(
//                 height:200,
//               ),
//
//
//               isLoginTrue
//                   ? Text(
//                       "Username or password is incorrect",
//                       style: TextStyle(color: Colors.red.shade900),
//                     )
//                   : const SizedBox(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:qr_scanner/views/home1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Components/button.dart';
import '../Components/colors.dart';
import '../Components/textfield.dart';
import '../JSON/users.dart';
import '../db services/database_helper.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usrName = TextEditingController();
  final password = TextEditingController();

  bool isChecked = false;
  bool isLoginTrue = false;

  final db = DatabaseHelper();

  login() async {
    Users? usrDetails = await db.getUser(usrName.text);
    var res = await db
        .authenticate(Users(usrName: usrName.text, password: password.text));
    if (res == true) {
      if (!mounted) return;
      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile(profile: usrDetails)));
    } else {
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  void loginadmin() async {
    String name = "admin";
    String Password = "123";
    if (usrName.text == name && password.text == Password) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString("userName", usrName.text);
      sp.setString("password", password.text);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home1()));
    } else {
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double screenWidth = size.width;
    final double screenHeight = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          '',
          style: TextStyle(
            color: Colors.black,
            fontSize: screenWidth * 0.05, // Responsive font size
          ),
        ),
      ),
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo with responsive sizing
                Container(
                  width: screenWidth * 0.6, // Adjust width as needed
                  child: AspectRatio(
                    aspectRatio: 1, // Maintain aspect ratio
                    child: Image.asset("assets/Smart pro logo.jpg"),
                  ),
                ),

                SizedBox(height: screenHeight * 0.05),

                // Username and Password fields with responsive heights
                InputField(
                  hint: "Username",
                  icon: Icons.account_circle,
                  controller: usrName,
                ),
                SizedBox(height: screenHeight * 0.02),

                InputField(
                  hint: "Password",
                  icon: Icons.lock,
                  controller: password,
                  passwordInvisible: true,
                ),

                SizedBox(height: screenHeight * 0.05),

                // Login button with responsive size
                Button(
                  label: "LOGIN",
                  press: () {
                    loginadmin();
                  },
                ),

                SizedBox(height: screenHeight * 0.2),

                isLoginTrue
                    ? Text(
                  "Username or password is incorrect",
                  style: TextStyle(
                    color: Colors.red.shade900,
                    fontSize: screenWidth * 0.04, // Responsive font size
                  ),
                )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
