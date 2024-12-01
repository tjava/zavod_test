import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:zavod_test/features/home/home_constants.dart';

@RoutePage<dynamic>()
class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text(lblWelcome),
      ),
    );
  }
}
