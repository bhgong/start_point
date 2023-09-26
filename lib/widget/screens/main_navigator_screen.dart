import 'package:flutter/material.dart';
import 'package:flutter_start_point_application/constants/sizes.dart';
import 'package:flutter_start_point_application/widget/feature/inbox/nav_tab.dart';
import 'package:flutter_start_point_application/widget/screens/home_screen.dart';
import 'package:flutter_start_point_application/widget/screens/post_screen.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class MainNavigationScreen extends StatefulWidget {
  static const String routeName = "mainNavigation";

  final String tab;

  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    "home",
    "post",
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const HomeScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const PostScreen(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + Sizes.size12),
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                isSelected: _selectedIndex == 0,
                icon:
                    _selectedIndex == 0 ? Ionicons.home : Ionicons.home_outline,
                onTap: () => _onTap(0),
              ),
              NavTab(
                isSelected: _selectedIndex == 1,
                icon: _selectedIndex == 1
                    ? FontAwesomeIcons.solidPenToSquare
                    : FontAwesomeIcons.penToSquare,
                onTap: () => _onTap(1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
