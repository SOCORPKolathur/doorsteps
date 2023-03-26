import 'package:doorsteps/const.dart';
import 'package:doorsteps/otppage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController Phoneno= new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Image.asset(signin),

            Padding(
              padding: const EdgeInsets.only(top: 100.0,left: 8,bottom: 8),
              child: Text("Get your groceries with \n Door Steps",style: GoogleFonts.poppins(
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
                    controller: Phoneno,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Enter Phone Number",
                      prefixIcon: Icon(Icons.phone),
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
            )

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primarycolor,
        onPressed: (){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=> Otp(Phoneno.text))
          );
        },
        child: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
