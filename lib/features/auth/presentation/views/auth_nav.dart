import 'package:auth_demo/features/auth/cubit/auth_cubit.dart';
import 'package:auth_demo/features/home/presentation/home_page.dart';
import 'package:auth_demo/features/login/presentation/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthNav extends StatelessWidget {
  const AuthNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        switch (state.status) {
          case AuthStatus.unauthenticated:
          case AuthStatus.unknown:
            return const LoginPage();
          case AuthStatus.authenticated:
            return const HomePage();
        }
      },
    );
  }
}
