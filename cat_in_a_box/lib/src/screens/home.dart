import 'dart:math';
import 'package:flutter/material.dart';
import '../widgets/cat.dart';

class Home extends StatefulWidget {    
  HomeState createState() => HomeState();    
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> _catAnimation;
  AnimationController _catController;

  Animation<double> _flapAnimation;
  AnimationController _flapController;

  initState() {
    super.initState();
    _catController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this
    );

    _catAnimation = Tween(
      begin: -35.0, 
      end: -80.0
    ).animate(
      CurvedAnimation(
        parent: _catController, 
        curve: Curves.easeIn
      )
    );

    _flapController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this
    );

    _flapAnimation = Tween(
      begin: pi * 0.6, 
      end: pi * 0.65
    ).animate(
      CurvedAnimation(
        parent: _flapController,
        curve: Curves.easeInOut
      )
    );

    _flapAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flapController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _flapController.forward();
      }
    });
  }

  Widget _buildCatAnimation() {
    return AnimatedBuilder(
      animation: _catAnimation,
      child: Cat(),
      builder: (context, child) =>
        Positioned(
          child: child, 
          left: 0.0,
          right: 0.0,
          top: _catAnimation.value,
        )
    );
  }

  Widget _buildBox() {
    return Container(
      width: 200.0,
      height: 200.0,
      color: Colors.brown,
    );
  }

  Widget _buildLayout() {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        _buildCatAnimation(),
        _buildBox(),
        _buildLeftFlap(),
        _buildRightFlap()
      ],
    );
  }

  Widget _buildLeftFlap() {
    final flap = Container(
      width: 125.0,
      height: 10.0,
      color: Colors.brown
    );

    return Positioned(
      left: 3,
      child: AnimatedBuilder(
        animation: _flapAnimation,
        child: flap,
        builder: (context, child) =>                 
          Transform.rotate(
            child: child,
            alignment: Alignment.topLeft,
            angle: _flapAnimation.value
          )
      )
    );
  }

  Widget _buildRightFlap() {
    final flap = Container(
      width: 125.0,
      height: 10.0,
      color: Colors.brown
    );

    return Positioned(
      right: 3,
      child: AnimatedBuilder(
        animation: _flapAnimation,
        child: flap,
        builder: (context, child) =>                 
          Transform.rotate(
            child: child,
            alignment: Alignment.topRight,
            angle: -_flapAnimation.value
          )
      )
    );
  }

  void _onTap() async {
    if (_catController.isCompleted) {
      _catController.reverse();     
      _flapController.forward(); 
    } else if(_catController.isDismissed) {
      _catController.forward();    
      _flapController.stop();      
    }    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat in a box!'),
      ),
      body: GestureDetector(
        child: Center(
          child: _buildLayout()
        ),
        onTap: _onTap,
      )
    );
  }
}