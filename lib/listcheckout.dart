import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorsteps/Homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:random_string/random_string.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'const.dart';
import 'modules/home/controllers/home_controller.dart';

class ListCheckout extends StatefulWidget {
 List items=[];
 String vendername;
 String vendrid;
 ListCheckout(this.items,this.vendername,this.vendrid);

  @override
  State<ListCheckout> createState() => _ListCheckoutState();
}

class _ListCheckoutState extends State<ListCheckout> {
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
      token=value["token"];
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
                      child: Text("",style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: width/20.84,
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text("",style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: width/20.84,
                      )),
                    )
                  ],
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,

                    itemCount: widget.items.length,

                    itemBuilder: (context,index){
                      return Row(
                        children: [
                          Container(
                            width:280,
                            child: Row(
                              children: [
                                Text(" ${(index+1).toString()}. ",style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: width/20.84,
                                )),
                                Flexible(
                                  child: Text(widget.items[index].toString(),style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: width/20.84,
                                  ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),


                          ),


                        ],
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [




                    Text("Total amount Will be \n Updated after order placed",style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: width/22.84,
                    ),textAlign: TextAlign.center,)
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
                  padding: const EdgeInsets.only(left: 10.0,top: 10,bottom: 120),
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
                        Text("Place Order", style: GoogleFonts.poppins(
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
                widget.items.clear();
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
  List pricelist =[];
  String ram="";
  int deviverycharges=0;
  double venderlatitude =0.00;
  double venderlongitude =0.00;
  String vendortoken ="";
  String token ="";
  placeorder() async {
    setState((){
      ram = randomAlphaNumeric(10);
    });


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
    var document2 = await FirebaseFirestore.instance.collection('Shops').doc(widget.vendrid).get();
    Map<String, dynamic>? value2 = document2.data();
    setState(() {
      vendortoken=value2!["token"];
      venderlatitude=double.parse(value2["latitude"].toString());
      venderlongitude=double.parse(value2["longitude"].toString());
    });
    print(venderlatitude);
    print(venderlongitude);
    print(latitude);
    print(longitude);
    var _distanceInMeters = await Geolocator.distanceBetween(
      venderlatitude,
      venderlongitude,
      latitude,
      longitude,
    );
    print("Kilometers");
    print((_distanceInMeters*0.001).round());
    if((_distanceInMeters*0.001).round()<=4){
      setState(() {
        deviverycharges=40;
      });

    }
    else{
      setState(() {
        deviverycharges=10*(_distanceInMeters*0.001).round();
      });
    }
    //----------------------------------------------
    FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("Orders").doc(ram).set(
        {
          "timestamp": DateTime.now().microsecondsSinceEpoch,
          "time": "${DateTime.now().hour} : ${DateTime.now().minute}",
          "date": "${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",
          "subtotal":0,
          "delivery":deviverycharges,
          "total":0,
          "address":address,
          "name":name,
          "userID":FirebaseAuth.instance.currentUser!.uid.toString(),
          "phone":phone,
          "orderid":ram,
          "paymentmode":"COD",
          "status":"ordered",
          "type":"typelist",
          "vender":widget.vendername,
          "venderID":widget.vendrid,
          "latitude":latitude,
          "longitude":longitude,
          "products": "You have given List Items",
        });
    FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("Orders").doc(ram).collection(ram).doc("0").set({
      "productslist": widget.items,
      "pricelist": pricelist,
      "timestamp": DateTime.now().microsecondsSinceEpoch,
      "time": "${DateTime.now().hour} : ${DateTime.now().minute}",
      "date": "${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",
    });
    FirebaseFirestore.instance.collection("Orders").doc(ram).set(
        {
          "timestamp": DateTime.now().microsecondsSinceEpoch,
          "time": "${DateTime.now().hour} : ${DateTime.now().minute}",
          "date": "${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",
          "subtotal":0,
          "delivery":deviverycharges,
          "total":0,
          "address":address,
          "name":name,
          "userID":FirebaseAuth.instance.currentUser!.uid.toString(),
          "phone":phone,
          "orderid":ram,
          "paymentmode":"COD",
          "status":"ordered",
          "type":"typelist",
          "vender":widget.vendername,
          "products": "You have given List Items",
          "latitude":latitude,
          "longitude":longitude,
          "venderID":widget.vendrid,
        }
    );
    FirebaseFirestore.instance..collection("Orders").doc(ram).collection(ram).doc("0").set({
      "productslist": widget.items,
      "pricelist": pricelist,
      "timestamp": DateTime.now().microsecondsSinceEpoch,
      "time": "${DateTime.now().hour} : ${DateTime.now().minute}",
      "date": "${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",
    });
    FirebaseFirestore.instance.collection('Shops').doc(widget.vendrid).update({
      "order":true,
      "orderID":ram,
    });
    FirebaseFirestore.instance.collection('Shops').doc(widget.vendrid).collection("Orders").doc(ram).set({
      "timestamp": DateTime.now().microsecondsSinceEpoch,
      "time": "${DateTime.now().hour} : ${DateTime.now().minute}",
      "date": "${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",
      "subtotal":0,
      "delivery":deviverycharges,
      "total":0,
      "address":address,
      "name":name,
      "phone":phone,
      "orderid":ram,
      "paymentmode":"COD",
      "userID":FirebaseAuth.instance.currentUser!.uid.toString(),
      "status":"ordered",
      "type":"typelist",
      "vender":widget.vendername,
      "venderID":widget.vendrid,
      "products": "You have given List Items",
      "latitude":latitude,
      "longitude":longitude,
    });
    homecontroller.findusers(ram,"order",vendortoken);
    homecontroller.findusers(ram,"myorder",token);
  }

  final homecontroller = Get.put(HomeController());
}
