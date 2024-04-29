import 'package:doorsteps/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorsteps/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:lottie/lottie.dart';

import '../Homepage.dart';
import '../demomap.dart';
import '../directionmaps.dart';
import '../keys.dart';
class Delivery2 extends StatefulWidget {
  const Delivery2({Key? key}) : super(key: key);

  @override
  State<Delivery2> createState() => _Delivery2State();
}

class _Delivery2State extends State<Delivery2> {
  String pickup= "";
  double pickuplag= 0;
  double pickuplog= 0;
  String drop= "";
  double droplag= 0;
  double droplog= 0;
  String name ="";
  String phone ="";
  TextEditingController task= new TextEditingController();
  int check=0;
  int totalamount=0;
  num plan = 0;

  getuser() async {
    var document = await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid.toString()).get();
    Map<String, dynamic>? value = document.data();
    setState(() {
      name=value!["name"];
      phone=value["phone"];
    });
  }
  String ram="";
  bool bikeonline=false;
  fuctiondemo(){
    final userwallet =
    FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid.toString());
    userwallet.snapshots().listen(
          (event)  {
        Map<String, dynamic>? value = event.data();
        setState(() {
          bikeonline=value!["biketaxi"];
        });
        if(bikeonline==true){
          getstatus();
        }

      },
      onError: (error) => print("Listen failed: $error"),
    );

  }
  String status="";
  getstatus() async {
    final userwallet = FirebaseFirestore.instance.collection("BikeTaxi").doc(ram);
    userwallet.snapshots().listen(
            (event)  {
          Map<String, dynamic>? value = event.data();
          setState(() {
            status= value!["status"];
          });
        });
  }
  caltotal() async {
    var _distanceInMeters = await Geolocator.distanceBetween(
      pickuplag,
      pickuplog,
      droplag,
      droplog,
    );
    print("Kilometers");
    print((_distanceInMeters*0.001).round());
    if((_distanceInMeters*0.001).round()<=4){
      setState(() {
        totalamount=40;
      });

    }
    else{
      setState(() {
        totalamount=10*(_distanceInMeters*0.001).round();
      });
    }
  }
  placeorder() async {
    setState((){
      ram = randomAlphaNumeric(10);
    });
    getstatus();
    //---------------------------------------------------Placing Order-------------
    var devilery = await FirebaseFirestore.instance.collection('DeliveryMan').where("online",isEqualTo: true).get();
    for(int i=0;i<devilery.docs.length;i++){
      FirebaseFirestore.instance.collection('DeliveryMan').doc(devilery.docs[i].id).update({
        "order":true,
        "orderID":ram,
        "ordertype":"biketaxi"
      });
    }
    FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid.toString()).update({
      "biketaxi":true,

    });
    FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("BikeTaxi").doc(ram).set(
        {
          "timestamp": DateTime.now().microsecondsSinceEpoch,
          "time": "${DateTime.now().hour} : ${DateTime.now().minute}",
          "date": "${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",
          "total": totalamount,
          "fromaddress":pickup,
          "toaddress":drop,
          "fromlatitude":pickuplag,
          "fromlongitude":pickuplog,
          "tolatitude":droplag,
          "tolongitude":droplog,
          "name":name,
          "userID":FirebaseAuth.instance.currentUser!.uid.toString(),
          "phone":phone,
          "orderid":ram,
          "paymentmode":plan==0?"Online":"COD",
          "type":"delivery",
          "status":"ordered",
          "delivery":task.text,

        });

    FirebaseFirestore.instance.collection("BikeTaxi").doc(ram).set(
        {
          "timestamp": DateTime.now().microsecondsSinceEpoch,
          "time": "${DateTime.now().hour} : ${DateTime.now().minute}",
          "date": "${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",
          "total": totalamount,
          "fromaddress":pickup,
          "toaddress":drop,
          "fromlatitude":pickuplag,
          "fromlongitude":pickuplog,
          "tolatitude":droplag,
          "tolongitude":droplog,
          "name":name,
          "userID":FirebaseAuth.instance.currentUser!.uid.toString(),
          "phone":phone,
          "orderid":ram,
          "paymentmode":plan==0?"Online":"COD",
          "type":"delivery",
          "status":"ordered",
          "delivery":task.text,
          "deliveryman": "",
          "devieryID": "",
          "devierymanphone": "",
          "devierymanimage": "",
          "bikeno": ""
        }
    );
  }
  completed(){
    FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid.toString()).update({
      "biketaxi":false,
    });
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context)=> LandingPage2()),(Route<dynamic> route) => false);
  }

  @override
  void initState() {
    fuctiondemo();
    getuser();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: (){
            print(FirebaseAuth.instance.currentUser!.uid.toString());
          },
            
            child: Text(check==3 ? status=="delivered"? "Ride Completed": status=="ordered"? "Waiting for person": "Ride Started":"Setup your task")),
      ),
      body:bikeonline==false?
      check==0? SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    check=1;
                  });
                  print("sdpofkspdkfopskdfskd");
                },
                child: Material(
                  elevation: 5,
          borderRadius: BorderRadius.circular(5),
                  child: pickup==""? Container(
                    width: 345,
                    height: 60,

                    decoration: BoxDecoration(
                      border: Border.all(color: primarycolor),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(

                        children: [
                          Icon(Icons.location_on),
                          Text("Choose pickup address",style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                          ),

                          ),
                          SizedBox(width: 60,),

                          Icon(Icons.add_circle,color: primarycolor,),

                        ],
                      ),
                    ),
                  ): Container(
                    width: 345,


                    decoration: BoxDecoration(
                        border: Border.all(color: primarycolor),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pick Up at",style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                          ),),
                          SizedBox(height: 10,),
                          Text(pickup,style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                          ),),
                        ],
                      )
                    ),
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    check=2;
                  });
                  print("sdpofkspdkfopskdfskd");
                },
                child: Material(
                  elevation: 5,
          borderRadius: BorderRadius.circular(5),
                  child:drop==""? Container(
                    width: 345,
                    height: 60,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(

                        children: [
                          Icon(Icons.location_on),
                          Text("Choose drop address",style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                          ),

                          ),
                          SizedBox(width: 60,),

                          Icon(Icons.add_circle,color: primarycolor,),

                        ],
                      ),
                    ),
                  ): Container(
                    width: 345,


                    decoration: BoxDecoration(
                        border: Border.all(color: primarycolor),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Drop at",style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black
                            ),),
                            SizedBox(height: 10,),
                            Text(drop,style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                            ),),
                          ],
                        )
                    ),
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 5,
          borderRadius: BorderRadius.circular(5),
                child: Container(
                  width: 345,
                  height: 60,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.task_rounded),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  Container(
                          width: 290,
                          child: TextField(
                            controller: task,

                            decoration: InputDecoration(
                              border: InputBorder.none,

                                hintText: "Add task details",

                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              ),
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
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                color: Colors.black,
              ),
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

            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      placeorder();
                      setState(() {
                        check=3;

                      });
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
                              Text("Proceed", style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: width / 18.84,
                              )),


                            ]
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ) :
      check==1 ? PlacePicker(
        resizeToAvoidBottomInset:
        false, // only works in page mode, less flickery
        apiKey: APIKeys.androidApiKey,
        hintText: "Find a place ...",
        searchingText: "Please wait ...",
        selectText: "Select pickup Location",
        outsideOfPickAreaText: "Place not in area",
        initialPosition: DemoMap.kInitialPosition,
        useCurrentLocation: true,
        selectInitialPosition: true,
        usePinPointingSearch: true,
        usePlaceDetailSearch: true,
        automaticallyImplyAppBarLeading: false,
        hidePlaceDetailsWhenDraggingPin: true,
        selectedPlaceWidgetBuilder: (context, selectedPlac, state, isSearchBarFocused) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: primarycolor,
                width: double.infinity,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.location_on,color: Colors.white,),
                          ),
                          Text("Pickup Location",style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: width/15.84,
                          ),),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(17)
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Address: ${selectedPlac!.formattedAddress.toString()}",style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: width/25.84,
                          ),),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              pickup=selectedPlac.formattedAddress.toString();
                              pickuplag=selectedPlac.geometry!.location.lat;
                              pickuplog=selectedPlac.geometry!.location.lng;

                              check=0;
                            });
                          },
                          child: Shimmer(
                            enabled: true,
                            color: Colors.white,
                            child: Container(

                              width: 300,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children:[
                                    Text("Proceed", style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: width / 18.84,
                                    )),


                                  ]
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ],
          );


        },

        onMapCreated: (GoogleMapController controller) {
          print("Map created");
        },
        onPlacePicked: (PickResult result) {
          print("Place picked: ${result.formattedAddress}");

          setState(() {

          });

        },
        onMapTypeChanged: (MapType mapType) {
          print(
              "Map type changed to ${mapType.toString()}");
        },


      ):
      check==2? PlacePicker(
        resizeToAvoidBottomInset:
        false, // only works in page mode, less flickery
        apiKey: APIKeys.androidApiKey,
        hintText: "Find a place ...",
        searchingText: "Please wait ...",
        selectText: "Select drop Location",
        outsideOfPickAreaText: "Place not in area",
        initialPosition: DemoMap.kInitialPosition,
        useCurrentLocation: true,
        selectInitialPosition: true,
        usePinPointingSearch: true,
        usePlaceDetailSearch: true,
        automaticallyImplyAppBarLeading: false,
        hidePlaceDetailsWhenDraggingPin: true,
        selectedPlaceWidgetBuilder: (context, selectedPlac, state, isSearchBarFocused) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: primarycolor,
                width: double.infinity,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.location_on,color: Colors.white,),
                          ),
                          Text("Drop Location",style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: width/15.84,
                          ),),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(17)
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Address: ${selectedPlac!.formattedAddress.toString()}",style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: width/25.84,
                          ),),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              drop=selectedPlac.formattedAddress.toString();
                              droplag=selectedPlac.geometry!.location.lat;
                              droplog=selectedPlac.geometry!.location.lng;

                              check=0;
                              caltotal();
                            });
                          },
                          child: Shimmer(
                            enabled: true,
                            color: Colors.white,
                            child: Container(

                              width: 300,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children:[
                                    Text("Proceed", style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: width / 18.84,
                                    )),


                                  ]
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ],
          );


        },

        onMapCreated: (GoogleMapController controller) {
          print("Map created");
        },
        onPlacePicked: (PickResult result) {
          print("Place picked: ${result.formattedAddress}");

          setState(() {

          });

        },
        onMapTypeChanged: (MapType mapType) {
          print(
              "Map type changed to ${mapType.toString()}");
        },


      ) :  Directiononmap(pickuplag,pickuplog,droplag,droplog) : status=="ordered"?  Directiononmap(pickuplag,pickuplog,droplag,droplog) :
      status=="delivered"? Container(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Text("Your Ride is completed", style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: width / 15.84,
            )),
            Lottie.asset("assets/done.json",repeat: false),
            GestureDetector(
              onTap: (){
                completed();
              },
              child: Container(

                width: 300,
                height: 60,
                decoration: BoxDecoration(
                    color: primarycolor,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Text("Okay", style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: width / 18.84,
                      )),


                    ]
                ),
              ),
            ),
          ],
        ),
      ):
      Directiononmap2(pickuplag,pickuplog,droplag,droplog,ram)
    );
  }
}
