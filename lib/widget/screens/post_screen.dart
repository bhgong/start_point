import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_point_application/constants/gaps.dart';
import 'package:flutter_start_point_application/constants/sizes.dart';
import 'package:flutter_start_point_application/widget/screens/home_screen.dart';
import 'package:flutter_start_point_application/widget/view_models/mood_view_model.dart';
import 'package:flutter_start_point_application/widget/widget/mood_button.dart';
import 'package:go_router/go_router.dart';

class PostScreen extends ConsumerStatefulWidget {
  static const String routeName = "post";
  static const String routeURL = "/post";
  const PostScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostScreenState();
}

const moods = [
  "😃",
  "😍",
  "😝",
  "🥳",
  "🫠",
  "😭",
  "🤬",
  "🥱",
];

class _PostScreenState extends ConsumerState<PostScreen> {
  final TextEditingController _moodTextController = TextEditingController();

  String comments = "";
  String mood = "";
  final List<bool> _isSelected = List.filled(moods.length, false);

  @override
  void initState() {
    _moodTextController.addListener(() {
      setState(() {
        comments = _moodTextController.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _moodTextController.dispose();
    super.dispose();
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void moodTap(int index) {
    _isSelected[index] = !_isSelected[index];
    // print(_isSelected);
    mood = moods[index];
    setState(() {});
  }

  void _onPostTap(BuildContext context) async {
    ref.read(moodProvider.notifier).postMood(comments, mood, context);

    // context.go("/home");
  }

  void _onAddComments(String value) {
    comments = value;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "🔥 MOOD 🔥",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(
              Sizes.size20,
            ),
            width: size.width,
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v20,
                const Text(
                  "How do you feel?",
                  style: TextStyle(
                    fontSize: Sizes.size16 + Sizes.size2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                Container(
                  width: size.width * 0.9,
                  height: size.height * 0.21,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Sizes.size14,
                    ),
                    border: Border.all(width: 1.5),
                  ),
                  child: TextField(
                    controller: _moodTextController,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                        RegExp(
                            r'[a-z|A-Z|0-9|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|ᆞ|ᆢ|ㆍ|ᆢ|ᄀᆞ|ᄂᆞ|ᄃᆞ|ᄅᆞ|ᄆᆞ|ᄇᆞ|ᄉᆞ|ᄋᆞ|ᄌᆞ|ᄎᆞ|ᄏᆞ|ᄐᆞ|ᄑᆞ|ᄒᆞ]'),
                      ),
                    ],
                    keyboardType: TextInputType.text,
                    maxLines: null,
                    autocorrect: false,
                    cursorColor: Colors.black,
                    cursorHeight: Sizes.size14,
                    decoration: const InputDecoration(
                      hintText: "Write it down here!",
                      hintStyle: TextStyle(
                        fontSize: Sizes.size14,
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => _onAddComments(value),
                  ),
                ),
                Gaps.v32,
                const Text(
                  "What's your mood?",
                  style: TextStyle(
                    fontSize: Sizes.size16 + Sizes.size2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v5,
                Container(
                  width: size.width,
                  height: size.height * 0.05,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size5,
                  ),
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return Gaps.h10;
                    },
                    itemCount: moods.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => moodTap(index),
                        child: MoodButton(
                          isSelected: _isSelected[index],
                          text: moods[index],
                          color: _isSelected[index]
                              ? Colors.blueGrey.shade400
                              : Colors.white,
                        ),
                      );
                    },
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size10,
                    ),
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Gaps.v60,
                Center(
                  child: GestureDetector(
                    onTap: () => _onPostTap(context),
                    child: AnimatedContainer(
                      height: Sizes.size44,
                      width: size.width * 0.7,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size20,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(
                          Sizes.size40,
                        ),
                        color:
                            // ref.watch(signinProvider).isLoading
                            //     ? Colors.grey.shade400
                            // :
                            const Color(0xFFfAA6F6),
                      ),
                      duration: const Duration(milliseconds: 500),
                      child: const AnimatedDefaultTextStyle(
                        duration: Duration(milliseconds: 500),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: Sizes.size20 - Sizes.size2,
                          color:
                              //  ref.watch(signinProvider).isLoading
                              //     ? Colors.grey.shade400
                              //     :
                              Colors.black,
                        ),
                        child: Text(
                          "Post",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
