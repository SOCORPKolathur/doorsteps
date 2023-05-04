import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const.dart';
import '../productpage.dart';
import '../shopsdetails.dart';

class Fruits extends StatefulWidget {
  const Fruits({Key? key}) : super(key: key);

  @override
  State<Fruits> createState() => _FruitsState();
}

class _FruitsState extends State<Fruits> {
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Text("Fresh Fruits & Vegetables",style: GoogleFonts.poppins(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: width/15.84,
        )),
      ),
              Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            color: Colors.black,
          ),
        ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0,left: 10),
                    child: Text("Top Shops,",style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: width/15.84,
                    )),
                  ),
                ],
              ),
              ListView(
                shrinkWrap: true,
                children:[
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
                                            padding: const EdgeInsets.only(top: 4.0,bottom: 4),
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
                                              child: Center(child: Text("Shop now",style: GoogleFonts.poppins(
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0,left: 10),
                        child: Text("Fresh Fruits for you,",style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: width/15.84,
                        )),
                      ),
                    ],
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("products").snapshots(),
                    builder: (context,snapshot){
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
                      return Container(
                        height: 220,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.size,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,index){
                              var item= snapshot.data!.docs[index];
                              return  Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context)=> ProductPage(item.id))
                                    );

                                  },
                                  child: Material(
                                    elevation: 2,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      width: 150,
                                      height: 200,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                              color: Colors.grey

                                          )
                                      ),
                                      child: Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 10.0),
                                            child: Column(

                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 15.0,right: 0,left: 20),
                                                  child:  Container(
                                                      width: 100,
                                                      height: 100,


                                                      child: CachedNetworkImage(imageUrl: item["image"])),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0),
                                                  child: Container(

                                                    width: 200,
                                                    height: 30,
                                                    child: Text(item["name"],style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: width/20.84,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0),
                                                  child: Container(
                                                    width: 120,
                                                    height: 20,

                                                    child: Text(item["quantity"],style: GoogleFonts.poppins(
                                                      color: Colors.black45,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: width/22.84,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0),
                                                  child: Container(
                                                    width: 100,
                                                    height: 30,
                                                    child: Text("Rs. ${item["price"].toString()}",style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: width/20.84,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              child: Center(
                                                child: Icon(Icons.add,color: Colors.white,),
                                              ),

                                              decoration: BoxDecoration(
                                                  color: primarycolor,
                                                  borderRadius: BorderRadius.circular(15)
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    },
                  ),
    ]
              ),

            ]
        ),
      ),
    );
  }
}
