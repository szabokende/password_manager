
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'features/password_feature/domain/entities/password_entity.dart';
import 'features/password_feature/presentation/bloc/password_bloc.dart';
import 'features/password_feature/presentation/pages/HomePage.dart';
import 'firebase_options.dart';
import 'features/password_feature/presentation/pages/home_page.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

import 'utils/route_names.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.init();

  runApp(
    MyApp(),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PasswordBloc>(
          create: (context) => sl<PasswordBloc>(),
        ),
      ],
      child:

            MaterialApp.router(





          debugShowCheckedModeBanner: false,
          routerConfig: _router,
          title: 'password manager',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: generateMaterialColor(
                color: const Color(0xff3b0261),
              ),
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
            ),
            buttonTheme: ButtonThemeData(colorScheme: ColorScheme.fromSwatch()),
            // primarySwatch: Colors.blue,
            //fontFamily: GoogleFonts.montserrat().fontFamily,
            textTheme: const TextTheme(
                titleLarge: TextStyle(fontSize: 35),
                titleMedium: TextStyle(fontSize: 25),
                titleSmall: TextStyle(fontSize: 30),
                bodySmall: TextStyle(fontSize: 15),
                bodyLarge: TextStyle(fontSize: 20),
                labelLarge: TextStyle(fontSize: 15)),
            scaffoldBackgroundColor: Color(0xffffffff),
            disabledColor: Colors.grey,
            useMaterial3: true,
          ),

          // },
        ),

    );
  }
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey2 =
    GlobalKey<NavigatorState>();
final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
        navigatorKey: _shellNavigatorKey2,
        builder: (context, state, child) {
          return Scaffold(
            body: Stack(
              children: [
                child,
                // CookieWidget(),
              ],
            ),
          );
        },
        routes: [
          GoRoute(
            name: "/",
            path: "/",
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            name: HOME_PAGE,
            path: HOME_PAGE,
            builder: (context, state) {
              return const HomePage();
            },
          ),
          GoRoute(
            name: CHAT,
            path: CHAT,
            builder: (context, state) {
              return HomePage(

              );
            },
          ),
        ])
  ],
//errorBuilder: (context, state) => const ErrorScreen(),
);
