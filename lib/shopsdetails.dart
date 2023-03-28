import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'const.dart';

class ShopD extends StatefulWidget {
  String  shopid;
  ShopD(this.shopid);

  @override
  State<ShopD> createState() => _ShopDState();
}

class _ShopDState extends State<ShopD> {
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
     body: FutureBuilder(
          future: FirebaseFirestore.instance.collection('Shops').doc(widget.shopid).get(),
          builder: (BuildContext context,  snapshot) {
            if (snapshot.hasData == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            Map<String, dynamic>? item = snapshot.data!.data();
            return Stack(
              children: [

                ClipRRect(borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20),),
                    child: Image.asset(productback)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0, left: 0),
                      child: Container(
                          width: double.infinity,
                          height: 300,

                          child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(18),

                                bottomRight: Radius.circular(18),
                              ),
                              child: CachedNetworkImage(imageUrl: item!["imgurl"],fit: BoxFit.cover,))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0, left: 20),
                      child: Text(item["name"], style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: width / 18.84,
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 20),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(Icons.location_on, color: Colors.black45,),
                          ),
                          Text(item["address"], style: GoogleFonts.poppins(
                            color: Colors.black45,
                            fontWeight: FontWeight.w700,
                            fontSize: width / 22.84,
                          ),),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 20),
                      child: Text("Shop Description", style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: width / 18.84,
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 20),
                      child: Text(item["des"],
                        style: GoogleFonts.poppins(
                          color: Colors.black45,
                          fontWeight: FontWeight.w600,
                          fontSize: width / 25.84,
                        ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 30),
                      child: GestureDetector(
                        onTap: () {



                        },
                        child: Container(

                          width: 300,
                          height: 60,
                          decoration: BoxDecoration(
                              color: primarycolor,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Center(
                            child: Text("View Products", style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: width / 22.84,
                            )),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 10),
                      child: GestureDetector(
                        onTap: () {



                        },
                        child: Container(

                          width: 300,
                          height: 60,
                          decoration: BoxDecoration(
                              color: primarycolor,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Center(
                            child: Text("Give your Grocery List", style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: width / 22.84,
                            )),
                          ),
                        ),
                      ),
                    ),

                  ],
                )
              ],
            );
          }

      ),
    );
  }
}
