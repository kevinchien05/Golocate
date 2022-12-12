import 'package:flutter/material.dart';
import 'package:golocate/components/edit_profile.dart';
import 'package:golocate/go_provider/register_provider.dart';
import 'package:provider/provider.dart';

import '../../go_provider/sharedPref_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget _Information(String headname, String data) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
              child: Text(headname,
                  style: const TextStyle(fontSize: 18, color: Colors.grey)),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(10, 0, 20, 10),
              child: Text(
                data,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    var regisPro = Provider.of<RegisterProvider>(context);
    var _width = MediaQuery.of(context).size.width;
    var _heigth = MediaQuery.of(context).size.height;
    var DarkOn = Provider.of<isGelap>(context);
    return FutureBuilder(
      future: DarkOn.getPreference(),
      builder: (context, _)=> MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: DarkOn.isDark ? DarkOn.dark : DarkOn.light,
        home: Scaffold(
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                    child: CircleAvatar(
                      radius: 50,
                      child: Text(
                        regisPro.getActiveUser[0]['username']
                            .toString()
                            .substring(0, 1)
                            .toUpperCase(),
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            topLeft: Radius.circular(40.0))),
                    width: 460,
                    height: 800,
                    child: Column(
                      children: [
                        _Information("Username",
                            regisPro.getActiveUser[0]['username'].toString()),
                        Divider(
                          height: 8,
                          color: Colors.grey[350],
                        ),
                        _Information("Email Address",
                            regisPro.getActiveUser[0]['email'].toString()),
                        Divider(
                          height: 8,
                          color: Colors.grey[350],
                        ),
                        _Information(
                            "Phone", regisPro.getActiveUser[0]['phone'].toString()),
                        Divider(
                          height: 8,
                          color: Colors.grey[350],
                        ),
                        _Information("Gender",
                            regisPro.getActiveUser[0]['gender'].toString()),
                        Divider(
                          height: 8,
                          color: Colors.grey[350],
                        ),
                        _Information("Date of Birth",
                            regisPro.getActiveUser[0]['birth'].toString()),
                        Divider(
                          height: 8,
                          color: Colors.grey[350],
                        ),
                        _Information("Place of Birth",
                            regisPro.getActiveUser[0]['place'].toString()),
                        Divider(
                          height: 8,
                          color: Colors.grey[350],
                        ),
                        _Information(
                            "Bio", regisPro.getActiveUser[0]['bio'].toString()),
                        Container(
                          width: 460,
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 30, right: 30, top: 15),
                          width: 460,
                          height: 70,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.background),
                              onPressed: () {
                                regisPro.getUserController.text = regisPro.getActiveUser[0]['username'].toString();
                                regisPro.getPhoneController.text = regisPro.getActiveUser[0]['phone'].toString();
                                regisPro.getGenderController.text = regisPro.getActiveUser[0]['gender'].toString();
                                regisPro.getBirthController.text = regisPro.getActiveUser[0]['birth'].toString();
                                regisPro.getPlaceController.text = regisPro.getActiveUser[0]['place'].toString();
                                regisPro.getBioController.text = regisPro.getActiveUser[0]['bio'].toString();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const EditProfile()));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: const [
                                Text('Edit Profile',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                Padding(
                                  padding: EdgeInsets.only(left: 105),
                                  child: Icon(Icons.arrow_forward_ios_rounded),
                                )
                              ])),
                        )
                      ],
                    ))
              ],
            ),
          )),
        ),
      ),
    );
  }
}
