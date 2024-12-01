import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:zavod_test/features/home/presentation/widgets/menu_drawer.dart';
import 'package:zavod_test/features/home/presentation/widgets/show_google_map.dart';

@RoutePage<dynamic>()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const MenuDrawer(),
      body: const ShowGoogleMap(),
    );
  }
}
