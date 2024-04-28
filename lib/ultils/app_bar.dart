import 'package:flutter/material.dart';

class CustomBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leftWidget;
  final Widget? centerWidget;
  final Widget? rightWidget;

  const CustomBar({
    super.key,
    this.leftWidget,
    this.centerWidget,
    this.rightWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.grey[100],
      leadingWidth: double.infinity,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leftWidget ?? const SizedBox(),
            centerWidget ?? const SizedBox(),
            rightWidget ?? const SizedBox(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
