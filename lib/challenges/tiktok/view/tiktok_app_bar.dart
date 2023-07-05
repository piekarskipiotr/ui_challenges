import 'package:flutter/material.dart';
import 'package:ui_challenges/challenges/tiktok/view/rectangle_tab_indicator.dart';

class TikTokAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TikTokAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TabBar(
        isScrollable: true,
        indicator: RectangleTabIndicator(),
        indicatorWeight: 0,
        indicatorSize: TabBarIndicatorSize.label,
        padding: EdgeInsets.zero,
        labelPadding: const EdgeInsets.symmetric(horizontal: 16),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) => Colors.transparent,
        ),
        dividerColor: Colors.transparent,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black.withOpacity(.5),
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        tabs: const [
          Tab(text: 'Following'),
          Tab(text: 'For you'),
        ],
      ),
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.live_tv_outlined, size: 30),
        highlightColor: Colors.transparent,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          // this icon looks smaller than the leading one
          icon: const Icon(Icons.search_rounded, size: 32),
          highlightColor: Colors.transparent,
        ),
      ],
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
