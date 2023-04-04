import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorsteps/Locationpage.dart';
import 'package:doorsteps/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:location/location.dart';
class Otp extends StatefulWidget {
  String phonenumer;
  Otp(this.phonenumer);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController otp= new TextEditingController();
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    _verifyphone();
    gettoken();
  }
  String?Token;
  gettoken()async{
    setState(()async{
      Token= await FirebaseMessaging.instance.getToken();
    });

  }
  var _verificationCode;

  _verifyphone()async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91${widget.phonenumer}" ,
        verificationCompleted:(PhoneAuthCredential credential)async{
          await FirebaseAuth.instance.signInWithCredential(credential).then((value)async{
            if(value.user!=null){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=> LocationPage(widget.phonenumer,ison)));
              print("Valied Otp");
            }
          });
        },
        verificationFailed:(FirebaseAuthException e){
          print(e.message);

          print("Vaerification failed");
        } ,
        codeSent:(String ?verificationid ,int ?resendtoken ){
          setState(() {
            _verificationCode=verificationid;
          });
        },
        codeAutoRetrievalTimeout:( String verificationid){
          setState(() {
            _verificationCode=verificationid;
          });
        },timeout: Duration(seconds: 120) );


  }
  Location location = new Location();
  bool ison = false;
  check() async {

      ison = await location.serviceEnabled();

    if (!ison) { //if defvice is off
      bool isturnedon = await location.requestService();
      if (isturnedon) {
        print("GPS device is turned ON");
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please turn ON location')));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(otpback),

          Padding(
            padding:  EdgeInsets.only(top: 100.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Enter the 6 - Digit OTP",style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: width/15.84,
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: 350,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color(0xffB0D6BE),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(
                        child: TextField(
                          controller: otp,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: "OTP",
                            prefixIcon: Icon(Icons.password),
                            labelText: "Code",
                            labelStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: width/26.84,
                            ),
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
                          onEditingComplete: () {
                            print(otp.text);
                            try{
                              FirebaseAuth.instance.signInWithCredential(
                                  PhoneAuthProvider.credential(
                                      verificationId:_verificationCode ,
                                      smsCode: otp.text)).then((value){
                                if(value.user!=null){
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (context)=> LocationPage(widget.phonenumer,ison)),(Route<dynamic> route) => false);
                                }
                                print("Register otp page");
                              });
                            }
                            catch(e){
                              print(e);
                              print('this errrrrorrrrrrrrrrrrrrrrrrrrrrrrrrrr');
                            }
                          },
                        )
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20.0,top: 10),
                  child: Text("Resend Code",style: GoogleFonts.poppins(
                    color: primarycolor,
                    fontWeight: FontWeight.w700,
                    fontSize: width/20.84,
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,top: 10),
                  child: Text("Want to change phone number ?..",style: GoogleFonts.poppins(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w700,
                    fontSize: width/22.84,
                  )),
                ),
              ],
            ),
          )

        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primarycolor,
        onPressed: (){
          try{
            FirebaseAuth.instance.signInWithCredential(
                PhoneAuthProvider.credential(
                    verificationId:_verificationCode ,
                    smsCode: otp.text)).then((value){
              if(value.user!=null){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=> LocationPage(widget.phonenumer,ison)));
              }
              print("Register otp page");
            });
          }
          catch(e){
            print(e);
            print('this errrrrorrrrrrrrrrrrrrrrrrrrrrrrrrrr');
          }
        },
        child: Icon(Icons.arrow_forward_ios),
      ),


    );
  }
}
