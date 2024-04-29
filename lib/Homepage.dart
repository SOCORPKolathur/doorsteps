import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorsteps/Cart.dart';
import 'package:doorsteps/Home.dart';
import 'package:doorsteps/Profile.dart';
import 'package:doorsteps/Shops.dart';
import 'package:doorsteps/const.dart';
import 'package:doorsteps/explore.dart';
import 'package:doorsteps/productpage.dart';
import 'package:doorsteps/slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int quanity = 1;
  int cart = 0;

  checkcart() async {
    final snapshot = await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("Cart").get();
    if (snapshot.docs.length == 0) {
      setState(() {
        cart=1;
      });
    }
    else{
      setState(() {
        cart=2;
      });
    }
  }
  @override
  void initState() {
    checkcart();
    getCartTotal();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [






        ],
        onPageChanged: (index){

        },
      ),
      bottomNavigationBar: BottomBarBubble(
        selectedIndex: _index,
        items: [
          BottomBarItem(iconData: Icons.home_outlined,label: "Home",labelTextStyle: GoogleFonts.poppins(

        fontWeight: FontWeight.w700,
        fontSize: width/26.84,
      ),),
          BottomBarItem(iconData: Icons.manage_search_sharp,label: "Explore",labelTextStyle: GoogleFonts.poppins(

            fontWeight: FontWeight.w700,
            fontSize: width/26.84,
          ),),
          BottomBarItem(iconData: Icons.shopping_cart_outlined,label: "Cart",labelTextStyle: GoogleFonts.poppins(

            fontWeight: FontWeight.w700,
            fontSize: width/26.84,
          ),),
          BottomBarItem(iconData: Icons.store_mall_directory_outlined,label: "Shop",labelTextStyle: GoogleFonts.poppins(

            fontWeight: FontWeight.w700,
            fontSize: width/26.84,
          ),),
          BottomBarItem(iconData: Icons.person_outline,label: "Account",labelTextStyle: GoogleFonts.poppins(

            fontWeight: FontWeight.w700,
            fontSize: width/26.84,
          ),),
        ],
        onSelect: (index) {

          pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);

          // implement your select function here
        },

      ),

    );
  }
  final PageController pageController = PageController( initialPage: 0,
    keepPage: true,);
  int _index=0;

  @override
  void dispose() {
    super.dispose();
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
class LandingPage2 extends StatefulWidget {
  const LandingPage2({Key? key}) : super(key: key);

  @override
  State<LandingPage2> createState() => _LandingPage2State();
}

class _LandingPage2State extends State<LandingPage2> {
  int _index = 0;


  @override
  void initState() {
    getUserCurrentLocation();
    // TODO: implement initState
    super.initState();
  }
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }
  final screens = <Widget>[
    HomePG(),
    Explore(),
    Cart(),
    Shops(),
    Profile()

  ];

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> key = GlobalKey();
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      body: screens[_index],

      bottomNavigationBar: BottomBarBubble(
          selectedIndex: _index,
          items: [
            BottomBarItem(iconData: Icons.home_outlined,
              label: "Home",
              labelTextStyle: GoogleFonts.poppins(

                fontWeight: FontWeight.w700,
                fontSize: width / 26.84,
              ),),
            BottomBarItem(iconData: Icons.manage_search_sharp,
              label: "Explore",
              labelTextStyle: GoogleFonts.poppins(

                fontWeight: FontWeight.w700,
                fontSize: width / 26.84,
              ),),
            BottomBarItem(iconData: Icons.shopping_cart_outlined,
              label: "Cart",
              labelTextStyle: GoogleFonts.poppins(

                fontWeight: FontWeight.w700,
                fontSize: width / 26.84,
              ),),
            BottomBarItem(iconData: Icons.store_mall_directory_outlined,
              label: "Shop",
              labelTextStyle: GoogleFonts.poppins(

                fontWeight: FontWeight.w700,
                fontSize: width / 26.84,
              ),),
            BottomBarItem(iconData: Icons.person_outline,
              label: "Account",
              labelTextStyle: GoogleFonts.poppins(

                fontWeight: FontWeight.w700,
                fontSize: width / 26.84,
              ),),
          ],
          onSelect: (index) {
    setState(() {
      _index = index;
    }
    );
          }


        // implement your select function her

      ),

    );
  }
}