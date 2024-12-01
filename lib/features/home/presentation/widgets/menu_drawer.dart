import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zavod_test/core/constants/colors_constant.dart';
import 'package:zavod_test/features/home/home_constants.dart';
import 'package:zavod_test/navigator/router.gr.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: white,
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                lblDemo,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: black,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              lblProfile,
              style: TextStyle(
                fontSize: 16.sp,
                color: black,
              ),
            ),
            onTap: () => context.pushRoute(const ProfileRoute()),
          ),
          ListTile(
            title: Text(
              lblSupport,
              style: TextStyle(
                fontSize: 16.sp,
                color: black,
              ),
            ),
            onTap: () => context.pushRoute(const SupportRoute()),
          ),
          ListTile(
            title: Text(
              lblHistory,
              style: TextStyle(
                fontSize: 16.sp,
                color: black,
              ),
            ),
            onTap: () => context.pushRoute(const HistoryRoute()),
          ),
        ],
      ),
    );
  }
}
