import 'package:easy_localization/easy_localization.dart';
import 'package:evently/home/home.dart';
import 'package:evently/auth/login.dart';
import 'package:evently/onboarding/onboarding.dart';

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';


class Intro extends StatefulWidget {
  static const String routName = "Intro";

  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

final GlobalKey<IntroductionScreenState> introKey =
    GlobalKey<IntroductionScreenState>();

class _IntroState extends State<Intro> {
  int currentIndex = 0;
  List<PageViewModel> listPagesViewModel = [
    PageViewModel(
      titleWidget: Text(
        "Find Events That Inspire You".tr(),
        style: Style.titleStyle,
      ),
      body:
      "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.".tr(),
      image: Image.asset("assets/images/hot-trending.png"),
    ),
    PageViewModel(
      titleWidget: Text("Find Events That Inspire You".tr(), style: Style.titleStyle),
      body:
       "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.".tr(),
      image: Image.asset("assets/images/being-creative.png"),
    ),
    PageViewModel(
      titleWidget: Text(
      "Effortless Event Planning".tr(),
        style: Style.titleStyle,
      ),
      body:
"Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.".tr(),
      image: Image.asset("assets/images/being-creative (1).png"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        key: introKey,
        pages: listPagesViewModel,
        showBackButton: false,
        showNextButton: false,
        showDoneButton: false,
        onChange: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        controlsPadding: EdgeInsets.only(left: 16, right: 16),

        dotsDecorator: DotsDecorator(
          activeColor: Color(0xff3b579d),
          size: Size(10, 10),
          activeSize: Size(22, 10),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),

        globalFooter: Padding(
          padding: const EdgeInsets.all(32),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (currentIndex == listPagesViewModel.length - 1) {
                  Navigator.pushReplacementNamed(context, Login.routName);
                } else {
                  introKey.currentState?.next();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff0E3A99),
                minimumSize: const Size(0, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                currentIndex == listPagesViewModel.length - 1 ? "Get Started".tr() : "Next".tr(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        bodyPadding: EdgeInsets.only(top: 200),

        globalHeader: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(
                  onPressed: () {
                    currentIndex == 0? Navigator.pushReplacementNamed(
                            context,
                            Onboarding.routName,
                          )
                        : introKey.currentState?.controller.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                  },
                  color: Color(0XFF0E3A99),
                ),

                Image.asset(
                  "assets/images/0a9542fe617599971b792e7c348f2828056e822a.png",
                  height: 150,
                  width: 142,
                ),

                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Home.routName);
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(color: Color(0XFF0E3A99), fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
        onDone: () {
          Navigator.pushNamed(context, Home.routName);
        },
      ),
    );
  }
}

class Style {
  static final TextStyle titleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,

  );
  static const TextStyle textStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: Color(0xff0E3A99),
  );
}
