import 'package:evently/add_event.dart';
import 'package:evently/favorite_page.dart';
import 'package:evently/home_page.dart';
import 'package:evently/home_provider.dart';
import 'package:evently/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  static const String routName = "Home";
  List<Widget>tap=[HomePage(),FavoritePage(),ProfilePage(),];

   Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.primary,

            appBar: AppBar(
              title: const ListTile(
                title: Text("Welcome Back ✨"),
                subtitle: Text(
                  "John Safwan",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
              actions: [
                const ImageIcon(AssetImage("assets/images/sun.png")),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "EG",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onError,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
