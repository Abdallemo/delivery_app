import 'package:deliver/pages/intro_pages/first_page.dart';
import 'package:deliver/pages/intro_pages/second_page.dart';
import 'package:deliver/pages/intro_pages/third_page.dart';
import 'package:deliver/services/Auth/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardLeading extends StatefulWidget {
  const OnBoardLeading({super.key});

  @override
  State<OnBoardLeading> createState() => _OnBoardLeadingState();
}

class _OnBoardLeadingState extends State<OnBoardLeading> {
  final PageController _controller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          controller: _controller,
          children: [
            FirstPage(),
            SecondPage(),
            ThirdPage(),
          ],
        ),
      ),
      bottomSheet: onLastPage
          ? TextButton(
              onPressed: () async{
                final perf= await SharedPreferences.getInstance();
                perf.setBool('showHome', true);
                Navigator.pop(context);
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AuthGate()));
              },
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  minimumSize: Size.fromHeight(80),
                  backgroundColor: Colors.lightGreen),
              child: Text(
                "Get Started",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ))
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        _controller.jumpToPage(2);
                      },
                      child: Text('Skip')),
                  Center(
                      child: SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    onDotClicked: (index) => _controller.animateToPage(index,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn),
                  )),
                  GestureDetector(
                      onTap: () {
                        _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      child: Text('Next')),
                ],
              ),
            ),
    );
  }
}
  //  Container(
  //           alignment: Alignment(0, 0.8),
  //           margin: EdgeInsets.only(left: 30, right: 30),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               GestureDetector(
  //                   onTap: () {
  //                     _controller.jumpToPage(2);
  //                   },
  //                   child: Text('Skip')),
  //               SmoothPageIndicator(
  //                 controller: _controller,
  //                 count: 3,
  //                 onDotClicked: (index) => _controller.animateToPage(index,
  //                     duration: Duration(milliseconds: 200),
  //                     curve: Curves.easeIn),
  //               ),
  //               onLastPage
  //                   ? GestureDetector(onTap: () {}, child: Text('Get Started'))
  //                   : GestureDetector(
  //                       onTap: () {
  //                         _controller.nextPage(
  //                             duration: Duration(milliseconds: 500),
  //                             curve: Curves.easeIn);
  //                       },
  //                       child: Text('Next')),
  //             ],
  //           ))