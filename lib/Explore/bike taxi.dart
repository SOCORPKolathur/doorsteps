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

class BikeTaxi extends StatefulWidget {
  const BikeTaxi({Key? key}) : super(key: key);

  @override
  State<BikeTaxi> createState() => _BikeTaxiState();
}

class _BikeTaxiState extends State<BikeTaxi> {
  Position? _currentPosition;

  int check=0;
  String pickup= "";
  double pickuplag= 0;
  double pickuplog= 0;
  String drop= "";
  double droplag= 0;
  double droplog= 0;
  String name ="";
  String phone ="";
  TextEditingController task= new TextEditingController();
  int totalamount=0;
  num plan = 0;
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.checkPermission();
      permission = await Geolocator.requestPermission();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }
  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      print(_currentPosition);
    }).catchError((e) {
      debugPrint(e);
    });

  }

  getuser() async {
    var document = await FirebaseFirestore.instance.collection('Users').doc(
        FirebaseAuth.instance.currentUser!.uid.toString()).get();
    Map<String, dynamic>? value = document.data();
    setState(() {
      name = value!["name"];
      phone = value["phone"];
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
          "type":"biketaxi",
          "status":"ordered",
          "delivery":"",

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
          "type":"",
          "status":"ordered",
          "delivery":"",
          "deliveryman": "biketaxi",
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
    _getCurrentPosition();
    getuser();
    // TODO: implement initState
    super.initState();
  }
  double userlatitude =0.00;
  double userlongitude =0.00;
  double venderlatitude =0.00;
  double venderlongitude =0.00;


  int deviverycharges=0;

  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: check==0? Text("Select your pick up location") :  check==1 ?Text("Select your Drop location"): Text("Book your Taxi"),
      ),
      body: bikeonline==false?
      check==0? _currentPosition != null ? PlacePicker(
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
                              selectedPlace=selectedPlac;
                              pickup=selectedPlac.formattedAddress.toString();
                              pickuplag=selectedPlac.geometry!.location.lat;
                              pickuplog=selectedPlac.geometry!.location.lng;
                              check=1;
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
            selectedPlace = result;
            userlatitude=selectedPlace!.geometry!.location.lat;
            userlongitude=selectedPlace!.geometry!.location.lng;
          });
          print("Place picked: ${selectedPlace!.geometry!.location.lat.toString()}");
          print("Place picked: ${selectedPlace!.geometry!.location.lng.toString()}");
        },
        onMapTypeChanged: (MapType mapType) {
          print(
              "Map type changed to ${mapType.toString()}");
        },


      ): Container() :
      check==1? PlacePicker(
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
        selectedPlaceWidgetBuilder: (context, selectedPlace, state, isSearchBarFocused) {
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

                          Text("Where you want to go ?",style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: width/15.84,
                          ),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.location_on,color: Colors.white,),
                          ),
                          Text("Enter Drop Location",style: GoogleFonts.poppins(
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
                          child: Text("Address: ${selectedPlace!.formattedAddress.toString()}",style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: width/25.84,
                          ),),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){

                              setState(() {
                                selectedPlace2=selectedPlace;
                                drop=selectedPlace.formattedAddress.toString();
                                droplag=selectedPlace.geometry!.location.lat;
                                droplog=selectedPlace.geometry!.location.lng;
                              });
                              print(venderlatitude);
                              print(venderlongitude);
                              print(userlatitude);
                              print(userlongitude);
                              print("Place picked: ${selectedPlace.geometry!.location.lat.toString()}");
                              print("Place picked: ${selectedPlace.geometry!.location.lng.toString()}");
                              var _distanceInMeters =  Geolocator.distanceBetween(
                                pickuplag,
                                pickuplog,
                                droplag,
                                droplog,
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
                                totalamount=deviverycharges;
                                check=2;
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
                                      Text("View Cost", style: GoogleFonts.poppins(
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

        onPlacePicked: (PickResult result)  {
          print("Place picked: ${result.formattedAddress}");

          setState(() {
            selectedPlace2 = result;
            venderlatitude=selectedPlace2!.geometry!.location.lat;
            venderlongitude=selectedPlace2!.geometry!.location.lng;
          });
          print("Place picked: ${selectedPlace2!.geometry!.location.lat.toString()}");
          print("Place picked: ${selectedPlace2!.geometry!.location.lng.toString()}");

        },
        onMapTypeChanged: (MapType mapType) {
          print(
              "Map type changed to ${mapType.toString()}");
        },

      )
          : check==2? PlacePicker(
        resizeToAvoidBottomInset: false, // only works in page mode, less flickery
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

                          Text("Book Now",style: GoogleFonts.poppins(
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
                          child: Text("From Address: ${selectedPlace!.formattedAddress.toString()}",style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: width/25.84,
                          ),),
                        ),
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
                          child: Text("To Address: ${selectedPlace2!.formattedAddress.toString()}",style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: width/25.84,
                          ),),
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
                          child: Text("Total Amount",style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: width/20.84,
                          )),
                        ),


                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Text("₹ ${totalamount.toString()}",style: GoogleFonts.poppins(
                            color: Colors.white,
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
                          activeColor: Colors.white,
                          focusColor: Colors.white,

                          hoverColor: Colors.white,
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
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: width/20.84,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        new Radio(
                          activeColor: Colors.white,
                          focusColor: Colors.white,
                          hoverColor: Colors.white,
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
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: width/20.84,
                          ),
                        ),
                      ],
                    ),
                    Row(
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
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children:[
                                    Text("Book Now", style: GoogleFonts.poppins(
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

        onPlacePicked: (PickResult result)  {
          print("Place picked: ${result.formattedAddress}");

          setState(() {
            selectedPlace2 = result;
            venderlatitude=selectedPlace2!.geometry!.location.lat;
            venderlongitude=selectedPlace2!.geometry!.location.lng;
          });
          print("Place picked: ${selectedPlace2!.geometry!.location.lat.toString()}");
          print("Place picked: ${selectedPlace2!.geometry!.location.lng.toString()}");
          var _distanceInMeters =  Geolocator.distanceBetween(
            userlatitude,
            userlongitude,
            venderlatitude,
            venderlongitude,
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
            totalamount=deviverycharges;
          });
        },
        onMapTypeChanged: (MapType mapType) {
          print(
              "Map type changed to ${mapType.toString()}");
        },

      ) :
      Directiononmap(userlatitude,userlongitude,venderlatitude,venderlongitude) : status=="ordered"?  Directiononmap(pickuplag,pickuplog,droplag,droplog) :
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
  PickResult? selectedPlace;
  PickResult? selectedPlace2;
}

/*
const kGoogleApiKey = "AIzaSyD9hrDkiUduFDPULJHat4MPtTKAu3WzVGk";
class demo extends StatefulWidget {
  @override
  demoState createState() => new demoState();
}

class demoState extends State<demo> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                // show input autocomplete with selected mode
                // then get the Prediction selected
                Prediction? p = await PlacesAutocomplete.show(
                    context: context, apiKey: kGoogleApiKey);
                displayPrediction(p!);
              },
              child: Text('Find address'),

            )
        )
    );
  }
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId!);


      var placeId = p.placeId;
      double lat = detail.result.geometry!.location.lat;
      double lng = detail.result.geometry!.location.lng;


      print(lat);
      print(lng);
    }
  }
}

 */




