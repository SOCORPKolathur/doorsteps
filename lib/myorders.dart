import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'const.dart';
import 'orderdetails.dart';

class Myorders extends StatefulWidget {
  const Myorders({Key? key}) : super(key: key);

  @override
  State<Myorders> createState() => _MyordersState();
}

class _MyordersState extends State<Myorders> {
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
                child: Text("My Orders",style: GoogleFonts.poppins(
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

              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("Orders").orderBy("timestamp",descending: true).snapshots(),
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
                      physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context,index) {
                          var val = snapshot.data!.docs[index];
                          return  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              elevation: 2.0,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(

                                width: 350,
                                height: 210,
                                decoration: BoxDecoration(
                                  color: primarycolor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                            Container(
                                              width:30,height: 30,
                                                child: Lottie.asset("assets/live.json",fit: BoxFit.fill)),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5.0),
                                                child: Text("Order ID : ${val["orderid"]}",style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: width/18.84,
                                                )),
                                              ),
                                            ],
                                          ),
                                          Text("To: ${val["name"]}",style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: width/25.84,
                                          )),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 2.0,bottom: 8.0),
                                            child: Text("${val["address"]}"),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8.0,),
                                            child: Text("Shop Name: ${val["vender"]}",style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: width/25.84,
                                            )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 2),
                                            child: Text("Items: ${val["products"]}"),
                                          ),
                                          Text(val["total"]=="products"?"Total: Rs.${val["total"]}":"Total: ${val["total"]}",style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: width/18.84,
                                          )),
                                          Row(

                                            children: [
                                              GestureDetector(
                                                onTap: (){
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(builder: (context)=>OrderDetails(val.id,val["type"],val["total"].toString(),val["name"],val["address"],val["phone"]))
                                                  );
                                                  print("${val["type"]}${val["total"].toString()}${val["name"]}${val["address"]}${val["phone"]}");

                                                },
                                                child: Padding(
                                                  padding:  EdgeInsets.only(top: 8.0),
                                                  child: Container(
                                                    width: 150,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: primarycolor,
                                                      borderRadius: BorderRadius.circular(7),
                                                    ),
                                                    child: Center(child: Text("View Order",style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: width/23.84,
                                                    ))),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: (){
                                                  _showMyDialog(val["status"]);

                                                },
                                                child: Padding(
                                                  padding:  EdgeInsets.only(top: 8.0,left: 18),
                                                  child: Container(
                                                    width: 150,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: primarycolor,
                                                      borderRadius: BorderRadius.circular(7),
                                                    ),
                                                    child: Center(child: Text("Track Order",style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: width/23.84,
                                                    ))),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )

                                        ],
                                      )
                                    ],

                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                    );
                  }
              ),





            ])),
    );
  }
  Future<void> _showMyDialog(status) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text("Track Your Order",style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
            textAlign: TextAlign.center,

          ),
          content: Container(
            height: 300,
            child: Column(
              children: [
                status=="ordered"? Lottie.asset('assets/odertracking.json',):Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    height: 200,

                      child: Lottie.asset('assets/orderpickeed.json',fit: BoxFit.cover)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Column(
                      children: [
                        status=="ordered"?  Container(
                            width:30,height: 30,
                            child: Lottie.asset("assets/live.json",fit: BoxFit.fill)):
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(12)
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text("Order Placed",style: GoogleFonts.poppins(
                            fontSize: 10

                          ),),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Column(
                      children: [
                        status=="picked"? Container(
                            width:30,height: 30,
                            child: Lottie.asset("assets/live.json",fit: BoxFit.fill)):   Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12)
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text("Picked",style: GoogleFonts.poppins(
                              fontSize: 10

                          ),),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.grey,

                    ),
                    Column(
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12)
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text("Delivered",style: GoogleFonts.poppins(
                              fontSize: 10

                          ),),
                        )
                      ],
                    ),


                  ],
                )
              ],
            ),
          ),
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,
          titlePadding: EdgeInsets.all(8),
          actionsPadding: EdgeInsets.symmetric(horizontal: 40),
          actions: [
           status=="ordered"? GestureDetector(
              onTap: () async {

              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  width: 160,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(child:  Text("Cancel Order",style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ))),
                ),
              ),
            ): GestureDetector(
             onTap: () async {

             },
             child: Padding(
               padding: const EdgeInsets.only(bottom: 8.0),
               child: Container(
                 width: 250,
                 height: 30,
                 decoration: BoxDecoration(
                   color: primarycolor,
                   borderRadius: BorderRadius.circular(7),
                 ),
                 child: Center(child:  Text("Call Delivery Person",style: GoogleFonts.poppins(
                   color: Colors.white,
                   fontWeight: FontWeight.w600,
                   fontSize: 15,
                 ))),
               ),
             ),
           )
          ],


        );
      },
    );
  }
}
