import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorsteps/Homepage.dart';
import 'package:doorsteps/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:random_string/random_string.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class TakePhoto extends StatefulWidget {
  String vendername;
  TakePhoto(this.vendername);

  @override
  State<TakePhoto> createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  File? _pickedFile;
  File? _pickedFile2;
  File? _pickedFile3;
  File? _pickedFile4;
  File? _pickedFile5;

  croppimage()async{
    if(_pickedFile==null) {
      ImagePicker _picker = ImagePicker();
      await _picker.pickImage(source: ImageSource.camera).then((xFile) {
        if (xFile != null) {
          setState(() {
            _pickedFile = File(xFile.path);
          });
        }
      });

    }
   else if(_pickedFile2==null) {
      ImagePicker _picker = ImagePicker();
      await _picker.pickImage(source: ImageSource.camera).then((xFile) {
        if (xFile != null) {
          setState(() {
            _pickedFile2 = File(xFile.path);
          });
        }
      });
    }
   else if(_pickedFile3==null) {
      ImagePicker _picker = ImagePicker();
      await _picker.pickImage(source: ImageSource.camera).then((xFile) {
        if (xFile != null) {
          setState(() {
            _pickedFile3 = File(xFile.path);
          });
        }
      });
    }
   else if(_pickedFile4==null) {
      ImagePicker _picker = ImagePicker();
      await _picker.pickImage(source: ImageSource.camera).then((xFile) {
        if (xFile != null) {
          setState(() {
            _pickedFile4 = File(xFile.path);
          });
        }
      });
    }
  else  if(_pickedFile5==null) {
      ImagePicker _picker = ImagePicker();
      await _picker.pickImage(source: ImageSource.camera).then((xFile) {
        if (xFile != null) {
          setState(() {
            _pickedFile5 = File(xFile.path);
          });
        }
      });
    }

  }
  String ram1="";
  Future uploadImagenew2() async {
    setState((){
      ram1 = randomAlphaNumeric(10);
    });
    int status = 1;
    if(_pickedFile!=null) {
      var ref = FirebaseStorage.instance.ref().child('ListImages').child(
          "${_pickedFile!.path}.jpg");

      var uploadTask2 = await ref.putFile(_pickedFile!).catchError((
          error) async {
        status = 0;
      });


      if (status == 1) {
        imageurl1 = await uploadTask2.ref.getDownloadURL();


        print(imageurl1);
      }
    }
    if(_pickedFile2!=null) {
      var ref = FirebaseStorage.instance.ref().child('ListImages').child(
          "${_pickedFile2!.path}.jpg");

      var uploadTask2 = await ref.putFile(_pickedFile2!).catchError((
          error) async {
        status = 0;
      });


      if (status == 1) {
        imageurl2 = await uploadTask2.ref.getDownloadURL();


        print(imageurl2);
      }
    }
    if(_pickedFile3!=null) {
      var ref = FirebaseStorage.instance.ref().child('ListImages').child(
          "${_pickedFile3!.path}.jpg");

      var uploadTask2 = await ref.putFile(_pickedFile3!).catchError((
          error) async {
        status = 0;
      });


      if (status == 1) {
        imageurl3 = await uploadTask2.ref.getDownloadURL();


        print(imageurl3);
      }
    }
    if(_pickedFile4!=null) {
      var ref = FirebaseStorage.instance.ref().child('ListImages').child(
          "${_pickedFile4!.path}.jpg");

      var uploadTask2 = await ref.putFile(_pickedFile4!).catchError((
          error) async {
        status = 0;
      });


      if (status == 1) {
        imageurl4 = await uploadTask2.ref.getDownloadURL();


        print(imageurl4);
      }
    }
    if(_pickedFile5!=null) {
      var ref = FirebaseStorage.instance.ref().child('ListImages').child(
          "${_pickedFile5!.path}.jpg");

      var uploadTask2 = await ref.putFile(_pickedFile5!).catchError((
          error) async {
        status = 0;
      });


      if (status == 1) {

        imageurl5 = await uploadTask2.ref.getDownloadURL();


        print(imageurl5);
      }
    }
    placeorder();
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
                  child: Text("Take Photo of your List",style: GoogleFonts.poppins(
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

                GestureDetector(
                  onTap: (){
                    croppimage();
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: primarycolor,
                      borderRadius: BorderRadius.circular(80)
                    ),
                    child: Center(
                      child: Icon(Icons.camera_alt_rounded,size: 80,color: Colors.white,),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      _pickedFile!=null? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 110,
                          height: 110,
                          child: Image.file(
                            _pickedFile!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ): SizedBox(),
                      _pickedFile2!=null? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 110,
                          height: 110,
                          child: Image.file(
                            _pickedFile2!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ): SizedBox(),
                      _pickedFile3!=null? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 110,
                          height: 110,
                          child: Image.file(
                            _pickedFile3!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ): SizedBox(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      _pickedFile4!=null? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 110,
                          height: 110,
                          child: Image.file(
                            _pickedFile4!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ): SizedBox(),
                      _pickedFile5!=null? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 110,
                          height: 110,
                          child: Image.file(
                            _pickedFile5!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ): SizedBox(),

                    ],
                  ),
                ),
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
                  padding: const EdgeInsets.only(top: 10.0),
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
                uploadImagenew2();
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
  
  String imageurl1="";
  String imageurl2="";
  String imageurl3="";
  String imageurl4="";
  String imageurl5="";
  @override
  void initState() {
    getuser();
    // TODO: implement initState
    super.initState();
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
    var docu= await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("Cart").get();
    FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("Orders").doc(ram).set(
        {
          "timestamp": DateTime.now().microsecondsSinceEpoch,
          "time": "${DateTime.now().hour} : ${DateTime.now().minute}",
          "date": "${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",
          "total":"Will Update You Soon..",
          "address":address,
          "name":name,
          "phone":phone,
          "orderid":ram,
          "status":"ordered",
          "type":"typephoto",
          "vender":widget.vendername,
          "products": "You have given List Items",
        });
    FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("Orders").doc(ram).collection(ram).doc("0").set({
      "productsimageurl1": imageurl1,
      "productsimageurl2": imageurl2,
      "productsimageurl3": imageurl3,
      "productsimageurl4": imageurl4,
      "productsimageurl5": imageurl5,
      "timestamp": DateTime.now().microsecondsSinceEpoch,
      "time": "${DateTime.now().hour} : ${DateTime.now().minute}",
      "date": "${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",
    });
  }
}
