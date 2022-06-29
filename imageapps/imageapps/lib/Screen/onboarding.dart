// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:ibb_image/app_style.dart';
import 'package:ibb_image/Screen/connection_database.dart';
import 'package:ibb_image/main.dart';
import 'package:ibb_image/model/onboard_data.dart';
import 'package:ibb_image/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './pages.dart';
import '../widgets/widgets.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);
  AnimatedContainer dotIndicator(index) {
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 5),
      duration: Duration(milliseconds: 400),
      height: 12,
      width: 8,
      decoration: BoxDecoration(
        color: currentPage == index ? KPrimaryColor : KSecondaryColor,
        shape: BoxShape.circle,
      ),
    );
  }

// Start Function Shared Prefrances //
  Future setSeenboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    seenOnboard = await prefs.setBool('seenOnboard', true);
  }

  @override
  void initState() {
    super.initState();
    setSeenboard();
  }
// End Function Shared Prefrances //

  @override
  Widget build(BuildContext context) {
    // Start Initialize Size Config
    SizeConfig().init(context);
    double sizeV = SizeConfig.blocksSizeV!;
    // End Initialize Size Config
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 14,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: onboardingContents.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    SizedBox(
                      height: sizeV * 3,
                    ),
                    Container(
                      height: sizeV * 50,
                      child: Image.asset(
                        onboardingContents[index].image,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: sizeV * 3,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: KBodyText1,
                        children: [
                          TextSpan(text: 'WE CAN '),
                          TextSpan(
                            text: 'HELP YOU ',
                            style: TextStyle(
                              color: KPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: 'TO A BETTER '),
                          TextSpan(text: 'VERSION OF '),
                          TextSpan(
                            text: 'YOURSELF',
                            style: TextStyle(
                              color: KSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  currentPage == onboardingContents.length - 1
                      ? MyTextButton(
                          buttonName: 'Get Started',
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConnectionDatabase(),
                                ));
                          },
                          bgColor: KPrimaryColor,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OnBoardNavBTN(
                              name: 'Skip',
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ConnectionDatabase(),
                                    ));
                              },
                              bgColor: KPrimaryColor,
                            ),
                            Row(
                              children: List.generate(
                                onboardingContents.length,
                                (index) => dotIndicator(index),
                              ),
                            ),
                            OnBoardNavBTN(
                              name: 'Next',
                              onPressed: () {
                                _pageController.nextPage(
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              },
                              bgColor: KPrimaryColor,
                            )
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
