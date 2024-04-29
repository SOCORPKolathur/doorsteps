import 'package:doorsteps/Explore/bike%20taxi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const.dart';

class BikeTaxi2 extends StatefulWidget {
  const BikeTaxi2({Key? key}) : super(key: key);

  @override
  State<BikeTaxi2> createState() => _BikeTaxi2State();
}

class _BikeTaxi2State extends State<BikeTaxi2> {
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
              child: Image.asset("assets/biketaxi2.png",fit: BoxFit.cover,)),
          Padding(
            padding:  EdgeInsets.only(bottom: 80.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Text("Book \n Your \n Ride Now",style: GoogleFonts.poppins(
                    color: Color(0xff288340),
                    fontWeight: FontWeight.w800,
                    fontSize: width/7.84,
                  ),
                    textAlign: TextAlign.center,),
                ),
                SizedBox(height: 310,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Get your ride with full safety",style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: width/22.84,
                    )),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> BikeTaxi()));
                        },
                        child: Container(

                          width: 300,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Center(
                            child: Text("Book Ride",style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: width/22.84,
                            )),
                          ),
                        ),
                      ),
                    ),
                  ],
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}
