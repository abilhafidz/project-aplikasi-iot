import 'package:flutter/material.dart';
import 'dart:async'; 
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late Animation<Offset> _logoAnimation;
  late Animation<Offset> _textAnimation;

  @override
  void initState() {
    super.initState();

    
    _logoController = AnimationController(
      duration: Duration(seconds: 1), 
      vsync: this,
    );

    _logoAnimation = Tween<Offset>(
      begin: Offset(0, -1), 
      end: Offset(0, 0),  
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeInOut, 
    ));

    
    _textController = AnimationController(
      duration: Duration(milliseconds: 700), 
      vsync: this,
    );

    _textAnimation = Tween<Offset>(
      begin: Offset(0, 0.2), 
      end: Offset(0, 0),    
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.elasticInOut, 
    ));

    
    _logoController.forward();

    
    _logoController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 100), () {
          _textController.forward();
        });

        
        Future.delayed(Duration(seconds: 3), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginPage(), 
            ),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF58403B), 
      body: Center(
        child: Stack(
          alignment: Alignment.center, 
          children: [
            
            SlideTransition(
              position: _logoAnimation,
              child: Image.asset(
                'assets/images/logo_rumah.png',
                height: 333, 
                width: 500,
              ),
            ),
            
            Positioned(
              top: 250, 
              child: SlideTransition(
                position: _textAnimation,
                child: Text(
                  'S M A R T H O U S E',
                  style: TextStyle(
                    color: Colors.white, 
                    fontFamily: 'Unica One', 
                    fontSize: 20, 
                    fontWeight: FontWeight.bold, 
                    letterSpacing: 2.0, 
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
