import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_point_application/widget/feature/authentication/repos/authentication_repo.dart';
import 'package:flutter_start_point_application/widget/feature/authentication/screens/sign_in_screen.dart';
import 'package:flutter_start_point_application/widget/feature/authentication/screens/sign_up_screen.dart';
import 'package:flutter_start_point_application/widget/screens/main_navigator_screen.dart';
import 'package:flutter_start_point_application/widget/screens/post_screen.dart';
import 'package:go_router/go_router.dart';

final routeProvider = Provider(
  (ref) {
    // ref.watch(authState);
    return GoRouter(
      initialLocation: "/home",
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepo).isLoggedIn;
        if (!isLoggedIn) {
          if (state.matchedLocation != SignUpScreen.routeURL &&
              state.matchedLocation != SignInScreen.routeURL) {
            return SignInScreen.routeURL;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
          name: SignUpScreen.routeName,
          path: SignUpScreen.routeURL,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          name: SignInScreen.routeName,
          path: SignInScreen.routeURL,
          builder: (context, state) => const SignInScreen(),
        ),
        GoRoute(
          path: "/:tab(home|post)",
          name: MainNavigationScreen.routeName,
          builder: (context, state) {
            final tab = state.pathParameters["tab"]!;
            return MainNavigationScreen(tab: tab);
          },
        ),
        GoRoute(
          name: PostScreen.routeName,
          path: PostScreen.routeURL,
          builder: (context, state) => const PostScreen(),
        ),
      ],
    );
  },
);
