import 'package:flutter/material.dart';
import 'package:golocate/components/login_page.dart';
import 'package:golocate/go_provider/register_provider.dart';
import 'package:provider/provider.dart';

class ForgetPage extends StatefulWidget {
  const ForgetPage({Key? key}) : super(key: key);

  @override
  State<ForgetPage> createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {
  //Text Editing Controller
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

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
                        MaterialPageRoute(builder: (context) => const LoginPage()));
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
                    width: _width*0.2,
                    color: const Color(0xFF039BE5),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Forget Password",
                    style: TextStyle(color: Color(0xFF039BE5), fontSize: _width*0.07),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: _width*0.75,
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                        border: OutlineInputBorder(),
                        hintText: 'Email Address',
                        prefixIcon: Icon(Icons.email),
                        errorText: regisPro.getForgetEmailEmpty == true
                            ? "Enter Email Address"
                            : regisPro.getForgetEmailRight == true
                                ? "Email not found"
                                : null),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: _width*0.75,
                  child: TextField(
                    controller: passwordController,
                    textAlignVertical: TextAlignVertical.center,
                    obscureText: regisPro.getForgetPassHide,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                        border: OutlineInputBorder(),
                        hintText: 'Old Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              regisPro.setForgetPassHide();
                            },
                            icon: regisPro.getForgetPassHide == true
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility)),
                        errorText: regisPro.getForgetPassEmpty == true
                            ? "Enter Password"
                            : regisPro.getForgetOldRight == true
                                ? "Use 6 characters or more for your password"
                                : null),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: _width*0.75,
                  child: TextField(
                    controller: newPasswordController,
                    obscureText: regisPro.getForgetNewHide,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                      border: OutlineInputBorder(),
                      hintText: 'New Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: () {
                            regisPro.setForgetNewHide();
                          },
                          icon: regisPro.getForgetNewHide == true
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility)),
                      errorText: regisPro.getForgetNewEmpty == true
                          ? "Enter Password"
                          : regisPro.getForgetNewRight == true
                              ? "Use 6 characters or more for your password"
                              : null,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: _width*0.75,
                  height: _heigth*0.055,
                  child: ElevatedButton(
                      onPressed: () {
                        if (emailController.text == "") {
                          regisPro.setForgetEmailEmpty = true;
                        } else if (emailController.text != "") {
                          regisPro.setForgetEmailEmpty = false;
                        }
                        if (passwordController.text == "") {
                          regisPro.setForgetPassEmpty = true;
                        } else if (passwordController.text != "") {
                          regisPro.setForgetPassEmpty = false;
                        }
                        if (newPasswordController.text == "") {
                          regisPro.setForgetNewEmpty = true;
                        } else if (newPasswordController.text != "") {
                          regisPro.setForgetNewEmpty = false;
                        }
                        if (passwordController.text.length < 6) {
                          regisPro.setForgetOldRight = true;
                        } else if (passwordController.text.length >= 6) {
                          regisPro.setForgetOldRight = false;
                        }
                        if (newPasswordController.text.length < 6) {
                          regisPro.setForgetNewRight = true;
                        } else if (newPasswordController.text.length >= 6) {
                          regisPro.setForgetNewRight = false;
                        }
                        if (regisPro.getUserList.isEmpty) {
                          regisPro.setForgetEmailRight = true;
                        } else if (emailController.text != "" &&
                            passwordController.text != "" &&
                            newPasswordController.text != "" &&
                            passwordController.text.length >= 6 &&
                            newPasswordController.text.length >= 6) {
                          for (var i = 0;
                              i < regisPro.getUserList.length;
                              i++) {
                            if (regisPro.getUserList[i]['email']!
                                    .toLowerCase() ==
                                emailController.text.toLowerCase()) {
                              regisPro.changePass(
                                  i, newPasswordController.text);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            } else {
                              regisPro.setForgetEmailRight = true;
                            }
                          }
                        }
                      },
                      child: const Text("Submit")),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
