import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_point_application/constants/gaps.dart';
import 'package:flutter_start_point_application/constants/sizes.dart';
import 'package:flutter_start_point_application/widget/feature/authentication/screens/sign_in_screen.dart';
import 'package:flutter_start_point_application/widget/feature/authentication/view_models/sign_up_view_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const String routeName = "signup";
  static const String routeURL = "/signup";
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
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

  void _onSubmit() {
    if (_email.isEmpty || _isEmailVaild() != null && !_isPassWordVaild()) {
      return;
    }

    ref.read(signUpForm.notifier).state = {
      "email": _email,
      "password": _password,
    };
  }

  void _onSingInTap(BuildContext context) {
    _onSubmit();
    ref.read(signUpProvider.notifier).signUp(context);
  }

  void _onLogInTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
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
                    "Join!",
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
                      onEditingComplete: _onSubmit,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: Sizes.size5,
                        ),
                        errorText: _isEmailVaild(),
                        hintText: 'Email',
                        suffix: _email.isNotEmpty && _isEmailVaild() == null
                            ? const FaIcon(
                                FontAwesomeIcons.solidCircleCheck,
                                color: Colors.green,
                              )
                            : const SizedBox(),
                      ),
                      validator: (value) {
                        return "Wrong email address";
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
                      onEditingComplete: _onSubmit,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: Sizes.size5,
                        ),
                        hintText: 'Password',
                        suffixIcon: _isPassWordVaild()
                            ? const FaIcon(
                                FontAwesomeIcons.solidCircleCheck,
                                size: Sizes.size20,
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
                    onTap: () => _onSingInTap(context),
                    child: Container(
                      height: Sizes.size52,
                      width: size.width * 0.7,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size20,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ref.watch(signUpProvider).isLoading
                              ? Colors.grey.shade400
                              : Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(
                          Sizes.size40,
                        ),
                        color: ref.watch(signUpProvider).isLoading
                            ? Colors.grey.shade400
                            : const Color(0xFFfAA6F6),
                      ),
                      child: const Text(
                        "Create Account",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: Sizes.size20,
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
              onTap: () => _onLogInTap(context),
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
                      "Log in ",
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
