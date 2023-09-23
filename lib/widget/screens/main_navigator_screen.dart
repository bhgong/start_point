import 'package:flutter/material.dart';
import 'package:flutter_start_point_application/constants/gaps.dart';
import 'package:flutter_start_point_application/constants/sizes.dart';
import 'package:flutter_start_point_application/widget/feature/inbox/nav_tab.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

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
    "search",
    "write",
    "activity",
    "profile",
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  // void _onPostTap(int idx) async {
  //   await showModalBottomSheet(
  //     isScrollControlled: true,
  //     // showDragHandle: true,
  //     useSafeArea: true,
  //     clipBehavior: Clip.hardEdge,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(
  //         20,
  //       ),
  //     ),
  //     context: context,
  //     // builder: (context) => const NewPostScreen(),
  //   );

  //   setState(() {
  //     _selectedIndex = idx;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // var isDark = isDarkMode(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // body:
      // Stack(
      // children: [
      //   Offstage(
      //     offstage: _selectedIndex != 0,
      //     child: const HomeScreen(),
      //   ),
      //   Offstage(
      //     offstage: _selectedIndex != 1,
      //     child: const SearchScreen(),
      //   ),
      //   Offstage(
      //     offstage: _selectedIndex != 3,
      //     child: const ActivityScreen(),
      //   ),
      //   Offstage(
      //     offstage: _selectedIndex != 4,
      //     child: const ProfileScreen(),
      //   ),
      //   ],
      // ),
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
                icon: FontAwesomeIcons.house,
                onTap: () => _onTap(0),
              ),
              NavTab(
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.compass,
                onTap: () => _onTap(1),
              ),
              Gaps.h24,
              GestureDetector(
                // onTap: () => _onPostTap(2),
                child: Opacity(
                  opacity: _selectedIndex == 2 ? 1 : 0.6,
                  child: const FaIcon(
                    FontAwesomeIcons.penToSquare,
                  ),
                ),
              ),
              Gaps.h24,
              NavTab(
                isSelected: _selectedIndex == 3,
                icon: FontAwesomeIcons.message,
                onTap: () => _onTap(3),
              ),
              NavTab(
                isSelected: _selectedIndex == 4,
                icon: FontAwesomeIcons.user,
                onTap: () => _onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
