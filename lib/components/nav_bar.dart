// ignore_for_file: non_constant_identifier_names, deprecated_member_use
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_svg/svg.dart';

class NavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  const NavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: CurvedNavigationBar(
        height: 50,
        backgroundColor: Color(0xffA49930),
        color: Color(0xff000915),
        animationDuration: Duration(milliseconds: 300),
        onTap: onTabChanged,
        items: [
          Icon(Icons.home,color: Color(0xffA2A2A4)),
          SvgPicture.asset('assets/images/shop.svg', color: Color(0xffA2A2A4)),
          SvgPicture.asset('assets/images/myProducts.svg', color: Color(0xffA2A2A4)),
          SvgPicture.asset('assets/images/contact.svg', color: Color(0xffA2A2A4)),
        ],
      ),
    );
  }
}
