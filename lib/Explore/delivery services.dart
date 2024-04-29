import 'package:doorsteps/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'delivery2.dart';

class DeliveryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
    backgroundColor: primarycolor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Padding(
            padding: const EdgeInsets.only(top: 80.0,right: 8,left: 8),
            child: Text("We Delivery \nAnything you need..",style: GoogleFonts.poppins(
              fontSize: 27,
              fontWeight: FontWeight.w700,
              color: Colors.white
            ),),
          ),
          Padding(
            padding: const EdgeInsets.only(top:30.0),
            child: Image.asset("assets/delivery.png"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    width: 340,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0,left: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pickup or Drop an items",style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                      ),),

                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context)=>Delivery2())
                                );
                              },
                              child: Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(6),

                                child: Container(
                                  width: 290,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.deepOrangeAccent,
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: Center(
                                    child: Text("ADD PICK/DROP DETAILS",style: GoogleFonts.poppins(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white
                                    ),),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Make your work \n More Easier \n With DoorSteps",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),),
              ],
            ),
          ),

          

        ],
      ),
    );
  }
}

