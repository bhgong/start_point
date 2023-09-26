import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_point_application/constants/gaps.dart';
import 'package:flutter_start_point_application/constants/sizes.dart';
import 'package:flutter_start_point_application/widget/feature/authentication/screens/sign_up_screen.dart';
import 'package:flutter_start_point_application/widget/feature/authentication/view_models/sign_in_view_model.dart';
import 'package:flutter_start_point_application/widget/feature/authentication/view_models/sign_up_view_model.dart';
import 'package:flutter_start_point_application/widget/screens/home_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInScreen extends ConsumerStatefulWidget {
  static const String routeName = "signin";
  static const String routeURL = "/signin";
  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final bool _obscureText = true;
  String _password = "";
  String _email = "";

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });

    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  String? _isEmailVaild() {
    if (_email.isEmpty) return null;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(_email)) {
      return "Email not valid";
    }
    return null;
  }

  bool _isPassWordVaild() {
    return _password.isNotEmpty &&
        _password.length > 8 &&
        _password.length <= 20;
  }

  void _onSubmitTap() {
    if (_email.isEmpty || _isEmailVaild() != null || !_isPassWordVaild()) {
      return;
    }
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save(); //
        ref.read(signinProvider.notifier).signin(
              formData["email"]!,
              formData["password"]!,
              context,
            );
      }
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  void _onSignUpTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
              Sizes.size10,
            ),
            width: size.width,
            height: size.height,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Gaps.v96,
                  const Text(
                    "Welcome!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Sizes.size20,
                    ),
                  ),
                  Gaps.v32,
                  Container(
                    height: Sizes.size52,
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
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      onEditingComplete: _onSubmitTap,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorText: _isEmailVaild(),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: Sizes.size5,
                        ),
                        hintText: 'Email',
                        suffix: _email.isNotEmpty && _isEmailVaild() == null
                            ? const FaIcon(
                                FontAwesomeIcons.solidCircleCheck,
                                color: Colors.green,
                              )
                            : const SizedBox(),
                      ),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Plase write your email";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        if (newValue != null) {
                          formData['email'] = newValue;
                        }
                      },
                    ),
                  ),
                  Gaps.v16,
                  Container(
                    height: Sizes.size52,
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
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      autocorrect: false,
                      onEditingComplete: _onSubmitTap,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Password',
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: Sizes.size5,
                        ),
                        isDense: true,
                        suffixIcon: _isPassWordVaild()
                            ? const FaIcon(
                                FontAwesomeIcons.solidCircleCheck,
                                color: Colors.green,
                              )
                            : const SizedBox(),
                      ),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Plase write your password";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        if (newValue != null) {
                          formData['password'] = newValue;
                        }
                      },
                    ),
                  ),
                  Gaps.v16,
                  GestureDetector(
                    onTap: () => _onSubmitTap(),
                    child: AnimatedContainer(
                      height: Sizes.size52,
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
                        color: ref.watch(signinProvider).isLoading
                            ? Colors.grey.shade400
                            : const Color(0xFFfAA6F6),
                      ),
                      duration: const Duration(milliseconds: 500),
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 500),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: Sizes.size20 - Sizes.size2,
                          color: ref.watch(signinProvider).isLoading
                              ? Colors.grey.shade400
                              : Colors.black,
                        ),
                        child: const Text(
                          "Enter",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).primaryColor,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size44,
              vertical: Sizes.size7,
            ),
            child: GestureDetector(
              onTap: () => _onSignUpTap(context),
              child: Container(
                height: Sizes.size52,
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
                  color: const Color(0xFFfAA6F6),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Create an account ",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: Sizes.size16,
                      ),
                    ),
                    Gaps.h10,
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
