import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_point_application/constants/sizes.dart';
import 'package:flutter_start_point_application/widget/feature/authentication/repos/authentication_repo.dart';
import 'package:flutter_start_point_application/widget/feature/authentication/screens/sign_in_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String routeName = "home";
  static const String routeURL = "/";
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final screens = [
    const Center(
      child: Text(
        'Home',
        style: TextStyle(fontSize: 49),
      ),
    ),
    const Center(
      child: Text(
        'Post',
        style: TextStyle(fontSize: 49),
      ),
    ),
  ];

  @override
  void initState() {
    // ref.context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "🔥 MOOD 🔥",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authRepo).logOut();
              context.goNamed(SignInScreen.routeName);
            },
            icon: const FaIcon(FontAwesomeIcons.powerOff),
          ),
          // CupertinoDialogAction(
          //   onPressed: () {
          //     ref.read(authRepo).logOut();
          //     context.goNamed(SignInScreen.routeName);
          //   },
          //   child: const ,
          // )
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return const Text("Home Screen");
          },
        ),
      ),
    );
  }
}
