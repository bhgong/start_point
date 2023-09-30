import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_point_application/constants/gaps.dart';
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

// This shows a CupertinoModalPopup which hosts a CupertinoActionSheet.
  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(
          'Delete note',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size16,
          ),
        ),
        message: const Text(
          'Are you sure you want to do this?',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: Sizes.size16,
          ),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w500,
                fontSize: Sizes.size24,
              ),
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w500,
              fontSize: Sizes.size24,
            ),
          ),
        ),
      ),
    );
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
        ],
      ),
      body: SafeArea(
        child: GestureDetector(
          onLongPress: () => _showActionSheet(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size40,
            ),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Gaps.v52;
              },
              itemCount: 2,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size32,
                  ),
                  child: Container(
                    width: size.width * 0.7,
                    height: size.height * 0.1,
                    decoration: BoxDecoration(
                      color: const Color(0xFF74BDA9),
                      border: Border.all(
                        width: 2,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(
                        Sizes.size16,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size20,
                    ),
                    child: const ListTile(
                      title: Text(
                        "Mood: 😁",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Sizes.size16,
                        ),
                      ),
                      subtitle: Text(
                        "Hello",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
