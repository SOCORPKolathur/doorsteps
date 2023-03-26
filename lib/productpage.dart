import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorsteps/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductPage extends StatefulWidget {
  String ProductID;
  ProductPage(this.ProductID);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int quanity = 1;
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection('products').doc(widget.ProductID).get(),
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

            Map<String, dynamic>? item = snapshot.data!.data();
            return Stack(
              children: [

                ClipRRect(borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20),),
                    child: Image.asset(productback)),
                Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0, left: 80),
                child: Container(
                    width: 200,
                    height: 200,

                    child: CachedNetworkImage(imageUrl: item!["image"],fit: BoxFit.contain,)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 20),
                child: Text(item["name"], style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: width / 18.84,
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20),
                child: Text(item["quantity"], style: GoogleFonts.poppins(
                  color: Colors.black45,
                  fontWeight: FontWeight.w700,
                  fontSize: width / 22.84,
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (quanity > 1) {
                            quanity = quanity - 1;
                          }
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: Icon(Icons.remove, color: Colors.black45,),
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
                        child: Text(
                          quanity.toString(), style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: width / 22.84,
                        ),),
                      ),

                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black45),
                          borderRadius: BorderRadius.circular(15)
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          quanity = quanity + 1;
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: Icon(Icons.add, color: primarycolor,),
                        ),

                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(15)
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 130.0),
                      child: Text("₹ ${quanity*item["price"]}", style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: width / 18.84,
                      ),),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  thickness: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20),
                child: Text("Product Description", style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: width / 18.84,
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20),
                child: Text(item["descirpition"],
                  style: GoogleFonts.poppins(
                    color: Colors.black45,
                    fontWeight: FontWeight.w600,
                    fontSize: width / 25.84,
                  ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 80),
                child: GestureDetector(
                  onTap: () {
                    cart(item["name"],item["quantity"],item["price"],item["image"]);


                  },
                  child: Container(

                    width: 300,
                    height: 60,
                    decoration: BoxDecoration(
                        color: primarycolor,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(
                      child: Text("Add to Basket", style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: width / 22.84,
                      )),
                    ),
                  ),
                ),
              )

            ],
          )
        ],
      );
    }

      ),
    );
  }
  cart(name,subtitle,price,img){
    FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("Cart").doc().set({
      "productid":widget.ProductID,
      "quantity":quanity,
      "name":name,
      "subtitle":subtitle,
      "price":quanity*price,
      "orgprice":price,
      "imgurl": img,
      "timestamp": DateTime.now().microsecondsSinceEpoch
    });
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product Added to Cart')));
  }
}
