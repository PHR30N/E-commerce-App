import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class MainLayout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const MainLayout({ required this.navigationShell,super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 161, 202, 234),
      body:navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index){navigationShell.goBranch(index,initialLocation: index == navigationShell.currentIndex);},
        currentIndex: navigationShell.currentIndex,
        items:[ BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Home",),
        BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: "Search",),
        BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        label: "Cart",),
        
        BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: "Settings",)
        

        ]),
    );
  }
}
