import 'package:evently/addEvent/add_event.dart';
import 'package:evently/provider/auth_provider.dart';
import 'package:evently/taps/favorite_page.dart';
import 'package:evently/taps/home_page.dart';
import 'package:evently/provider/home_provider.dart';
import 'package:evently/taps/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  static const String routName = "Home";
  List<Widget>tap=[HomePage(),FavoritePage(),ProfilePage(),];

   Home({super.key});

  @override
  Widget build(BuildContext context) {
    var   provider =Provider.of<AuthProvider>(context);
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.primary,

            appBar: AppBar(
              title: ListTile(
                title: const Text("Welcome Back ✨"),
                subtitle: Text(
                  provider.userModel?.name??"",

                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color :Theme.of(context).colorScheme.onSecondary
                  ),
                ),
              ),
            ),

            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                Navigator.of(context).pushNamed(AddEvent.routName);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),

            bottomNavigationBar: BottomNavigationBar(
              currentIndex: homeProvider.currentIndex,
              onTap: homeProvider.changeIndex,
              selectedItemColor: Theme.of(context).colorScheme.secondary,
              unselectedItemColor:
              Theme.of(context).colorScheme.onSecondary,
              items: const [
                BottomNavigationBarItem(

                  icon: Icon(Icons.home_filled),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border),
                  label: "Favorite",
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("assets/images/user.png")),
                  label: "Profile",
                ),
              ],

            ),
            body: tap[homeProvider.currentIndex],
          );
        },
      ),
    );
  }
}
