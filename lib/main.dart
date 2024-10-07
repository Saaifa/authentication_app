import 'package:authentication/auth/presenation/cubit/auth_cubit.dart';
import 'package:authentication/auth/presenation/pages/login_page.dart';
import 'package:authentication/auth/presenation/pages/profile_page.dart';
import 'package:authentication/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'features/auth/presentation/pages/register_page.dart';
import 'package:get_it/get_it.dart';

void main() {
  setupDependencies();
  runApp(MyApp());
}

void setupDependencies() {
  setup();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<AuthCubit>(),
      child: MaterialApp(
        title: 'Auth Flow',
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          // '/register': (context) => RegisterPage(),
          '/profile': (context) => ProfilePage(),
        },
      ),
    );
  }
}
