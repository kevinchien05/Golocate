import 'package:flutter/material.dart';
import 'package:golocate/back_end/firebase/my_analytics_helper.dart';
import 'package:golocate/components/forget_page.dart';
import 'package:golocate/components/home_page.dart';
import 'package:golocate/components/register_page.dart';
import 'package:golocate/go_provider/register_provider.dart';
import 'package:provider/provider.dart';
import 'package:localization/localization.dart';
import '../go_provider/sharedPref_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Text Editing Controller
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPassController = TextEditingController();
  MyAnalyticsHelper fbAnalytics = MyAnalyticsHelper();
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _heigth = MediaQuery.of(context).size.height;
    var regisPro = Provider.of<RegisterProvider>(context);
    var DarkOn = Provider.of<isGelap>(context);
    return FutureBuilder(
      future: DarkOn.getPreference(),
      builder: (context,_)=> MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: DarkOn.isDark ? DarkOn.dark : DarkOn.light,
        home: Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(top: 60, left: 10, right: 10),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/Logo.png',
                        width: _width * 0.2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome_on".i18n(),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,fontSize: _width * 0.035),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'GOLOCATE',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary, fontSize: _width * 0.07),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: _width * 0.75,
                      child: TextField(
                        controller: loginEmailController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                            border: OutlineInputBorder(),
                            hintText: "Email_address".i18n(),
                            prefixIcon: Icon(Icons.email),
                            errorText: regisPro.getLoginEmail == true
                                ? "Email_must".i18n()
                                : regisPro.getLoginRight == true
                                    ? "Email_not_found".i18n()
                                    : null),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: _width * 0.75,
                      child: TextField(
                        controller: loginPassController,
                        textAlignVertical: TextAlignVertical.center,
                        obscureText: regisPro.getLoginPassHide,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                            border: OutlineInputBorder(),
                            hintText: "Password".i18n(),
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  regisPro.setLoginPassHide();
                                },
                                icon: regisPro.getLoginPassHide == true
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility)),
                            errorText: regisPro.getLoginPass == true
                                ? "Password_must".i18n()
                                : regisPro.getLoginPassRight == true
                                    ? "Wrong_Password".i18n()
                                    : null),
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Container(
                      width: _width * 0.75,
                      height: 35,
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            regisPro.setForgetEmailEmpty = false;
                            regisPro.setForgetPassEmpty = false;
                            regisPro.setForgetNewEmpty = false;
                            regisPro.setForgetOldRight = false;
                            regisPro.setForgetNewRight = false;
                            regisPro.setForgetEmailRight = false;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgetPage()));
                          },
                          child: Text("Forget_Password".i18n())),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: _width * 0.75,
                      height: _heigth * 0.055,
                      child: ElevatedButton(
                        onPressed: () {
                          fbAnalytics.testEventLog("User Login");
                          if (loginEmailController.text == "") {
                            regisPro.setLoginEmail = true;
                          } else if (loginEmailController.text != "") {
                            regisPro.setLoginEmail = false;
                          }
                          if (loginPassController.text == "") {
                            regisPro.setLoginPass = true;
                          } else if (loginPassController.text != "") {
                            regisPro.setLoginPass = false;
                          }
                          if (regisPro.getUserList.isEmpty) {
                            regisPro.setLoginRight = true;
                            regisPro.setLoginPassRight = true;
                          } else if (loginEmailController.text != "" &&
                              loginPassController.text != "") {
                            for (var i = 0;
                                i < regisPro.getUserList.length;
                                i++) {
                              print(regisPro.getUserList[i]['email'].toString());
                              print(
                                  regisPro.getUserList[i]['password'].toString());
                              print(loginEmailController.text.toString());
                              print(loginPassController.text.toString());
                              if (regisPro.getUserList[i]['email']!
                                          .toLowerCase() ==
                                      loginEmailController.text.toLowerCase() &&
                                  regisPro.getUserList[i]['password'] ==
                                      loginPassController.text) {
                                regisPro.setLoginRight = true;
                                regisPro.setLoginPassRight = true;
                                regisPro.removeUser();
                                regisPro.setActiveUser = {
                                  'user_id': regisPro.getUserList[i]['user_id']
                                      .toString(),
                                  "username": regisPro.getUserList[i]['username']
                                      .toString(),
                                  "email":
                                      regisPro.getUserList[i]['email'].toString(),
                                  "password": regisPro.getUserList[i]['password']
                                      .toString(),
                                  "point":
                                      regisPro.getUserList[i]['point'].toString(),
                                  'phone':
                                      regisPro.getUserList[i]['phone'].toString(),
                                  'gender': regisPro.getUserList[i]['gender']
                                      .toString(),
                                  'birth':
                                      regisPro.getUserList[i]['birth'].toString(),
                                  'place':
                                      regisPro.getUserList[i]['place'].toString(),
                                  'bio':
                                      regisPro.getUserList[i]['bio'].toString(),
                                };
                                regisPro.setLoginRight = false;
                                regisPro.setLoginPassRight = false;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                              } else {
                                regisPro.setLoginRight = true;
                                regisPro.setLoginPassRight = true;
                              }
                            }
                          }
                        },
                        child: Text("Button_Sign_in".i18n()),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Dont_have_acc".i18n()),
                          TextButton(
                              onPressed: () {
                                regisPro.setUsernameEmpty = false;
                                regisPro.setEmailEmpty = false;
                                regisPro.setPassEmpty = false;
                                regisPro.setConEmpty = false;
                                regisPro.setPassRight = false;
                                regisPro.setConRight = false;
                                regisPro.setLoginRight = false;
                                regisPro.setLoginPassRight = false;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterPage()));
                              },
                              child: Text("Sign_up".i18n()))
                        ],
                      ),
                    )
                  ],
                ))),
      ),
      )
    );
  }
}
