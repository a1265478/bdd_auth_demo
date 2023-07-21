import 'package:auth_demo/features/auth/cubit/repositories/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/login_cubit.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginCubit(authRepo: RepositoryProvider.of<AuthRepo>(context)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: const Center(child: LoginForm()),
      ),
    );
  }
}
