import 'package:doorsteps/Homepage.dart';
import 'package:doorsteps/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';

import 'Locationpage.dart';
import 'WelcomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Door Steps',
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context).copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: primarycolor,
      ),
        ),
      home:  FirebaseAuth.instance.currentUser==null?WelcomePage():LocationPage("1654654654",false),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    return SplashScreen(
      seconds: 5,
      photoSize: width/3.92,
      useLoader: true,
      backgroundColor:  primarycolor,
      title: Text("Door Steps",style: GoogleFonts.rowdies(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: width/7.84,
      )),
      image: Image.asset("assets/logo.png",
        fit: BoxFit.contain,
        alignment: Alignment.center,
      ),
      loadingText: Text("You name it,We carry it", textAlign: TextAlign.center,style: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: width/21.7,
      ),),
      navigateAfterSeconds:WelcomePage(),
    );
  }
}
