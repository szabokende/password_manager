import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/password_bloc.dart';

class SyncPage extends StatefulWidget {
  const SyncPage({Key? key}) : super(key: key);

  @override
  State<SyncPage> createState() => _SyncPageState();
}

class _SyncPageState extends State<SyncPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => {
              BlocProvider.of<PasswordBloc>(context).add(
                Sync(
                  passwordEntity: PasswordEntity(
                    website: webTextEditingController.text,
                    password: pwdTextEditingController.text,
                  ),
                ),
              )
            },
            child: Text(
              'Create password',
            ),
          ),
        ],
      ),
    );
  }
}
