import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:zavod_test/features/history/history_constants.dart';

@RoutePage<dynamic>()
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text(lblHistory),
      ),
    );
  }
}
