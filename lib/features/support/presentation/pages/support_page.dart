import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:zavod_test/features/support/support_constants.dart';

@RoutePage<dynamic>()
class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text(lblSupport),
      ),
    );
  }
}
