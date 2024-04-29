import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:random_string/random_string.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'Homepage.dart';
import 'const.dart';
import 'modules/home/controllers/home_controller.dart';

class CheckOut extends StatefulWidget {
  CheckOut(this.total,this.venderid);
  int total;
  String venderid;

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {

  @override
  void initState() {
    getuser();
    getdelivery();
    // TODO: implement initState
    super.initState();
  }
  getdelivery() async {

  }
  num plan = 0;
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
                fontSize: width/23.84,
                )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 90.0),
                      child: Text("Price",style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: width/23.84,
                      )),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text("Quantity",style: GoogleFonts.poppins(
                      color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: width/23.84,
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text("Amount",style: GoogleFonts.poppins(
    color: Colors.black,
    fontWeight: FontWeight.w600,
    fontSize: width/23.84,
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
                                      Text("${cart["name"]} - ${cart["productsqunatity"]}",style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: width/25.84,
                                      )),
                                      Text(cart["subtitle"],style: GoogleFonts.poppins(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w600,
                                        fontSize: width/29.84,
                                      ),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 175),
                                  child: Text(cart["orgprice"].toString(),style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: width/25.84,
                                  )),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 240.0),
                                  child: Text(cart["quantity"].toString(),style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: width/25.84,
                                  )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 300.0),
                                  child: Text("₹${cart["price"]}",style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: width/25.84,
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
                      child: Text("Subtotal",style: GoogleFonts.poppins(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text("Delivery Charges",style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: width/20.84,
                      )),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: Text("₹ ${deviverycharges.toString()}",style: GoogleFonts.poppins(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text("Total Amount to be paid",style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: width/20.84,
                      )),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: Text("₹ ${totalamount.toString()}",style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: width/20.84,
                      )),
                    )
                  ],
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
                  padding: const EdgeInsets.only(left: 10.0,top: 2),
                  child: Text("- Change Address -",style: GoogleFonts.poppins(
                    color: primarycolor,
                    fontWeight: FontWeight.w700,
                    fontSize: width/20.84,
                  )),
                ),
                Row(
                  children: <Widget>[
                    new Radio(
                      activeColor: primarycolor,
                      focusColor: primarycolor,

                      hoverColor: primarycolor,
                      value: 0,
                      groupValue: plan,

                      onChanged: (val) {
                        setState(() {
                          plan = 0;
                          print(plan);

                        });
                      },
                    ),
                    new Text(
                      'Pay Online',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: width/20.84,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    new Radio(
                      activeColor: primarycolor,
                      focusColor: primarycolor,
                      hoverColor: primarycolor,
                      value: 1,
                      groupValue: plan,
                      onChanged: (val) {
                        setState(() {
                          plan=1;

                        });
                      },
                    ),
                    new Text(
                      'Cash on Delivery',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: width/20.84,
                      ),
                    ),
                  ],
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
    //---------------------------------------------------Placing Order-------------
    var docu= await FirebaseFirestore.instance.collection("Users").doc(
        FirebaseAuth.instance.currentUser!.uid.toString()).collection("Cart").get();
    FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("Orders").doc(ram).set(
        {
          "timestamp": DateTime.now().microsecondsSinceEpoch,
          "time": "${DateTime.now().hour} : ${DateTime.now().minute}",
          "date": "${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",
          "subtotal":widget.total,
          "delivery":deviverycharges,
          "total":totalamount,
          "address":address,
          "name":name,
          "userID":FirebaseAuth.instance.currentUser!.uid.toString(),
          "phone":phone,
          "orderid":ram,
          "paymentmode":plan==0?"Online":"COD",
          "status":"ordered",
          "type":"products",
          "vender":docu.docs[0]["vender"],
          "products": docu.docs.length>=2?"${docu.docs[0]["name"]},${docu.docs[1]["name"]}":"${docu.docs[0]["name"]}...",
          "latitude":latitude,
          "longitude":longitude,
          "venderID":docu.docs[0]["venderID"],
        });

    FirebaseFirestore.instance.collection("Orders").doc(ram).set(
        {
          "timestamp": DateTime.now().microsecondsSinceEpoch,
          "time": "${DateTime.now().hour} : ${DateTime.now().minute}",
          "date": "${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",
          "subtotal":widget.total,
          "delivery":deviverycharges,
          "total":totalamount,
          "address":address,
          "name":name,
          "userID":FirebaseAuth.instance.currentUser!.uid.toString(),
          "phone":phone,
          "orderid":ram,
          "paymentmode":plan==0?"Online":"COD",
          "status":"ordered",
          "type":"products",
          "vender":docu.docs[0]["vender"],
          "products": docu.docs.length>=2?"${docu.docs[0]["name"]},${docu.docs[1]["name"]}":"${docu.docs[0]["name"]}...",
          "latitude":latitude,
          "longitude":longitude,
          "venderID":docu.docs[0]["venderID"],
        }
        );

    for(int i=0;i<docu.docs.length;i++) {
      FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("Orders").doc(ram).collection(ram).doc(i.toString()).set({
        "productid": docu.docs[i]["productid"],
        "quantity": docu.docs[i]["quantity"],
        "name": docu.docs[i]["name"],
        "price": docu.docs[i]["price"],
        "productsqunatity": docu.docs[i]["productsqunatity"],
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
        "productsqunatity": docu.docs[i]["productsqunatity"],
        "orgprice": docu.docs[i]["orgprice"],
        "timestamp": DateTime.now().microsecondsSinceEpoch,
        "time": "${DateTime.now().hour} : ${DateTime.now().minute}",
        "date": "${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",
      });
    }
    //---------------------------------------------------Updating Order to vender-------------
    FirebaseFirestore.instance.collection('Shops').doc(widget.venderid).update({
      "order":true,
      "orderID":ram,
    });
    FirebaseFirestore.instance.collection('Shops').doc(widget.venderid).collection("Orders").doc(ram).set({
      "timestamp": DateTime.now().microsecondsSinceEpoch,
      "time": "${DateTime.now().hour} : ${DateTime.now().minute}",
      "date": "${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",
      "subtotal":widget.total,
      "delivery":deviverycharges,
      "total":totalamount,
      "address":address,
      "name":name,
      "phone":phone,
      "orderid":ram,
      "paymentmode":plan==0?"Online":"COD",
      "userID":FirebaseAuth.instance.currentUser!.uid.toString(),
      "status":"ordered",
      "type":"products",
      "vender":docu.docs[0]["vender"],
      "venderID":docu.docs[0]["venderID"],
      "products": docu.docs.length>=2?"${docu.docs[0]["name"]},${docu.docs[1]["name"]}":"${docu.docs[0]["name"]}...",
      "latitude":latitude,
      "longitude":longitude,
    });
    homecontroller.findusers(ram,"order",vendortoken);
    homecontroller.findusers(ram,"myorder",token);
  }
  String name ="";
  String phone ="";
  String pincode ="";
  String address ="";
  String vendortoken ="";
  String token ="";
  double latitude =0.00;
  double longitude =0.00;
  double venderlatitude =0.00;
  double venderlongitude =0.00;
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
    var document2 = await FirebaseFirestore.instance.collection('Shops').doc(widget.venderid).get();
    Map<String, dynamic>? value2 = document2.data();
    setState(() {
      venderlatitude=double.parse(value2!["latitude"].toString());
      venderlongitude=double.parse(value2["longitude"].toString());
      vendortoken=value2["token"];
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
    setState(() {
      totalamount=deviverycharges+widget.total;
    });
  }
  int deviverycharges=0;
  int totalamount=0;
  final homecontroller = Get.put(HomeController());

}
