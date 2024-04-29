import 'package:doorsteps/signin.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import 'const.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset("assets/8140 1.png",fit: BoxFit.cover,)),
          Padding(
            padding:  EdgeInsets.only(bottom: 80.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(logo),
                Text("Welcome \n to our Store",style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: width/7.84,
                ),
                textAlign: TextAlign.center,),
                Text("Ger your groceries in as fast as one hour",style: GoogleFonts.poppins(
                color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: width/22.84,
                )),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: GestureDetector(
                    onTap: () async {
                      getUserCurrentLocation();

                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=> Signin())
                      );
                    },
                    child: Container(

                      width: 300,
                      height: 60,
                      decoration: BoxDecoration(
                          color: primarycolor,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(
                        child: Text("Get Started",style: GoogleFonts.poppins(
                        color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: width/22.84,
                        )),
                      ),
                    ),
                  ),
                )

              ],
            ),
          )
        ],
      ),

    );
  }
}
