import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_point_application/constants/sizes.dart';

class PostScreen extends ConsumerStatefulWidget {
  static const String routeName = "post";
  static const String routeURL = "/post";
  const PostScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "🔥 MOOD 🔥",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(
          Sizes.size10,
        ),
        width: size.width,
        height: size.height,
        child: const Text("PostScreen"),
      ),
    );
  }
}
