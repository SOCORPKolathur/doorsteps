import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorsteps/const.dart';
import 'package:doorsteps/productpage.dart';
import 'package:doorsteps/slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid.toString()).get(),
          builder: (BuildContext context,  snapshot) {
            if (snapshot.hasData == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            Map<String, dynamic>? user = snapshot.data!.data();
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [


                  Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: ListTile(
                      leading: Image.asset(profile),
                      title: Text(user!["name"],style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: width/20.84,
                      ),),
                      subtitle:  Text("+91 ${user["phone"]}",style: GoogleFonts.poppins(
                        color: Colors.black45,
                        fontWeight: FontWeight.w600,
                        fontSize: width/25.84,
                      ),),
                      trailing: Icon(Icons.edit,color: primarycolor,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ListTile(
                      leading: Icon(Icons.shopping_bag_outlined,color: Colors.black,),
                      title: Text("My Orders",style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: width/20.84,
                      ),),

                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right:8.0),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.person_outline_rounded,color: Colors.black,),
                    title: Text("My Details",style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: width/20.84,
                    ),),

                    trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right:8.0),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on,color: Colors.black,),
                    title: Text("Delivery Address",style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: width/20.84,
                    ),),

                    trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right:8.0),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.help_outline_rounded,color: Colors.black,),
                    title: Text("Help",style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: width/20.84,
                    ),),

                    trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right:8.0),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.error_outline_rounded,color: Colors.black,),
                    title: Text("About",style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: width/20.84,
                    ),),

                    trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right:8.0),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),





                ],
              ),
            );
          }
      ),
    );
  }
}
