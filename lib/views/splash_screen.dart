import 'dart:async';
import 'dart:math' as math;
import 'package:covid19app/views/world_stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 3),
    vsync: this,
  )..repeat();
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WorldStats()),
      );
    });
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              child: Container(
                child: Icon(Icons.coronavirus, color: Colors.red, size: 80),
              ),
              builder: (BuildContext context, Widget? iconcontainer) {
                return Transform.rotate(
                  angle: _controller.value * 2.0 * math.pi,
                  child: iconcontainer,
                );
              },
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .05),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Covid 19\nTracker App",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red, fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}
