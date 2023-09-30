import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_point_application/constants/gaps.dart';
import 'package:flutter_start_point_application/constants/sizes.dart';
import 'package:flutter_start_point_application/widget/feature/authentication/repos/authentication_repo.dart';
import 'package:flutter_start_point_application/widget/feature/authentication/screens/sign_in_screen.dart';
import 'package:flutter_start_point_application/widget/models/mood_model.dart';
import 'package:flutter_start_point_application/widget/view_models/home_view_model.dart';
import 'package:flutter_start_point_application/widget/view_models/mood_view_model.dart';
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

  int _itemCount = 0;

  List<MoodModel> moodList = [];

  @override
  void initState() {
    // ref.context.read(moodProvider.notifier);
    super.initState();
  }

  Future<void> _onRefresh() {
    return ref.watch(homeMoodProvider.notifier).refresh();
  }

  void _onDeleteTap() {
    // final userId = "";
    final user = ref.read(authRepo).user;
    ref.read(moodProvider.notifier).removeMood(user!.uid);
  }

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
            onPressed: () => _onDeleteTap(),
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
    return ref.watch(homeMoodProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(
              'Could not load moods: $error',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          data: (moods) {
            moodList = moods;
            // print(moodList);
            _itemCount = moods.length;
            return RefreshIndicator(
              onRefresh: _onRefresh,
              displacement: 50,
              edgeOffset: 20,
              color: Theme.of(context).primaryColor,
              child: Scaffold(
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
                        itemCount: _itemCount,
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
                              child: ListTile(
                                title: Text(
                                  "Mood: ${moodList[_itemCount - 1].mood}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Sizes.size16,
                                  ),
                                ),
                                subtitle: Text(
                                  moodList[_itemCount - 1].comments,
                                  style: const TextStyle(
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
              ),
            );
          },
        );
  }
}
