import 'package:flutter/material.dart';
import 'package:flutter_start_point_application/constants/gaps.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavTab extends StatelessWidget {
  const NavTab({
    super.key,
    required this.isSelected,
    required this.icon,
    required this.onTap,
  });

  final bool isSelected;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    // var isDark = isDarkMode(context);
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          color: const Color(0xFFECE6C2),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isSelected ? 1 : 0.6,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  icon,
                ),
                Gaps.v5,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
