import 'package:android_intent_plus/android_intent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorsteps/const.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MyDeatils extends StatefulWidget {



  @override
  State<MyDeatils> createState() => _MyDeatilsState();
}

class _MyDeatilsState extends State<MyDeatils> {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController field1 = TextEditingController();
  TextEditingController field2 = TextEditingController();
  TextEditingController field3 = TextEditingController();
  bool isloading =false;
  @override
  void initState() {
    getdata();
    // TODO: implement initState
    super.initState();
  }
  String name="";
  String phone="";

  @override
  getdata() async {
    var document = await FirebaseFirestore.instance.collection('Users').doc(auth.currentUser!.uid).get();
    Map<String, dynamic>? value = document.data();

    setState(() {
      field1.text = value!['name'].toString();
      field2.text = value['phone'].toString();
      field3.text = value['address'].toString();
      name = value['name'].toString();
      phone = value['phone'].toString();
    });
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> show()  async  {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Profile Updated'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Container(
                    width: 150,
                    height: 150,
                    child: Lottie.asset('assets/done.json',repeat: false)),

              ],
            ),
          ),
          actions: <Widget>[

            TextButton(
              child: const Text('OK', style: TextStyle(color: primarycolor),),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );
  }

  Future uploadFile() async {
    await _firestore
        .collection('Users').doc(auth.currentUser!.uid)
        .update({
      'name':field1.text,
      'phone':field2.text,
      'address':field3.text,

    });
  }

  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primarycolor,
        title:  Row(

          children: [
            Padding(
              padding: EdgeInsets.only(left: width/49),
              child:
              Container(
                child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child:const Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,)
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top:height/151.8,left:width/39.2,bottom:height/151.8),
              child: Container(

                height:height/25,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text("Edit Profile",
                    style: GoogleFonts.poppins(color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),),
                ),
              ),
            ),


          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(top:height/151.8,left:width/39.2,bottom:height/151.8),
            child: TextButton(
              onPressed: (){
                uploadFile();
                show();
              },
              child: Container(
                height: height/33,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text("Done",
                    style: GoogleFonts.poppins(color:Colors.white,
                      fontWeight: FontWeight.w600,
                    ),),
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    width: width/1.96,
                    height:height/4.21,
                    child: Lottie.asset('assets/profile.json')),

                Container(
                  height:height/23,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(name,style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff484545)
                    ),),
                  ),
                ),

                Container(
                  height:height/32,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text('+91 ${phone}',
                      style: GoogleFonts.poppins(
                        color: const Color(0xff484545),
                        fontSize: 15,),),
                  ),
                ),

                Container(
                  width:width/0.98,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xffF9F9F9),
                          Color(0xffffffff),
                        ],)),


                ),

                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding:EdgeInsets.symmetric(horizontal:width/14,vertical:height/94.87),
                        child:
                        TextField(
                          controller: field1,
                          cursorColor:  primarycolor,

                          decoration: InputDecoration(

                              suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.person)),
                              hintText: '',
                              labelText: "Name"


                          ),
                        ),
                      ),


                      GestureDetector(

                        child: Padding(
                          padding:EdgeInsets.symmetric(horizontal:width/14,vertical:height/94.87),
                          child: TextField(
                            onTap:   (){
                        _getCurrentPosition();
                        isloading=true;
                        print("sdfsd");
                        },
                            controller: field3,
                            cursorColor:  primarycolor,

                            decoration: InputDecoration(

                                suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.location_on)),
                                hintText: '',
                                labelText: "Address"


                            ),
                          ),
                        ),
                      ),


                      Padding(
                        padding:EdgeInsets.symmetric(horizontal:width/14,vertical:height/94.87),
                        child: IgnorePointer(
                          child: TextField(
                            controller: field2,
                            cursorColor:  primarycolor,

                            decoration: InputDecoration(

                                suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.phone)),
                                hintText: '',
                                labelText: "Phone"


                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:EdgeInsets.only(top:height/5),
                  child:  Container(
                      height:height/33,
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text('Door Steps',style: TextStyle(
                              color: Colors.black38
                          ),))),
                )
              ],
            ),
          ),
          isloading==true? Container(
            height: 80,
            child: Column(
              children: [
                CircularProgressIndicator(),
                Text("Getting your Current Location")
              ],
            ),
          ):SizedBox()
        ],
      ),
    );



  }
  String _currentAddress="";
  String _currentpincode="";
  Position? _currentPosition;
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
      _getAddressFromLatLng(_currentPosition!);
      print(_currentPosition);
    }).catchError((e) {
      debugPrint(e);
    });

  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea},';
        _currentpincode = '${place.postalCode}';
        setState(() {
          print(_currentAddress);
          field3.text="${_currentAddress},${_currentpincode}";
          isloading=false;

        });
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
  location(){
    String origin="${_currentPosition!.latitude},${_currentPosition!.longitude}";  // lat,long like 123.34,68.56
    String destination="${_currentPosition!.latitude},${_currentPosition!.longitude}";

    final AndroidIntent intent = new AndroidIntent(
        action: 'action_view',
        data: Uri.encodeFull(
            "https://www.google.com/maps/dir/?api=1&origin=" +
                origin + "&destination=" + destination + "&travelmode=driving&dir_action=navigate"),
        package: 'com.google.android.apps.maps');
    intent.launch();
  }


}