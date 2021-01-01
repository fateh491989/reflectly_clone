import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:math' as math;
import 'modules/initial_screen.dart';
import 'modules/name.dart';
import 'modules/otp_screen.dart';
import 'modules/phone.dart';
import 'modules/theme_change_screen.dart';
import 'splash_screen.dart';
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {

  int currentIndex = 0;
  double avatarRadius = 40;
  List<Widget> _widget = [];
  PageController controller = PageController();
  AnimationController _indicatorAnimationController, _avatarAnimationController;
  Animation<Offset> _animation, _avatarAnimation;
  Animation<double> _avatarAnimationDouble;
  CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();

    _indicatorAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1750));
    _avatarAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1750),);
    _curvedAnimation = CurvedAnimation(
        parent: _indicatorAnimationController, curve: Curves.decelerate);
    // TODO change offsets

    _avatarAnimation = Tween<Offset>(begin: Offset(screenWidth/2-avatarRadius,80), end: Offset(20, 30))
        .animate(CurvedAnimation(parent: _indicatorAnimationController, curve: Curves.linear));
    _avatarAnimationDouble= Tween<double>(begin: 1.2, end: 0.8)
        .animate(CurvedAnimation(parent: _indicatorAnimationController, curve: Curves.linear));

    _animation = Tween<Offset>(begin: Offset(10, 0), end: Offset(0, 0))
        .animate(_curvedAnimation);
    _animation.addListener(() {
      setState(() {});
    });
    _avatarAnimation.addListener(() {
      setState(() {});
    });
    _avatarAnimationDouble.addListener(() {
      setState(() {});
    });
    _widget = [
      InitialScreen(
          onButtonTapped: (){
            nextScreen();
          }
      ),
      NameScreen(),
      PhoneScreen(),
      ThemeChangeScreen(),
      OtpScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
            children: <Widget>[
              PageView.builder(
                  controller: controller,
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    currentIndex = index;
                    return _widget[index];
                  }),
              Hero(
                tag: 'logoTag1',
                child: Transform.translate(
                  offset: _avatarAnimation.value,
                  child: Transform.scale(
                    scale: _avatarAnimationDouble.value,
                    child: Material(
                        elevation: 8.0,
                        shape: CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          //backgroundColor: Colors.pink,
                          backgroundImage: AssetImage('assets/reflectly.jpg'),
                          radius: avatarRadius,

                        )),
                  ),
                ),
              ),
              Positioned(
                  top: 65,
                  right: -25,
                  child: SlideTransition(
                    position: _animation,
                    child: Transform.rotate(
                      angle: math.pi / 2,
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: _widget.length,
                        effect: JumpingDotEffect(
                          activeDotColor: Colors.white,
                          dotColor: Colors.grey
                        ),
                      ),
                    ),
                  )),
              Positioned(
                  bottom: 10,
                  right: 10,
                  child: SlideTransition(
                    position: _animation,
                    child: Column(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.keyboard_arrow_up),
                            onPressed: currentIndex == 0 ? null : _previousScreen),
                        IconButton(
                            icon: Icon(Icons.keyboard_arrow_down),
                            onPressed: currentIndex == _widget.length - 1
                                ? navigateToWelcomeScreen
                                : nextScreen),
                      ],
                    ),
                  ))
            ],
          )),
    );
  }

  void _previousScreen() {
    currentIndex = currentIndex - 1;
    controller.animateToPage(currentIndex,
        duration: Duration(seconds: 1), curve: Curves.easeIn);

    if(currentIndex==0){
      _indicatorAnimationController.reverse();
      _avatarAnimationController.reverse();
    }
    setState(() {});
  }

  void nextScreen() {
    currentIndex = currentIndex + 1;
    controller.animateToPage(currentIndex,
        duration: Duration(seconds: 1), curve: Curves.easeIn);

    if(currentIndex==1){
      _indicatorAnimationController.forward();
      _avatarAnimationController.forward();
    }
    setState(() {});
  }
  navigateToWelcomeScreen(){
    /// Write your code to navigate to authentic home screen
    // Route route = MaterialPageRoute(builder: (_)=>WelcomeScreen());
    // Navigator.push(context, route);
  }

}
