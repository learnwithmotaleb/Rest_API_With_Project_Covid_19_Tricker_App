import 'dart:async';

import 'package:covid19app/View/word_state.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late AnimationController _controller = AnimationController(
    duration: Duration(seconds: 3),
      vsync: this,
  )..repeat();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),()=> Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) =>WorldStatesScreen()))
    );


  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget? child){
                  return Transform.rotate(
                      angle: _controller.value * 2.0 * math.pi,
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: Center(
                        child: Image.asset('images/virus.png',),
                      ),
                    ),
                  );

                }

            ),
            SizedBox(height: MediaQuery.of(context).size.height*.08,),
            RichText(
              text:  TextSpan(
                text: "Covid-19 ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.orange

                  ),
                children:[
                  TextSpan(
                    text: 'Tracker',
                    style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white

              ),
              ),

                ]

              ),
            )

          ],
        ),
      ),
    );
  }
}
