import 'package:evently/home.dart';
import 'package:evently/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  static const String routName = "Register";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40),
              Image.asset(
                "assets/images/Blue White Minimal Modern Simple Bold Business Mag Logo 3.png",
              ),
              Text(
                "Create your account",
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 40),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  hintStyle: TextStyle(color: Colors.grey),
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
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  hintStyle: TextStyle(color: Colors.grey),
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
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  hintStyle: TextStyle(color: Colors.grey),
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
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Confirm your password",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: ImageIcon(AssetImage("assets/images/lock.png")),
                  suffix: ImageIcon(AssetImage("assets/images/eye-slash.png")),
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
                  Navigator.pushReplacementNamed(context, Home.routName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  "Sign up",
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
                  Text("Already have an account?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, Login.routName);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32,),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      endIndent: 20,
                      color:  Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Text("Or", style: TextStyle(color:  Theme.of(context).colorScheme.secondary,)),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      indent: 20,
                      color:  Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: () {

                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color:  Theme.of(context).colorScheme.secondary,),
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
                      "Login with Google",
                      style: TextStyle(color:  Theme.of(context).colorScheme.secondary, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
