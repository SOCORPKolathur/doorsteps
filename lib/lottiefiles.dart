import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Waiting extends StatefulWidget {
  const Waiting({Key? key}) : super(key: key);

  @override
  State<Waiting> createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  @override
  Widget build(BuildContext context) {
    return  Container(
        width: 300,
        height: 250,

        child: Lottie.asset("assets/baiketaxi.json"));
  }
}
