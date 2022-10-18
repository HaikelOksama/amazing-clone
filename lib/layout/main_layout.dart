import 'dart:developer';

import 'package:amazon/screen/account_screen.dart';
import 'package:amazon/screen/home_screen.dart';
import 'package:amazon/utils/colors_theme.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int currentPage = 0;

  void changePage(int page) {
    log(page.toString());
    _pageController.jumpToPage(page);
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: const [
            HomeScreen(),
            Center(
              child: Text('2'),
            ),
            Center(
              child: Text('3'),
            ),
            AccountScreen()
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey[400]!))),
          child: TabBar(
            indicator: const BoxDecoration(
              border: Border(
                top: BorderSide(color: activeCyanColor, width: 3),
              ),
            ),
            indicatorSize: TabBarIndicatorSize.label,
            onTap: (int page) {
              changePage(page);
            },
            tabs: [
              Tab(
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Column(
                    children: [
                      Icon(
                        currentPage == 0 ? Icons.home : Icons.home_outlined,
                        size: 28,
                        color:
                            currentPage == 0 ? activeCyanColor : Colors.black,
                      ),
                      const Text(
                        'Home',
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  ),
                ),
              ),
              Tab(
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Column(
                    children: [
                      Icon(
                        currentPage == 1
                            ? Icons.shopping_cart
                            : Icons.shopping_cart_outlined,
                        size: 28,
                        color:
                            currentPage == 1 ? activeCyanColor : Colors.black,
                      ),
                      const Text(
                        'Cart',
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  ),
                ),
              ),
              Tab(
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Column(
                    children: [
                      Icon(
                        currentPage == 2
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        size: 28,
                        color:
                            currentPage == 2 ? activeCyanColor : Colors.black,
                      ),
                      const Text(
                        'Wishlist',
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  ),
                ),
              ),
              Tab(
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.person_outline_rounded,
                        size: 28,
                        color:
                            currentPage == 3 ? activeCyanColor : Colors.black,
                      ),
                      const Text(
                        'Account',
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
