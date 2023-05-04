import 'package:doorsteps/checkout.dart';
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
import 'package:lottie/lottie.dart';
import 'package:random_string/random_string.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    getCartTotal();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body:  Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text("Cart",style: GoogleFonts.poppins(
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
                      if(snapshot.data!.docs.length<=0){
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 80.0),
                              child: Text("Your Cart is Empty",style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: width/15.84,
                              )),
                            ),
                            Container(
                                height:400,
                                child: SvgPicture.asset("assets/emptycart.svg")),
                          ],
                        );

                      }


                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context,index){
                            var cart= snapshot.data!.docs[index];
                            return Column(
                              children: [
                                ListTile(
                                  leading: CachedNetworkImage(imageUrl:cart["imgurl"]),
                                  title: Text(cart["name"],style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: width/20.84,
                                  ),),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(cart["subtitle"],style: GoogleFonts.poppins(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w600,
                                        fontSize: width/25.84,
                                      ),),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0,left: 10),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                if(cart["quantity"]>1) {
                                                  FirebaseFirestore.instance
                                                      .collection("Users").doc(
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid
                                                          .toString()).collection(
                                                      "Cart").doc(cart.id).update({
                                                    "quantity": cart["quantity"] - 1,
                                                    "price":(cart["quantity"]-1)*cart["orgprice"]


                                                  });
                                                  getCartTotal();
                                                }
                                              },
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                child: Center(
                                                  child: Icon(Icons.remove,color: Colors.black45,),
                                                ),

                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 40,
                                              height: 40,
                                              child: Center(
                                                child: Text(cart["quantity"].toString(),style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: width/22.84,
                                                ),),
                                              ),

                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black45),
                                                  borderRadius: BorderRadius.circular(15)
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("Cart").doc(cart.id).update({
                                                  "quantity":cart["quantity"]+1,
                                                  "price":(cart["quantity"]+1)*cart["orgprice"]
                                                });
                                                getCartTotal();
                                              },
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                child: Center(
                                                  child: Icon(Icons.add,color: primarycolor,),
                                                ),

                                                decoration: BoxDecoration(

                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left: 10.0),
                                              child: Text("₹${cart["price"]}",style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                                fontSize: width/22.84,
                                              ),),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: GestureDetector(
                                      onTap: (){
                                        FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("Cart").doc(cart.id).delete();

                                      },
                                      child: Icon(Icons.cancel_outlined)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Divider(),
                                ),
                              ],
                            );
                          });
                    }
                ),






              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 650),
            child: GestureDetector(
              onTap: () {
               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckOut(total)));
              },
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
                      Text("Proceed to Check Out", style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: width / 22.84,
                      )),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text("₹ ${total.toString()}", style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: width / 22.84,
                        )),
                      ),
                      Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,)

                    ]
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
  int total=0;
  Future<String> getCartTotal() async {
    setState((){
      total =0;
    });
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("Cart")
        .get();

    snapshot.docs.forEach((doc) {
      setState((){

        total += int.parse(doc['price'].toString());
      });
    });
    return total.toString();
  }


}
