import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:random_string/random_string.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'Homepage.dart';
import 'const.dart';

class CheckOut extends StatefulWidget {
  CheckOut(this.total);
  int total;

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {

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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text("Check out",style: GoogleFonts.poppins(
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
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text("Product",style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: width/20.84,
                )),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 120.0),
                      child: Text("Quantity",style: GoogleFonts.poppins(
                      color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: width/20.84,
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text("Price",style: GoogleFonts.poppins(
    color: Colors.black,
    fontWeight: FontWeight.w600,
    fontSize: width/20.84,
    )),
                    )
                  ],
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("Cart").orderBy("timestamp",descending: true).snapshots(),
                    builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
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
                          itemBuilder: (context,index){
                            var cart= snapshot.data!.docs[index];
                            return     Stack(

                              children: [

                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(cart["name"],style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: width/20.84,
                                      )),
                                      Text(cart["subtitle"],style: GoogleFonts.poppins(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w600,
                                        fontSize: width/25.84,
                                      ),),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 225.0),
                                  child: Text(cart["quantity"].toString(),style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: width/20.84,
                                  )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 290.0),
                                  child: Text("₹${cart["price"]}",style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: width/20.84,
                                  )),
                                )
                              ],
                            );


                          });
                    }
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text("Total amount",style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: width/20.84,
                      )),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: Text("₹ ${widget.total.toString()}",style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: width/20.84,
                      )),
                    )
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, color: Colors.black,),
                      Padding(
                        padding: EdgeInsets.only(left: 4.0),
                        child: Text("Deliver To :",style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: width/20.84,
                        )),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text("${name},",style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: width/20.84,
                      )),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text("+91 ${phone},",style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: width/20.84,
                      )),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Container(
                        width: 300,
                        child: Text("${address} \n${pincode}",style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: width/20.84,
                        )),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,top: 10),
                  child: Text("- Change Address -",style: GoogleFonts.poppins(
                    color: primarycolor,
                    fontWeight: FontWeight.w700,
                    fontSize: width/20.84,
                  )),
                ),




              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 700,left: 30),
            child: GestureDetector(
              onTap: () {
                _showMyDialog();
                placeorder();
              },
              child: Shimmer(
                enabled: true,
                color: Colors.white,
                child: Container(

                  width: 300,
                  height: 60,
                  decoration: BoxDecoration(
                      color: primarycolor,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:[
                        Text("Proceed to Pay", style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: width / 18.84,
                        )),


                      ]
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text("Order Placed, will deliver you soon...",style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
            textAlign: TextAlign.center,

          ),
          content: Lottie.asset('assets/orderplaced.json',),
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,
          titlePadding: EdgeInsets.all(8),
          actions: [
            GestureDetector(
              onTap: () async {
                var docu= await FirebaseFirestore.instance.collection("Users").doc(
                    FirebaseAuth.instance.currentUser!.uid.toString()).collection("Cart").get();
                for(int i=0;i<docu.docs.length;i++) {
                  FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("Cart").doc(docu.docs[i].id).delete();
                }
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context)=> LandingPage2()),(Route<dynamic> route) => false);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  width: 200,
                  height: 30,
                  decoration: BoxDecoration(
                    color: primarycolor,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(child:  Text("Continue Shopping",style: GoogleFonts.poppins(
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
  String ram="";
  placeorder() async {
    setState((){
      ram = randomAlphaNumeric(10);
    });
    var docu= await FirebaseFirestore.instance.collection("Users").doc(
        FirebaseAuth.instance.currentUser!.uid.toString()).collection("Cart").get();
    FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("Orders").doc(ram).set(
        {
          "timestamp": DateTime.now().microsecondsSinceEpoch,
          "time": "${DateTime.now().hour} : ${DateTime.now().minute}",
          "date": "${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",
          "total":widget.total,
          "address":address,
          "name":name,
          "phone":phone,
          "orderid":ram,
          "status":"ordered",
          "type":"products",
          "vender":docu.docs[0]["vender"],
          "products": docu.docs.length>=2?"${docu.docs[0]["name"]},${docu.docs[1]["name"]}":"${docu.docs[0]["name"]}...",
        });

    FirebaseFirestore.instance.collection("Orders").doc(ram).set(
        {
          "timestamp": DateTime.now().microsecondsSinceEpoch,
          "time": "${DateTime.now().hour} : ${DateTime.now().minute}",
          "date": "${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",
          "total":widget.total,
          "address":address,
          "name":name,
          "phone":phone,
          "orderid":ram,
          "status":"ordered",
          "type":"products",
          "vender":docu.docs[0]["vender"],
          "products": docu.docs.length>=2?"${docu.docs[0]["name"]},${docu.docs[1]["name"]}":"${docu.docs[0]["name"]}...",
          "latitude":latitude,
          "longitude":longitude,
        });

    for(int i=0;i<docu.docs.length;i++) {
      FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("Orders").doc(ram).collection(ram).doc(i.toString()).set({
        "productid": docu.docs[i]["productid"],
        "quantity": docu.docs[i]["quantity"],
        "name": docu.docs[i]["name"],
        "price": docu.docs[i]["price"],
        "orgprice": docu.docs[i]["orgprice"],
        "timestamp": DateTime.now().microsecondsSinceEpoch,
        "time": "${DateTime.now().hour} : ${DateTime.now().minute}",
        "date": "${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",
      });
      FirebaseFirestore.instance.collection("Orders").doc(ram).collection(ram).doc(i.toString()).set({
        "productid": docu.docs[i]["productid"],
        "quantity": docu.docs[i]["quantity"],
        "name": docu.docs[i]["name"],
        "price": docu.docs[i]["price"],
        "orgprice": docu.docs[i]["orgprice"],
        "timestamp": DateTime.now().microsecondsSinceEpoch,
        "time": "${DateTime.now().hour} : ${DateTime.now().minute}",
        "date": "${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",
      });
    }

  }
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


}
