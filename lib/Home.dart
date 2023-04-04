import 'package:doorsteps/offers.dart';
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
class HomePG extends StatefulWidget {
  const HomePG({Key? key}) : super(key: key);

  @override
  State<HomePG> createState() => _HomePGState();
}

class _HomePGState extends State<HomePG> {

  String name ="";
  String phone ="";
  String pincode ="";
  String address ="";
  double latitude =0.00;
  double longitude =0.00;
  getuser() async {
    var document = await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid.toString()).get();
    Map<String, dynamic>? value = document.data();
    setState(() {
      name=value!["name"];
      phone=value["phone"];
      pincode=value["pincode"];
      address=value["address"];
      latitude=double.parse(value["latitude"].toString());
      longitude=double.parse(value["longitude"].toString());
    });
  }
  @override
  void initState() {
    getuser();
    // TODO: implement initState
    super.initState();
  }

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
              padding: const EdgeInsets.only(top: 50.0,left: 20,right: 20,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text("Door Steps",style: GoogleFonts.rowdies(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: width/12.84,
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Row(
                          children: [
                            Text(pincode,style: GoogleFonts.poppins(
                              color: Colors.black45,
                              fontWeight: FontWeight.w600,
                              fontSize: width/22.84,
                            ),),
                            Icon(Icons.location_on, color: Colors.black45,)
                          ],
                        ),
                      ),

                    ],
                  ),
                  Container(
                      width: 120,
                      child: Image.asset(logoblack)),

                ],
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 8.0,right: 20,left: 20,bottom: 10),
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
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: BannerSlider()
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Exclusive Offer",style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: width/15.84,
                  ),),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=> Offers())
                      );
                    },
                    child: Text("Sell All",style: GoogleFonts.poppins(
                      color: primarycolor,
                      fontWeight: FontWeight.w700,
                      fontSize: width/20.84,
                    ),),
                  ),
                ],
              ),
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
                                    Column(

                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 15.0,right: 20,left: 20),
                                          child:  CachedNetworkImage(imageUrl: item["image"]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text(item["name"],style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: width/20.84,
                                          ),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text(item["quantity"],style: GoogleFonts.poppins(
                                            color: Colors.black45,
                                            fontWeight: FontWeight.w700,
                                            fontSize: width/22.84,
                                          ),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text("Rs ${item["price"].toString()}",style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: width/20.84,
                                          ),),
                                        ),
                                      ],
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Best Selling",style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: width/15.84,
                  ),),
                  Text("Sell All",style: GoogleFonts.poppins(
                    color: primarycolor,
                    fontWeight: FontWeight.w700,
                    fontSize: width/20.84,
                  ),),
                ],
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection("products").snapshots(),
                builder: (context,snapshot) {
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
                                      Column(

                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 15.0,right: 20,left: 20),
                                            child:  CachedNetworkImage(imageUrl: item["image"]),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Text(item["name"],style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: width/20.84,
                                            ),),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Text(item["quantity"],style: GoogleFonts.poppins(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.w700,
                                              fontSize: width/22.84,
                                            ),),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Text("Rs ${item["price"].toString()}",style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: width/20.84,
                                            ),),
                                          ),
                                        ],
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
                }
            )



          ],
        ),
      ),
    );
  }
}
