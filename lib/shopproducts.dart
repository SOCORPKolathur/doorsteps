import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorsteps/productpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ProductPage2.dart';
import 'const.dart';

class ShopProducts extends StatefulWidget {
  String vendername;
  String shopid;
  ShopProducts(this.vendername,this.shopid);
  @override
  State<ShopProducts> createState() => _ShopProductsState();
}

class _ShopProductsState extends State<ShopProducts> {
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

        Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Text(widget.vendername,style: GoogleFonts.poppins(
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
                  stream: FirebaseFirestore.instance.collection("Shops").doc(widget.shopid).collection("Products").snapshots(),
                  builder: (context,snapshot) {
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
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.size,

                        itemBuilder: (context,index){
                          var item= snapshot.data!.docs[index];
                          return  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context)=> ProductPage2(item.id,widget.shopid,widget.vendername))
                                );

                              },
                              child: Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: 150,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.grey

                                      )
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: ListTile(
                                      leading: Container(
                                          width: 100,
                                          height: 100,
                                          child: CachedNetworkImage(imageUrl: item["image"],)),
                                      title: Container(

                                        width: 200,
                                        height: 30,
                                        child: Text(item["name"],style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: width/20.84,
                                        ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      subtitle: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 70,
                                            height: 20,

                                            child: Text(item["quantity"],style: GoogleFonts.poppins(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.w700,
                                              fontSize: width/22.84,
                                            ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            width: 68,
                                            height: 30,

                                            child: Text("Rs. ${item["price"].toString()}",style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: width/20.84,
                                            ),
                                              overflow: TextOverflow.ellipsis,),
                                          ),
                                        ],
                                      ),
                                      trailing: Container(
                                        width: 40,
                                        height: 40,
                                        child: Center(
                                          child: Icon(Icons.add,color: Colors.white,),
                                        ),

                                        decoration: BoxDecoration(
                                            color: primarycolor,
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                      ),
                                    ),
                                  )
                                ),
                              ),
                            ),
                          );
                        });
                  }
              )

        ])),
    );
  }
}
