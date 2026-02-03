import 'package:easy_localization/easy_localization.dart';
import 'package:evently/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'intro.dart';

class Onboarding extends StatefulWidget {
  static const String routName = "Onboarding";

  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  bool isEnglish = true;
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDark = themeProvider.isDark;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Image.asset(
            "assets/images/Blue White Minimal Modern Simple Bold Business Mag Logo 3.png",
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            Image.asset("assets/images/Group.png"),
            const SizedBox(height: 24),

            Text(
              "onboardingTitle".tr(),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "onboardingSubTitle".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Language".tr(),
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isEnglish = true;
                        });
                        context.setLocale(const Locale('en', 'US'));
                      },
                      child: Container(
                        decoration: isEnglish
                            ? BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(8),
                              )
                            : null,
                        height: 32,
                        width: 83,
                        child: Center(
                          child: Text(
                            "English".tr(),
                            style: TextStyle(
                              color: isEnglish
                                  ? Theme.of(context).colorScheme.onError
                                  : Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isEnglish = false;
                        });
                        context.setLocale(const Locale('ar', 'EG'));
                      },
                      child: Container(
                        decoration: !isEnglish
                            ? BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(8),
                              )
                            : null,
                        height: 32,
                        width: 83,
                        child: Center(
                          child: Text(
                            "Arabic".tr(),
                            style: TextStyle(
                              color: !isEnglish
                                  ? Theme.of(context).colorScheme.onError
                                  : Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Theme".tr(),
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          themeProvider.toggleTheme(false);;
                        });
                      },
                      child: Container(
                        decoration: isDark
                            ? null
                            : BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                        width: 52,
                        child: ImageIcon(
                          const AssetImage("assets/images/sun.png"),
                          color: isDark
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        setState(() {
                          themeProvider.toggleTheme(true);
                        });
                      },
                      child: Container(
                        decoration: isDark
                            ? BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(8),
                              )
                            : null,
                        width: 52,
                        child: ImageIcon(
                          const AssetImage("assets/images/moon.png"),
                          color: isDark
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Intro.routName);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    minimumSize: const Size(0, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Start".tr(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onError,
                    ),
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
