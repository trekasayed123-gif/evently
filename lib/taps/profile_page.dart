import 'package:evently/auth/login.dart';
import 'package:evently/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../firebase/firebase-function.dart';
import '../provider/auth_provider.dart';
import '../provider/theme_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);
    var appProvider = Provider.of<AppProvider>(context);
    var themeProvider = context.watch<ThemeProvider>();


    return Scaffold(
      appBar: AppBar(

        toolbarHeight: 120,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
        ),
        title: Row(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0XFF0E3A99),
              child: Text("Evently", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 15),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text( provider.userModel?.name??"", style: GoogleFonts.poppins(color:Theme.of(context).colorScheme.onSecondary, fontWeight: FontWeight.bold, fontSize: 18)),
            Text( provider.userModel?.email??"", style: GoogleFonts.poppins(color: Theme.of(context).colorScheme.onSecondary, fontSize: 14)),
            const SizedBox(width: 15),
            _buildProfileItem(
              context: context,
              title: "Dark mode",
              trailing: Switch(
                value: themeProvider.isDark,
                onChanged: (value) {
                  themeProvider.toggleTheme(value);
                },

              ),
            ),

            const SizedBox(height: 15),
            _buildProfileItem(
              context: context,
              title: "Language",
              trailing: DropdownButton<String>(
                value: appProvider.appLanguage,
                items: const [
                  DropdownMenuItem(value: "en", child: Text("English")),
                  DropdownMenuItem(value: "ar", child: Text("Arabic")),
                ],
                onChanged: (lang) => appProvider.changeLanguage(lang!),
              ),
            ),

SizedBox(height: 30,),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    FirebaseFunction.signOut();
                    Navigator.pushNamedAndRemoveUntil(context, Login.routName, (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  "Logout",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onError,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem({required String title, required Widget trailing,  required BuildContext context,}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onSecondary)),
          trailing,
        ],
      ),
    );
  }
}