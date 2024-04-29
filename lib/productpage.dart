import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorsteps/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductPage extends StatefulWidget {
  String ProductID;
  String Type;
  ProductPage(this.ProductID,this.Type);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int quanity = 1;
  num _parentChip = 0;

  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection(widget.Type).doc(widget.ProductID).get(),
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
                SingleChildScrollView(
                  child: Column(
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
                        child: Text(_parentChip ==0?"₹ ${quanity*item["price"]}":_parentChip ==1?"₹ ${quanity*item["price2"]}":_parentChip ==2?"₹ ${quanity*item["price3"]}":_parentChip ==3?"₹ ${quanity*item["price4"]}":"₹ ${quanity*item["price5"]}", style: GoogleFonts.poppins(
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
                  padding: const EdgeInsets.only(top: 10.0, left: 20,bottom: 10),
                  child: Text("Select type", style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: width / 18.84,
                  ),),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      item["price"]!=""? Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
                        child: Material(
                          elevation: 7,
                          shadowColor: _parentChip ==0? primarycolor : Theme.of(context).shadowColor,
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            height: 90,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:_parentChip ==0? Border.all(color: primarycolor): Border.all(color: Colors.white)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(item["qty1"],style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: width / 23.84,
                                ),),

                                ChoiceChip(
                                    label: Text(" ₹ ${item["price"]} ",style: TextStyle(color:_parentChip==0? Colors.white: Colors.black),),
                                    selected: _parentChip ==0,
                                    onSelected: (bool selected) {

                                      setState(() {
                                        _parentChip = 0;
                                      });
                                    },
                                    selectedColor: primarycolor,
                                    shape: StadiumBorder(
                                        side: BorderSide(
                                            color: primarycolor)),
                                    backgroundColor: Colors.white,
                                    labelStyle: TextStyle(color: Colors.black),
                                    elevation: 1.5),
                              ],
                            ),
                          ),
                        ),
                      ): Container(),
                      item["price2"]!=""?  Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
                        child: Material(
                          elevation: 7,
                          shadowColor: _parentChip ==1? primarycolor : Theme.of(context).shadowColor,
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            height: 90,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                                border:_parentChip ==1? Border.all(color: primarycolor): Border.all(color: Colors.white)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(item["qty2"],style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: width / 23.84,
                                ),),
                                ChoiceChip(
                                    label: Text(" ₹ ${item["price2"]} ",style: TextStyle(color:_parentChip==1? Colors.white: Colors.black),),

                                    selected: _parentChip ==1,
                                    onSelected: (bool selected) {

                                      setState(() {
                                        _parentChip = 1;
                                      });
                                    },
                                    selectedColor: primarycolor,
                                    shape: StadiumBorder(
                                        side: BorderSide(
                                            color: primarycolor)),
                                    backgroundColor: Colors.white,
                                    labelStyle: TextStyle(color: Colors.black),
                                    elevation: 1.5),
                              ],
                            ),
                          ),
                        ),
                      ) : Container(),
                      item["price3"]!=""?  Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
                        child: Material(
                          elevation: 7,
                          borderRadius: BorderRadius.circular(12),
                          shadowColor: _parentChip ==2? primarycolor : Theme.of(context).shadowColor,
                          child: Container(
                            height: 90,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                                border:_parentChip ==2? Border.all(color: primarycolor): Border.all(color: Colors.white)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(item["qty3"],style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: width / 23.84,
                                ),),
                                ChoiceChip(

                                    label: Text(" ₹ ${item["price3"]} ",style: TextStyle(color:_parentChip==2? Colors.white: Colors.black),),

                                    selected: _parentChip ==2,
                                    onSelected: (bool selected) {

                                      setState(() {
                                        _parentChip = 2;
                                      });
                                    },
                                    selectedColor: primarycolor,
                                    shape: StadiumBorder(
                                        side: BorderSide(
                                            color: primarycolor)),
                                    backgroundColor: Colors.white,
                                    labelStyle: TextStyle(color: Colors.black),

                                    elevation: 1.5),
                              ],
                            ),
                          ),
                        ),
                      ) : Container(),
                      item["price4"]!=""?  Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
                        child: Material(
                          elevation: 7,
                          borderRadius: BorderRadius.circular(12),
                          shadowColor: _parentChip ==3? primarycolor : Theme.of(context).shadowColor,
                          child: Container(
                            height: 90,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                                border:_parentChip ==3? Border.all(color: primarycolor): Border.all(color: Colors.white)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(item["qty4"],style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: width / 23.84,
                                ),),
                                ChoiceChip(

                                    label: Text(" ₹ ${item["price4"]} ",style: TextStyle(color:_parentChip==3? Colors.white: Colors.black),),

                                    selected: _parentChip ==3,
                                    onSelected: (bool selected) {

                                      setState(() {
                                        _parentChip = 3;
                                      });
                                    },
                                    selectedColor: primarycolor,
                                    shape: StadiumBorder(
                                        side: BorderSide(
                                            color: primarycolor)),
                                    backgroundColor: Colors.white,
                                    labelStyle: TextStyle(color: Colors.black),

                                    elevation: 1.5),
                              ],
                            ),
                          ),
                        ),
                      ) : Container(),
                      item["price5"]!=""?  Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
                        child: Material(
                          elevation: 7,
                          borderRadius: BorderRadius.circular(12),
                          shadowColor: _parentChip ==4? primarycolor : Theme.of(context).shadowColor,
                          child: Container(
                            height: 90,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                                border:_parentChip ==4? Border.all(color: primarycolor): Border.all(color: Colors.white)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(item["qty5"],style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: width / 23.84,
                                ),),
                                ChoiceChip(

                                    label: Text(" ₹ ${item["price5"]} ",style: TextStyle(color:_parentChip==4? Colors.white: Colors.black),),

                                    selected: _parentChip ==4,
                                    onSelected: (bool selected) {

                                      setState(() {
                                        _parentChip = 4;
                                      });
                                    },
                                    selectedColor: primarycolor,
                                    shape: StadiumBorder(
                                        side: BorderSide(
                                            color: primarycolor)),
                                    backgroundColor: Colors.white,
                                    labelStyle: TextStyle(color: Colors.black),

                                    elevation: 1.5),
                              ],
                            ),
                          ),
                        ),
                      ) : Container(),

                    ],
                ),
              ),

              SizedBox(
                  width: width / 78.4,
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
                  padding: const EdgeInsets.only(left: 30.0, top: 50,bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      checkvender(item["name"],item["quantity"],

                          _parentChip==0?item["price"] :
                          _parentChip==1?item["price2"] :
                          _parentChip==2?item["price3"] :
                          _parentChip==3?item["price4"] :
                          item["price5"] ,

                          item["image"],item["vender"],item["vendorID"],

                          _parentChip==0?item["qty1"] :
                          _parentChip==1?item["qty2"] :
                          _parentChip==2?item["qty3"] :
                          _parentChip==3?item["qty4"] :
                         item["qty5"]



                      );
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
          ),
                )
        ],
      );
    }

      ),
    );
  }

  checkvender(name,subtitle,price,img,vender,venderid,productsqunatity) async {
    var docu= await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("Cart").get();
    var docu2= await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("Cart").where("vender",isEqualTo: vender).get();
    if(docu.docs.length>0){
      if(docu2.docs.length>0){
        cart(name,subtitle,price,img,vender,venderid,productsqunatity);
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Sorry your trying to choose multiple vendors")));
      }
    }
    else{
      cart(name,subtitle,price,img,vender,venderid,productsqunatity);
    }
  }

  cart(name,subtitle,price,img,vender,venderid,productsqunatity){
    FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("Cart").doc().set({
      "productid":widget.ProductID,
      "quantity":quanity,
      "name":name,
      "subtitle":subtitle,
      "price":quanity*price,
      "productsqunatity":productsqunatity,
      "orgprice":price,
      "imgurl": img,
      "vender":vender,
      "venderID":venderid,
      "timestamp": DateTime.now().microsecondsSinceEpoch
    });
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product Added to Cart')));
  }
}
