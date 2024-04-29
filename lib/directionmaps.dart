import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorsteps/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'lottiefiles.dart';

class Directiononmap extends StatefulWidget {
  double userlatitude =0.00;
  double userlongitude =0.00;
  double venderlatitude =0.00;
  double venderlongitude =0.00;
  Directiononmap(this.userlatitude,this.userlongitude,this.venderlatitude,this.venderlongitude);

  @override
  State<Directiononmap> createState() => _DirectiononmapState();
}

class _DirectiononmapState extends State<Directiononmap> {

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyB_eT3oT-cOgqnn4zY39efA9Spb9j7ZHyM";
  void initState() {
    super.initState();

    /// origin marker
    _addMarker(LatLng(widget.userlatitude, widget.userlongitude), "origin",
        
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(widget.venderlatitude, widget.venderlongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet));
    _getPolyline();
  }
  cancel() async {
    var devilery = await FirebaseFirestore.instance.collection('DeliveryMan').where("online",isEqualTo: true).get();
    for(int i=0;i<devilery.docs.length;i++){
      FirebaseFirestore.instance.collection('DeliveryMan').doc(devilery.docs[i].id).update({
        "order":false,
      });
    }
    FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid.toString()).update({
      "biketaxi":false,
    });
  }
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return
       Stack(

         children: [
           Container(
             height: 500,
             child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(widget.userlatitude, widget.userlongitude), zoom: 12),
                myLocationEnabled: true,
                tiltGesturesEnabled: true,

                compassEnabled: true,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                onMapCreated: _onMapCreated,
                markers: Set<Marker>.of(markers.values,),
                polylines: Set<Polyline>.of(polylines.values),



              ),
           ),
    Padding(
      padding: const EdgeInsets.only(top: 260.0),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Container(
      color: primarycolor,
      width: double.infinity,

      child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
      LinearProgressIndicator(
      color: Colors.white,
      backgroundColor: primarycolor,
      ),
      Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

      Text("Waiting for your rider",style: GoogleFonts.poppins(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: width/15.84,
      ),),
      ],
      ),
      ),
      Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

      Text("Please don't leave the page",style: GoogleFonts.poppins(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: width/25.84,
      ),),
      ],
      ),
        Waiting(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                cancel();
                Navigator.of(context).pop();
                setState(() {


                });
              },
              child: Shimmer(
                enabled: true,
                color: Colors.white,
                child: Container(

                  width: 300,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:[
                        Text("Cancel", style: GoogleFonts.poppins(
                          color: primarycolor,
                          fontWeight: FontWeight.w700,
                          fontSize: width / 18.84,
                        )),


                      ]
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20,)


      ],
      ),
      ),
      ],
      ),
    )

         ],
       );

  }
  GoogleMapController? mapController;
  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(markerId: markerId, icon: descriptor, position: position,);
    markers[markerId] = marker;
    
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(

      width: 3,


        polylineId: id, color: primarycolor, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(widget.userlatitude, widget.userlongitude),
        PointLatLng(widget.venderlatitude, widget.venderlongitude),
        travelMode: TravelMode.driving,


       );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

}


class Directiononmap2 extends StatefulWidget {
  double userlatitude =0.00;
  double userlongitude =0.00;
  double venderlatitude =0.00;
  double venderlongitude =0.00;
  String orderid ="";
  Directiononmap2(this.userlatitude,this.userlongitude,this.venderlatitude,this.venderlongitude,this.orderid);

  @override
  State<Directiononmap2> createState() => _Directiononmap2State();
}

class _Directiononmap2State extends State<Directiononmap2> {

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyB_eT3oT-cOgqnn4zY39efA9Spb9j7ZHyM";
  void initState() {
    getdetails();
    super.initState();

    /// origin marker
    _addMarker(LatLng(widget.userlatitude, widget.userlongitude), "origin",

        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(widget.venderlatitude, widget.venderlongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet));
    _getPolyline();
  }
  String name="";
  String bike="";
  String phone="";
  String image="";
  String status="";


  getdetails() async {
    final userwallet =FirebaseFirestore.instance.collection('BikeTaxi').doc(widget.orderid);
    userwallet.snapshots().listen(
          (event)  {
        Map<String, dynamic>? value = event.data();
        setState(() {
          name=value!["deliveryman"];
          bike=value["bikeno"];
          phone=value["devierymanphone"];
          image=value["devierymanimage"];
          status=value["status"];
        });
      },
      onError: (error) => print("Listen failed: $error"),
    );
  }
  cancel() async {
    var devilery = await FirebaseFirestore.instance.collection('DeliveryMan').where("online",isEqualTo: true).get();
    for(int i=0;i<devilery.docs.length;i++){
      FirebaseFirestore.instance.collection('DeliveryMan').doc(devilery.docs[i].id).update({
        "order":false,
      });
    }
    FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid.toString()).update({
      "biketaxi":false,
    });
  }
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return
      Stack(

        children: [
          Container(
            height: 500,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(widget.userlatitude, widget.userlongitude), zoom: 12),
              myLocationEnabled: true,
              tiltGesturesEnabled: true,

              compassEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              onMapCreated: _onMapCreated,
              markers: Set<Marker>.of(markers.values,),
              polylines: Set<Polyline>.of(polylines.values),



            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 260.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: primarycolor,
                  width: double.infinity,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text( status=="accepted"? "Your Rider is on the way": "Ride Started",style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: width/15.84,
                            ),),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text("Please don't leave the page",style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: width/25.84,
                          ),),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Text("Rider Details",style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: width/15.84,
                            ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(

                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80)
                              ),

                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(80),
                                  child: Image.network(image,fit: BoxFit.cover,)),
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                  width: 270,
                                  child: Text("Rider Name: ${name}",style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: width/20.84,
                                  ),),
                                ),
                                Container(
                                  width: 270,
                                  child: Text("Vehicle Details: ${bike}",style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: width/20.84,
                                  ),),
                                ),
                                Container(
                                  width: 270,
                                  child: Text("Phone No : ${phone}",style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: width/20.84,
                                  ),),
                                ),
                              ],
                            ),





                          ],
                        ),
                      ),



                      GestureDetector(
                        onTap: (){
                          launch("tel:‎+91 ${phone}");

                        },
                        child: Container(

                          width: 300,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.call,color: primarycolor,),
                                ),
                                Text("Call Rider", style: GoogleFonts.poppins(
                                  color: primarycolor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: width / 18.84,
                                )),


                              ]
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      GestureDetector(
                        onTap: (){
                         cancel();
                         Navigator.of(context).pop();
                        },
                        child: Container(

                          width: 300,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.call,color: primarycolor,),
                                ),
                                Text("Cancel", style: GoogleFonts.poppins(
                                  color: primarycolor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: width / 18.84,
                                )),


                              ]
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),


                    ],
                  ),
                ),
              ],
            ),
          )

        ],
      );

  }
  GoogleMapController? mapController;
  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(markerId: markerId, icon: descriptor, position: position,);
    markers[markerId] = marker;

  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(

        width: 3,


        polylineId: id, color: primarycolor, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(widget.userlatitude, widget.userlongitude),
      PointLatLng(widget.venderlatitude, widget.venderlongitude),
      travelMode: TravelMode.driving,


    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
}
