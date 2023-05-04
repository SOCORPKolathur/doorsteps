import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorsteps/const.dart';
import 'package:doorsteps/shopsdetails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class Shops extends StatefulWidget {
  const Shops({Key? key}) : super(key: key);

  @override
  State<Shops> createState() => _ShopsState();
}

class _ShopsState extends State<Shops> {
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text("Shops",style: GoogleFonts.poppins(
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
                        hintText: "Search Store",
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

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("Shops").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData==null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index) {
                    var val = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(

                          width: 320,
                          height: 125,
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: primarycolor,
                              )
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    width: 100,
                                    height: 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: CachedNetworkImage(

                                          imageUrl:  val["imgurl"],fit: BoxFit.cover,),
                                    )),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(val["name"],style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: width/15.84,
                                  )),
                                  Text(val["address"],style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: width/25.84,
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: IgnorePointer(
                                      child: Container(
                                        height: 20,
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: RatingBar(
                                            itemSize: 15,
                                            initialRating:4.0,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            ratingWidget: RatingWidget(
                                                full:Image.asset('assets/Star 1.png'),
                                                half:Image.asset('assets/Star 1.png') ,
                                                empty: Icon(Icons.star,color: Colors.transparent,)  ),
                                            itemPadding:  EdgeInsets.symmetric(horizontal: 4.0) ,
                                            onRatingUpdate:(rating) {
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context)=> ShopD(val.id)));
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: primarycolor,
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Center(child: Text("View",style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: width/23.84,
                                      ))),
                                    ),
                                  )

                                ],
                              )
                            ],

                          ),
                        ),
                      ),
                    );
                  }
                );
              }
            ),

            ],
        ),
      ),
    );
  }
}
