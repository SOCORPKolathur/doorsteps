import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BannerSlider extends StatefulWidget {
  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  int _index = 0;
  int _dataLength = 1;

  @override
  void initState() {
    getSliderImageFromDb();
    super.initState();
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getSliderImageFromDb() async {
    var _fireStore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String,dynamic>> snapshot = await _fireStore.collection('slider').get();
    if (mounted) {
      setState(() {
        _dataLength = snapshot.docs.length;
      });
    }
    return snapshot.docs;
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double  width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        if (_dataLength != 0)
          FutureBuilder(
            future: getSliderImageFromDb(),
            builder: (_, AsyncSnapshot<List<QueryDocumentSnapshot<Map<String, dynamic>>>> snapShot)  {

              return snapShot.data == null? const Scaffold(
                body: Center(

                  child: CircularProgressIndicator(),
                ),
              )
                  :

              Container(

                width:width/1,
                height:height/8.2,

                child: CarouselSlider.builder(
                    itemCount: snapShot.data!.length,
                    itemBuilder: ( context,int index, int) {
                      DocumentSnapshot sliderImage = snapShot.data![index];
                      Map? getImage = sliderImage.data() as Map? ;
                      return
                        Container(

                          width:width/1.09,
                          height:height/8.2,

                          child: Container(

                              width:width/1.09,
                              height:height/8.2,
                              decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: getImage == null ? null :
                              CachedNetworkImage(
                                  width:width/1.09,
                                  height:height/8.09,
                                  fit: BoxFit.contain,
                                  imageUrl: getImage["urls"] ?? '')
                          ),
                        );
                    },
                    options: CarouselOptions(
                        viewportFraction: 1,
                        initialPage: 0,
                        autoPlay: true,


                        onPageChanged:
                            (int i, carouselPageChangedReason) {
                          setState(() {
                            _index = i;
                          });
                        }),


                ),
              );
            },
          ),
      ],
    );

  }
}