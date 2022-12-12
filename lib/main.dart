import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:golocate/components/splashscreen.dart';
import 'package:golocate/go_provider/home_provider.dart';
import 'package:golocate/go_provider/rating_provider.dart';
import 'package:golocate/go_provider/register_provider.dart';
import 'package:golocate/go_provider/sharedPref_provider.dart';
import 'package:golocate/go_provider/tiket_provider.dart';
import 'package:provider/provider.dart';

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
Future<void> main() async {
  HttpOverrides.global = PostHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => RegisterProvider()),
      ChangeNotifierProvider(create: (context) => HomeProvider()),
      ChangeNotifierProvider(create: (context) => TiketProvider()),
      ChangeNotifierProvider(create: (context) => RatingProvider()),
      ChangeNotifierProvider(create: (context)=> isGelap())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var DarkOn = Provider.of<isGelap>(context);
    return FutureBuilder(
      future: DarkOn.getPreference(),
      builder: (context, _)=> MaterialApp(
          theme: DarkOn.isDark ? DarkOn.dark : DarkOn.light,
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        ),
    );
  }
}
