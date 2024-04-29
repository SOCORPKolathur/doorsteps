import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetails extends StatefulWidget {
  String doid;
  String type;
  String total;
  String name;
  String address;

  String phone;
  OrderDetails(this.doid,this.type,this.total,this.name,this.address,this.phone);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: widget.type=="products"  ?
      SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Text("Order Details",style: GoogleFonts.poppins(
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
              Row(

                children: [

                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Product",style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: width/23.84,
                    )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 90.0),
                    child: Text("Price",style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: width/23.84,
                    )),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text("Quantity",style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: width/23.84,
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text("Amount",style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: width/23.84,
                    )),
                  )
                ],
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("Orders").doc(widget.doid).collection(widget.doid).snapshots(),
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


                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context,index){
                          var cart= snapshot.data!.docs[index];
                          return      Stack(

                            children: [

                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${cart["name"]} - ${cart["productsqunatity"]}",style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: width/25.84,
                                    )),

                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 175),
                                child: Text(cart["orgprice"].toString(),style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: width/25.84,
                                )),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 240.0),
                                child: Text(cart["quantity"].toString(),style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: width/25.84,
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 300.0),
                                child: Text("₹${cart["price"]}",style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: width/25.84,
                                )),
                              )
                            ],
                          );


                        });
                  }
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
                    child: Text("Total amount",style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: width/20.84,
                    )),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: Text("₹ ${widget.total.toString()}",style: GoogleFonts.poppins(
                      color: Colors.black,
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
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
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
                    child: Text("${widget.name},",style: GoogleFonts.poppins(
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
                    child: Text("+91 ${widget.phone},",style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: width/20.84,
                    )),
                  ),
                ],
              ),

            ]
        )
      ) : widget.type=="typelist"?
      SingleChildScrollView(child:
      Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text("Order Details",style: GoogleFonts.poppins(
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
                Row(

                  children: [

                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text("Si.No",style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: width/20.84,
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text("Products",style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: width/20.84,
                      )),
                    ),


                  ],
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("Orders").doc(widget.doid).collection(widget.doid).snapshots(),
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


                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context,index){
                            var cart= snapshot.data!.docs[index];
                            return ListView.builder(
                              shrinkWrap: true,
                                itemCount: cart["productslist"].length,
                                itemBuilder: (context,index){
                                  return Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0),
                                        child: Text("${(index+1).toString()}.",style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: width / 18.84,
                                        ),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 30.0),
                                        child: Text(cart["productslist"][index],style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: width / 18.84,
                                        ),),
                                      ),
                                    ],
                                  );
                            });


                          });
                    }
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




                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: Row(
                        children: [
                          Text(widget.total==0?"":"Total",style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: width/20.84,
                          )),
                          Text(widget.total==0?"Your total wil be updated soon":"${widget.total.toString()}",style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: width/20.84,
                          )),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
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
                      child: Text("${widget.name},",style: GoogleFonts.poppins(
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
                      child: Text("+91 ${widget.phone},",style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: width/20.84,
                      )),
                    ),
                  ],
                ),

              ]
          )) :
      SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text("Order Details",style: GoogleFonts.poppins(
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
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text("Products List Images",style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: width/20.84,
                      )),
                    ),


                  ],
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("Orders").doc(widget.doid).collection(widget.doid).snapshots(),
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


                      return  Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                snapshot.data!.docs[0]["productsimageurl1"]!=""? Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    width: 110,
                                    height: 110,
                                    child: Image.network(
                                      snapshot.data!.docs[0]["productsimageurl1"],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ): SizedBox(),
                                snapshot.data!.docs[0]["productsimageurl2"]!=""? Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    width: 110,
                                    height: 110,
                                    child: Image.network(
                                      snapshot.data!.docs[0]["productsimageurl2"]!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ): SizedBox(),
                                snapshot.data!.docs[0]["productsimageurl3"]!=""? Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    width: 110,
                                    height: 110,
                                    child: Image.network(
                                      snapshot.data!.docs[0]["productsimageurl3"],
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
                                snapshot.data!.docs[0]["productsimageurl4"]!=""? Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    width: 110,
                                    height: 110,
                                    child: Image.network(
                                      snapshot.data!.docs[0]["productsimageurl4"],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ): SizedBox(),
                                snapshot.data!.docs[0]["productsimageurl5"]!=""? Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    width: 110,
                                    height: 110,
                                    child: Image.network(
                                      snapshot.data!.docs[0]["productsimageurl5"]!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ): SizedBox(),

                              ],
                            ),
                          ),
                        ],
                      );
                    }
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




                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: Text("${widget.total.toString()}",style: GoogleFonts.poppins(
                        color: Colors.black,
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
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
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
                      child: Text("${widget.name},",style: GoogleFonts.poppins(
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
                      child: Text("+91 ${widget.phone},",style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: width/20.84,
                      )),
                    ),
                  ],
                ),

              ]
          )
      )
    );
  }
}
