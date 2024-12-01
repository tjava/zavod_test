import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:zavod_test/features/profile/profile_constants.dart';

@RoutePage<dynamic>()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text(lblProfile),
      ),
    );
  }
}
