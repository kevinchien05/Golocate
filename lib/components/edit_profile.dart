import 'package:flutter/material.dart';
import 'package:golocate/components/home_page.dart';
import 'package:golocate/go_provider/register_provider.dart';
import 'package:golocate/go_provider/sharedPref_provider.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {

  Widget _Information(String headname, TextEditingController data) {
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
              child: TextField(
                controller: data,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: headname,
                ),
              ),
            ),
          ]),
        ));
  }

  @override

  Widget build(BuildContext context) {
    var regisPro = Provider.of<RegisterProvider>(context);
    var DarkOn = Provider.of<isGelap>(context);

    return FutureBuilder(
        future: DarkOn.getPreference(),
        builder:(context, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: DarkOn.isDark ? DarkOn.dark : DarkOn.light,
          home: Scaffold(
          appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Edit Profile',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  for (var i = 0; i < regisPro.getUserList.length; i++) {
                    if (regisPro.getActiveUser[0]['user_id'] ==
                        regisPro.getUserList[i]['user_id']) {
                      regisPro.changeBio(
                          i,
                          regisPro.getUserController.text,
                          regisPro.getPhoneController.text,
                          regisPro.getGenderController.text,
                          regisPro.getBirthController.text,
                          regisPro.getPlaceController.text,
                          regisPro.getBioController.text);
                    }
                  }
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                },
                child: const Text(
                  'Save & Relog',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ))
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                      radius: 50,
                      child: Text(
                        regisPro.getActiveUser[0]['username']
                            .toString()
                            .substring(0, 1)
                            .toUpperCase(),
                        style: TextStyle(fontSize: 30),
                      )),
                ),
                _Information('Username', regisPro.getUserController),
                _Information('Phone', regisPro.getPhoneController),
                _Information('Gender', regisPro.getGenderController),
                _Information('Date of Birth', regisPro.getBirthController),
                _Information('Place of Birth', regisPro.getPlaceController),
                _Information('Bio', regisPro.getBioController),
                const SizedBox(
                  height: 30),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: SwitchListTile(
                      title: Text('Dark Mode'),
                      secondary: Icon(Icons.dark_mode_rounded),
                      value: DarkOn.isOn, 
                      onChanged: (val){
                        setState(() {
                          DarkOn.changeTheme();
                        });
                      }
                    )
                )
              ],
            ),
          )),
      ),)
    );
  }
}
