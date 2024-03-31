import 'package:data_kontak/controller/KontakController.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final KontakController _controller = KontakController();
  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
