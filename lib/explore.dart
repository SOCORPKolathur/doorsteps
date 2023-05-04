import 'package:doorsteps/Explore/fruits.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorsteps/const.dart';
import 'package:doorsteps/productpage.dart';
import 'package:doorsteps/slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {

  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text("Find Products",style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: width/15.84,
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0,right: 20,left: 20,bottom: 10),
              child: Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                    color: Color(0xffF2F3F2),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Center(
                    child: TextField(

                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Search Products",
                        prefixIcon: Icon(Icons.search),
                        hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: width/26.84,
                        ),


                        border: InputBorder.none,

                      ),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: width/22.84,
                      ),
                    )
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=>Fruits())
                    );
                  },
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                        color: Color(0xff53B175).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Color(0xff53B175).withOpacity(0.70)

                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CachedNetworkImage(imageUrl:vega),
                        Text("Fresh Fruits \n & Vegetables",style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: width/20.84,
                        ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                      color: Color(0xffF8A44C).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Color(0xffF8A44C).withOpacity(0.70)

                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(imageUrl:gocery),
                      Text("Grocery",style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: width/20.84,
                      ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                        color: Color(0xffF7A593).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Color(0xffF7A593).withOpacity(0.70)

                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CachedNetworkImage(imageUrl:meat),
                        Text("Meat",style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: width/20.84,
                        ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                        color: Color(0xffD3B0E0).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Color(0xffD3B0E0).withOpacity(0.70)

                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CachedNetworkImage(imageUrl:backery),
                        Text("Bakery & Snacks",style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: width/20.84,
                        ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                        color: Color(0xffB7DFF5).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Color(0xffB7DFF5).withOpacity(0.70)

                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height:100,
                            child: CachedNetworkImage(imageUrl:medicne)),
                        Text("Medicine",style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: width/20.84,
                        ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                        color: Color(0xffFDE598).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Color(0xffFDE598).withOpacity(0.70)

                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height:100,
                            child: CachedNetworkImage(imageUrl:food)),
                        Text("Hotels & Fast Food",style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: width/20.84,
                        ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                        color: Color(0xffF79393).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Color(0xffF79393).withOpacity(0.70)

                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height:100,
                            child: CachedNetworkImage(imageUrl:deleviry)),
                        Text("Delivery Services",style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: width/20.84,
                        ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                        color: Colors.yellow.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.yellow.withOpacity(0.70)

                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height:110,
                            child: CachedNetworkImage(imageUrl:bike,fit: BoxFit.cover,)),
                        Text("Bike Taxi",style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: width/20.84,
                        ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),



          ],
        ),
      ),
    );
  }
}
