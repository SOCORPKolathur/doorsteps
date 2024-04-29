import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorsteps/productpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'const.dart';

class Offers extends StatefulWidget {
  const Offers({Key? key}) : super(key: key);

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
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
              padding: const EdgeInsets.only(top: 50.0,left: 10),
              child: Text("Exclusive Offer",style: GoogleFonts.poppins(
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
              stream: FirebaseFirestore.instance.collection("Exclusive offers").snapshots(),
              builder: (context,snapshot){
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
                return GridView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.size,

                    itemBuilder: (context,index){
                      var item= snapshot.data!.docs[index];
                      return  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context)=> ProductPage(item.id,"Exclusive offers"))
                             );
                            },
                          child: Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(12),
                            child:  Container(
                              width: 150,
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: Colors.grey

                                  )
                              ),
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Column(

                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 15.0,right: 0,left: 20),
                                          child:  Container(
                                              width: 100,
                                              height: 100,


                                              child: CachedNetworkImage(imageUrl: item["image"])),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Container(

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
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Container(
                                            width: 120,
                                            height: 20,

                                            child: Text(item["quantity"],style: GoogleFonts.poppins(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.w700,
                                              fontSize: width/22.84,
                                            ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Container(
                                            width: 100,
                                            height: 30,
                                            child: Text("Rs. ${item["price"].toString()}",style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: width/20.84,
                                            ),
                                              overflow: TextOverflow.ellipsis,),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
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
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 3.8,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 5),);
              },
            ),




          ],
        ),
      ),
    );
  }
}
