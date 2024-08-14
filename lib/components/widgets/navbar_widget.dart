import 'package:flutter/material.dart';

class NavbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  List<Widget>? actions;
  Widget? leading;
  IconThemeData? iconTheme;
  bool automaticallyImplyLeading = true;
  bool? centerTitle;
  double? titleSpacing;
  TextStyle? titleTextStyle;
   NavbarWidget({super.key, required this.title,this.actions,this.leading,this.iconTheme,this.automaticallyImplyLeading = true,this.centerTitle,this.titleSpacing,this.titleTextStyle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      iconTheme: IconThemeData(color: Colors.white),
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: Text(title,style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.blue,
      actions: actions,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      titleTextStyle: titleTextStyle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
