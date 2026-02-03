
import 'package:evently/home.dart';
import 'package:evently/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  static const String routName = "Login";

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
              const SizedBox(height: 40),

              Image.asset(
                "assets/images/Blue White Minimal Modern Simple Bold Business Mag Logo 3.png",
                height: 50,
              ),
              const SizedBox(height: 40),
              Text(
                "Login to your account",
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),

              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  hintStyle:  TextStyle(color: Colors.grey),
                  prefixIcon: ImageIcon(
                    AssetImage("assets/images/sms.png"),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xff7B7B7B)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xff7B7B7B)),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const ImageIcon(
                    AssetImage("assets/images/lock.png"),
                  ),
                  suffixIcon: const ImageIcon(
                    AssetImage("assets/images/eye-slash.png"),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xff7B7B7B)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xff7B7B7B)),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Forget Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forget Password?",
                    style: GoogleFonts.inter(
                      color:Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Login Button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => const Home()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onError,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have an account ? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, Register.routName);
                    },
                    child: Text(
                      "Signup",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

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
