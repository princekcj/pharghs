// ignore_for_file: camel_case_types, use_key_in_widget_constructors, annotate_overrides, prefer_const_literals_to_create_immutables, file_names, unused_element, prefer_const_constructors, prefer_typing_uninitialized_variables, sort_child_properties_last

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pharmafast/Api/data_store.dart';
import 'package:pharmafast/helpar/routes_helper.dart';
import 'package:pharmafast/model/fontfamily_model.dart';
import 'package:pharmafast/screen/home_screen.dart';
import 'package:pharmafast/screen/loginAndsignup/login_screen.dart';
import 'package:pharmafast/utils/Colors.dart';
import 'package:pharmafast/utils/String.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: unused_import
var lat;
var long;

class onbording extends StatefulWidget {
  const onbording({Key? key}) : super(key: key);

  @override
  State<onbording> createState() => _onbordingState();
}

class _onbordingState extends State<onbording> {
  @override
  void initState() {
    super.initState();
    getCurrentLatAndLong();
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getCurrentLatAndLong() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {}
    var currentLocation = await locateUser();
    setState(() {
      lat = currentLocation.latitude;
      long = currentLocation.longitude;
      setScreen();
    });
  }

  setScreen() async {
    Timer(
      const Duration(seconds: 0),
      () => getData.read('Firstuser') != true
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BoardingPage(),
              ),
            )
          : getData.read('Remember') != true
              ? Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                )
              : Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                ),
    );
  }

  void _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = ((prefs.getInt('counter') ?? 0) + 1);
      prefs.setInt('counter', _counter);
    });
  }

  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/Splash.png"), fit: BoxFit.fill),
          gradient: gradient.btnGradient,
        ),
        child: Center(
          child: Image.asset("assets/loginLogo.png", height: 100, width: 100),
        ),
      ),
    );
  }
}

class BoardingPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingPage> {
  // creating all the widget before making our home screeen

  void initState() {
    super.initState();

    _currentPage = 0;

    _slides = [
      Slide("assets/Onboarding1.png", provider.discover, provider.healthy),
      Slide("assets/Onboarding2.png", provider.order, provider.orderthe),
      Slide("assets/Onboarding3.png", provider.lets, provider.cooking),
    ];
    _pageController = PageController(initialPage: _currentPage);
    super.initState();
  }

  int _currentPage = 0;
  List<Slide> _slides = [];
  PageController _pageController = PageController();

  // the list which contain the build slides
  List<Widget> _buildSlides() {
    return _slides.map(_buildSlide).toList();
  }

  Widget _buildSlide(Slide slide) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: WhiteColor,
      body: Column(
        children: <Widget>[
          // ignore: sized_box_for_whitespace
          Container(
            height: Get.height * 0.45, //imagee size
            width: Get.width,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: Get.size.height * 0.1),
            padding: EdgeInsets.all(10),
            child: Image.asset(slide.image, fit: BoxFit.cover),
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage(slide.image), fit: BoxFit.cover)),
          ),
          Column(
            children: [
              SizedBox(height: Get.height * 0.18),
              SizedBox(
                width: Get.width * 0.70,
                child: Text(
                  slide.heading,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 21,
                      fontFamily: "Gilroy Bold",
                      color: BlackColor), //heding Text
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              SizedBox(
                width: Get.width * 0.70,
                child: Text(
                  slide.subtext,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13,
                      color: greycolor,
                      fontFamily: "Gilroy Medium"), //subtext
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // handling the on page changed
  void _handlingOnPageChanged(int page) {
    setState(() => _currentPage = page);
  }

  // building page indicator
  Widget _buildPageIndicator() {
    Row row = Row(mainAxisAlignment: MainAxisAlignment.center, children: []);
    for (int i = 0; i < _slides.length; i++) {
      row.children.add(_buildPageIndicatorItem(i));
      if (i != _slides.length - 1)
        // ignore: curly_braces_in_flow_control_structures
        row.children.add(const SizedBox(
          width: 10,
        ));
    }
    return row;
  }

  Widget _buildPageIndicatorItem(int index) {
    return Container(
      width: index == _currentPage ? 12 : 8,
      height: index == _currentPage ? 12 : 8,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: index == _currentPage ? gradient.defoultColor : greycolor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: WhiteColor,
      body: Stack(
        children: <Widget>[
          Stack(
            children: [
              PageView(
                controller: _pageController,
                onPageChanged: _handlingOnPageChanged,
                physics: const BouncingScrollPhysics(),
                children: _buildSlides(),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.loginScreen);
                  save("isBack", true);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        provider.skip,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Gilroy Bold",
                          color: gradient.defoultColor,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: <Widget>[
                _buildPageIndicator(),
                SizedBox(
                  height: Get.height * 0.21, //indicator set screen
                ),
                _currentPage == 2
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.loginScreen);
                            save("isBack", true);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: gradient.btnGradient,
                                borderRadius: BorderRadius.circular(15)),
                            height: 50,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                provider.getstart,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: WhiteColor,
                                    fontFamily: "Gilroy Bold"),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GestureDetector(
                          onTap: () {
                            _pageController.nextPage(
                                duration: const Duration(microseconds: 300),
                                curve: Curves.easeIn);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: gradient.btnGradient,
                                borderRadius: BorderRadius.circular(15)),
                            height: 50,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                provider.next,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: WhiteColor,
                                    fontFamily: "Gilroy Bold"),
                              ),
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: Get.height * 0.012, //indicator set screen
                ),
                const SizedBox(height: 20)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Slide {
  String image;
  String heading;
  String subtext;

  Slide(this.image, this.heading, this.subtext);
}
