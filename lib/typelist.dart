import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorsteps/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:random_string/random_string.dart';

import 'Homepage.dart';
import 'listcheckout.dart';

class TypeList extends StatefulWidget {
  String vendername;
  TypeList(this.vendername);

  @override
  State<TypeList> createState() => _TypeListState();
}

class _TypeListState extends State<TypeList> {
List items=[];
TextEditingController listcon= new TextEditingController();

  @override
  Widget build(BuildContext context) {

    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: GestureDetector(
              onTap: (){
                setState(() {
                  items.clear();
                });
              },
              child: Container(
                child: Center(
                  child: Text("Clear List", style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: width / 23.84,
                  )),
                ),

                width: 140,
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(8)
                ),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: GestureDetector(
              onTap: (){
               Navigator.of(context).push(
                 MaterialPageRoute(builder: (context)=> ListCheckout(items,widget.vendername))
               );
              },
              child: Shimmer(
                enabled: true,
                color: Colors.white,
                child: Container(
                  child: Center(
                    child: Text("Order Now", style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: width / 23.84,
                    )),
                  ),

                  width: 140,
                  height: 45,
                  decoration: BoxDecoration(
                      color: primarycolor,
                      borderRadius: BorderRadius.circular(8)
                  ),),
              ),
            ),
          ),
        ],
      ),
      body: Stack(

        children: [
          items.isEmpty==false? Padding(
            padding: const EdgeInsets.only(top: 48.0,bottom: 65),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
              Text("Type your List Items",style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: width/15.84,
              )),
                  Divider( color: Colors.black,),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,

                      itemCount: items.length,

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
                                    child: Text(items[index].toString(),style: GoogleFonts.poppins(
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
                            GestureDetector(
                              onTap:(){
                          setState(() {
                            items.removeAt(index);
                          });
                        },
                                child: Icon(Icons.delete))

                          ],
                        );
                      }),
                ],
              ),
            ),
          ) :  Padding(
            padding: const EdgeInsets.only(bottom: 65.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Container(child: Lottie.asset('assets/typelist.json',)),
                ),
                Text("Type your Gocery List...",style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: width/15.84,
                )),
              ],
            ),
          ),







        ],
      ),
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.only(left: 8,top: 20,bottom: 10),
          child: Container(

            height: 67,
            width: 350,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color(0xff53B175).withOpacity(0.30)
            ),
            child: Container(
                height: 67,
                width: 350,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color(0xff53B175).withOpacity(0.30)
                ),
                child: Row(


                    children: <Widget>[

                      Flexible(
                        child:  Padding(
                          padding:  EdgeInsets.only(top: 8,right: 8,left: 8,bottom: 8),
                          child: TextField(
                            controller: listcon,
                            decoration: const InputDecoration.collapsed(
                                hintText: "Ex: Apple - 20 Kgs"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 50,
                          height: 50,


                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: primarycolor,
                          ),


                          child: Center(
                            child: IconButton(
                              icon: Icon(Icons.add,color: Colors.white,),
                              onPressed: (){
                                setState(() {
                                  items.add(listcon.text);
                                  listcon.clear();
                                });


                              },
                            ),
                          ),
                        ),
                      )
                    ])),
          ),
        ),
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
@override
  void initState() {
  getuser();
    // TODO: implement initState
    super.initState();
  }
}
