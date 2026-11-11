import 'dart:ui';
import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const BottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  static const List<IconData> icons = [
    Icons.home_rounded,
    Icons.search_rounded,
    Icons.person_add_alt_1_rounded,
    Icons.sensors_rounded,
    Icons.account_circle_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(35)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 88,
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E).withOpacity(0.96),
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.08)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(icons.length, (index) {
              final selected = selectedIndex == index;

              return GestureDetector(
                onTap: () => onTap(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: const Color(0xFFFF416C).withOpacity(0.20),
                              blurRadius: 20,
                              spreadRadius: 3,
                            ),
                          ]
                        : [],
                  ),
                  child: Icon(
                    icons[index],
                    size: 29,
                    color: selected ? Colors.white : Colors.white70,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
