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
        backgroundColor: Colors.blue,
        toolbarHeight: 120,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
        ),
        title: Row(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: Text("ROUTE", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( provider.userModel?.name??"", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                Text( provider.userModel?.email??"", style: GoogleFonts.poppins(color: Colors.white, fontSize: 14)),
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
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

SizedBox(height: 16,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
               backgroundColor: Theme.of(context).colorScheme.primary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                FirebaseFunction.signOut();
                Navigator.pushNamedAndRemoveUntil(context, Login.routName, (route) => false);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Logout", style: TextStyle(color:Theme.of(context).colorScheme.onSecondary)),
                  const Icon(Icons.logout, color: Colors.red),
                  const SizedBox(width: 10),

                ],
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