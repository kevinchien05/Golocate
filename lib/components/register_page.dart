import 'package:flutter/material.dart';
import 'package:golocate/back_end/firebase/my_analytics_helper.dart';
import 'package:golocate/components/login_page.dart';
import 'package:golocate/go_provider/register_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Text Editing Controller
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conPasswordController = TextEditingController();
  var i = 1;
  MyAnalyticsHelper fbAnalytics = MyAnalyticsHelper();
  
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _heigth = MediaQuery.of(context).size.height;
    var regisPro = Provider.of<RegisterProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () {
                    regisPro.setLoginEmail = false;
                    regisPro.setLoginPass = false;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/Logo.png',
                    width: _width * 0.2,
                    color: const Color(0xFF039BE5),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Let's Get Started!",
                    style: TextStyle(
                        color: Color(0xFF039BE5), fontSize: _width * 0.07),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Create an account',
                    style: TextStyle(
                        color: Colors.grey[500], fontSize: _width * 0.04),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: _width * 0.75,
                  child: TextField(
                    controller: usernameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                        border: OutlineInputBorder(),
                        hintText: 'Name',
                        prefixIcon: Icon(Icons.account_circle),
                        errorText: regisPro.getUsernameEmpty == true
                            ? "Enter Username"
                            : null),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: _width * 0.75,
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                        border: OutlineInputBorder(),
                        hintText: 'Email Address',
                        prefixIcon: Icon(Icons.email),
                        errorText: regisPro.getEmailEmpty == true
                            ? "Enter Email Address"
                            : null),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: _width * 0.75,
                  child: TextField(
                    controller: passwordController,
                    textAlignVertical: TextAlignVertical.center,
                    obscureText: regisPro.getPassHide,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              regisPro.setPassHide();
                            },
                            icon: regisPro.getPassHide == true
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility)),
                        errorText: regisPro.getPassEmpty == true
                            ? "Enter Password"
                            : regisPro.getPassRight == true
                                ? "Use 6 characters or more for your password"
                                : null),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: _width * 0.75,
                  child: TextField(
                    controller: conPasswordController,
                    obscureText: regisPro.getConHide,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                      border: OutlineInputBorder(),
                      hintText: 'Confrim Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: () {
                            regisPro.setConHide();
                          },
                          icon: regisPro.getConHide == true
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility)),
                      errorText: regisPro.getConEmpty == true
                          ? "Enter Password"
                          : regisPro.getConRight == true
                              ? "Those password didn't match"
                              : null,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: _width * 0.75,
                  height: _heigth * 0.055,
                  child: ElevatedButton(
                      onPressed: () {
                        if (usernameController.text == "") {
                          regisPro.setUsernameEmpty = true;
                        } else if (usernameController.text != "") {
                          regisPro.setUsernameEmpty = false;
                        }
                        if (emailController.text == "") {
                          regisPro.setEmailEmpty = true;
                        } else if (emailController.text != "") {
                          regisPro.setEmailEmpty = false;
                        }
                        if (passwordController.text == "") {
                          regisPro.setPassEmpty = true;
                        } else if (passwordController.text != "") {
                          regisPro.setPassEmpty = false;
                        }
                        if (conPasswordController.text == "") {
                          regisPro.setConEmpty = true;
                        } else if (conPasswordController.text != "") {
                          regisPro.setConEmpty = false;
                        }
                        if (passwordController.text.length < 6) {
                          regisPro.setPassRight = true;
                        } else if (passwordController.text.length >= 6) {
                          regisPro.setPassRight = false;
                        }
                        if (passwordController.text ==
                            conPasswordController.text) {
                          regisPro.setConRight = false;
                        } else if (passwordController.text !=
                            conPasswordController.text) {
                          regisPro.setConRight = true;
                        }
                        if (usernameController.text != "" &&
                            emailController.text != "" &&
                            passwordController.text != "" &&
                            conPasswordController.text != "" &&
                            passwordController.text ==
                                conPasswordController.text &&
                            passwordController.text.length >= 6) {
                          regisPro.setIdUser = regisPro.getIdUser + 1;
                          regisPro.setUserList = {
                            'user_id': regisPro.getIdUser.toString(),
                            "username": usernameController.text,
                            "email": emailController.text,
                            "password": passwordController.text,
                            "point": "0",
                            'phone': '-',
                            'gender': '-',
                            'birth': '-',
                            'place': '-',
                            'bio': '-',
                          };
                          fbAnalytics.testSetUserId(usernameController.text);
                          fbAnalytics.testSetUserProperty();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        }
                      },
                      child: const Text("Sign up")),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                          onPressed: () {
                            regisPro.setLoginEmail = false;
                            regisPro.setLoginPass = false;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: const Text("Sign in"))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
