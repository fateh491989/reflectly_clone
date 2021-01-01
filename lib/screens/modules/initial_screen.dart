import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:reflectly_clone/screens/register.dart';
import 'package:reflectly_clone/utils/route_animation.dart';

class DelayedAnimation extends StatefulWidget {
  final Widget child;
  final int delay;

  DelayedAnimation({@required this.child, this.delay});

  @override
  _DelayedAnimationState createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _controller);
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
            .animate(curve);

    if (widget.delay == null) {
      _controller.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _controller,
    );
  }
}

typedef void OnButtonTapped();

class InitialScreen extends StatefulWidget {
  final OnButtonTapped onButtonTapped;

  InitialScreen({Key key, @required this.onButtonTapped}) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 800;
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return Column(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        AvatarGlow(
          endRadius: 90,
          duration: Duration(seconds: 2),
          glowColor: Colors.white24,
          repeat: true,
          repeatPauseDuration: Duration(seconds: 0),
          startDelay: Duration(seconds: 0),
          child: Hero(
            tag: 'logoTag',
            child: Material(
                elevation: 8.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  //backgroundColor: Colors.pink,
                  backgroundImage: AssetImage('assets/reflectly.jpg'),
                  radius: 50,
                )),
          ),
        ),
        DelayedAnimation(
          child: Text(
            "Welcome",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25.0, color: color),
          ),
          delay: delayedAmount + 1000,
        ),
        DelayedAnimation(
          child: Text(
            "How can i help you?",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25.0, color: color),
          ),
          delay: delayedAmount + 2000,
        ),
        SizedBox(
          height: 30.0,
        ),
        DelayedAnimation(
          child: Text(
            "Your New Personal",
            style: TextStyle(fontSize: 20.0, color: color),
          ),
          delay: delayedAmount + 3000,
        ),
        DelayedAnimation(
          child: Text(
            "Journaling  companion",
            style: TextStyle(fontSize: 20.0, color: color),
          ),
          delay: delayedAmount + 3000,
        ),
        SizedBox(
          height: 100.0,
        ),
        DelayedAnimation(
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            child: Transform.scale(
              scale: _scale,
              child: _animatedButtonUI,
            ),
          ),
          delay: delayedAmount + 4000,
        ),
        SizedBox(
          height: 50.0,
        ),
        DelayedAnimation(
          child: Text(
            "I Already have An Account".toUpperCase(),
            style: TextStyle(
                fontSize: 20.0, fontWeight: FontWeight.bold, color: color),
          ),
          delay: delayedAmount + 5000,
        ),
      ],
    );
  }

  Widget get _animatedButtonUI => Container(
        height: 60,
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            'New Member!',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      );

  void _onTapDown(TapDownDetails details) {
    _controller.forward().then((_) {
      widget.onButtonTapped();
//      Route route = SlideRightRoute(page: Register());
//      Navigator.push(context, route);
    });
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    this.widget.onButtonTapped();
    Route route = SlideRightRoute(page: RegisterScreen());
    //  Navigator.push(context, route);
  }
}
