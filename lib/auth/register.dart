import 'package:easy_localization/easy_localization.dart';
import 'package:evently/home/home.dart';
import 'package:evently/auth/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../firebase/firebase-function.dart';

class Register extends StatelessWidget {
  Register({super.key});

  var emailAddress = TextEditingController();
  var password = TextEditingController();
  var name = TextEditingController();
  var formKey = GlobalKey<FormState>();

  static const String routName = "Register";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40),
                Image.asset(
                  "assets/images/Blue White Minimal Modern Simple Bold Business Mag Logo 3.png",
                ),
                Text(
                  "Create your account".tr(),
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 40),
                // --- Name Field ---
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    hintText: "Enter your name",
                    hintStyle: TextStyle(color: Colors.grey),
                    // تعديل ألوان الخطأ
                    errorStyle: const TextStyle(color: Colors.red),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),
                    prefixIcon: ImageIcon(AssetImage("assets/images/user.png")),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Color(0xff7B7B7B)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xff7B7B7B)),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // --- Email Field ---
                TextFormField(
                  controller: emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email address cannot be empty";
                    }
                    if (!value.contains('@')) {
                      return "Invalid Email format";
                    }
                    if (!value.contains('.com')) {
                      return "Invalid Email format";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter your email".tr(),
                    hintStyle: TextStyle(color: Colors.grey),

                    errorStyle: const TextStyle(color: Colors.red),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),
                    prefixIcon: ImageIcon(AssetImage("assets/images/sms.png")),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Color(0xff7B7B7B)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xff7B7B7B)),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // --- Password Field ---
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password cannot be empty".tr();
                    }
                    if (value.length < 8) {
                      return "Password must be at least 8 characters long".tr();
                    }
                    if (!value.contains(RegExp(r'[A-Z]'))) {
                      return "Password must contain at least one capital letter".tr();
                    }
                    if (!value.contains(RegExp(r'[0-9]'))) {
                      return "Password must contain at least one number".tr();
                    }
                    return null;
                  },
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter your password".tr(),
                    hintStyle: TextStyle(color: Colors.grey),
                    // تعديل ألوان الخطأ
                    errorStyle: const TextStyle(color: Colors.red),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),
                    prefixIcon: ImageIcon(AssetImage("assets/images/lock.png")),
                    suffixIcon: ImageIcon(
                      AssetImage("assets/images/eye-slash.png"),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Color(0xff7B7B7B)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xff7B7B7B)),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // --- Confirm Password Field ---
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password cannot be empty".tr();
                    }
                    if (value.length < 8) {
                      return "Password must be at least 8 characters long".tr();
                    }
                    if (value != password.text) {
                      return "Passwords do not match".tr();
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Confirm your password".tr(),
                    hintStyle: TextStyle(color: Colors.grey),

                    errorStyle: const TextStyle(color: Colors.red),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),
                    prefixIcon: ImageIcon(AssetImage("assets/images/lock.png")),
                    suffixIcon: ImageIcon(
                      AssetImage("assets/images/eye-slash.png"),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Color(0xff7B7B7B)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xff7B7B7B)),
                    ),
                  ),
                ),
                SizedBox(height: 52),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FirebaseFunction.createUser(
                        emailAddress.text,
                        password.text,
                        name.text,
                            () {
                          Navigator.pushReplacementNamed(
                            context,
                            Login.routName,
                          );
                        },
                            (message) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(message)));
                        }
                        ,

                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    "Sign up".tr(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onError,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?".tr()),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, Login.routName);
                      },
                      child: Text(
                        "Login".tr(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        endIndent: 20,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Text(
                      "Or".tr(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        indent: 20,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/google.png", height: 24),
                      const SizedBox(width: 10),
                      Text(
                        "Login with Google".tr(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}