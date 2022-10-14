import 'dart:developer';

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
            Center(
              child: Text('1'),
            ),
            Center(
              child: Text('2'),
            ),
            Center(
              child: Text('3'),
            ),
            Center(
              child: Text('4'),
            ),
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
                child: Icon(Icons.home_outlined,
                    color: currentPage == 0 ? activeCyanColor : Colors.black),
              ),
              Tab(
                child: Icon(Icons.shopping_cart_outlined,
                    color: currentPage == 1 ? activeCyanColor : Colors.black),
              ),
              Tab(
                child: Icon(Icons.favorite_border_outlined,
                    color: currentPage == 2 ? activeCyanColor : Colors.black),
              ),
              Tab(
                child: Icon(Icons.person_outline_rounded,
                    color: currentPage == 3 ? activeCyanColor : Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
