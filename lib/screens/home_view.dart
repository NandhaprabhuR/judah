import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Handle notifications
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          "Welcome Home, Nandha!",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
