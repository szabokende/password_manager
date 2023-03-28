import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/features/password_feature/domain/entities/password_entity.dart';
import 'package:password_manager/features/password_feature/presentation/bloc/password_bloc.dart';
import 'package:password_manager/features/password_feature/presentation/bloc/password_event.dart';

import '../bloc/password_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController webTextEditingController = TextEditingController();
  TextEditingController pwdTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: webTextEditingController,
              decoration: InputDecoration(hintText: 'website'),

            ),
            TextField(
              controller: pwdTextEditingController,
              decoration: InputDecoration(hintText: 'password'),

            ),
            ElevatedButton(
              onPressed: () => {
                BlocProvider.of<PasswordBloc>(context).add(
                  CreatePasswordEvent(
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
            ElevatedButton(
              onPressed: () => {
                BlocProvider.of<PasswordBloc>(context)
                    .add(GetAllPasswordsEvent())
              },
              child: Text(
                'List values',
              ),
            ),
            BlocBuilder<PasswordBloc, PasswordState>(
              builder: (context, state) {
                print('state is: ' + state.runtimeType.toString());
                if (state is LoadedPasswordList) {
                  print('passwordlist length: ' +
                      state.passwordList.length.toString());
                  // TODO implement an empty page when list.length is 0
                  return Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.passwordList.length,
                        itemBuilder: (context, i) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('${state.passwordList[i].website}'),
                              Text('${state.passwordList[i].password}')
                            ],
                          );
                        }),
                  );
                } else if (state is ErrorPassword) {
                  return Text(state.message);
                } else if (state is LoadingPassword) {
                  return Text('Loading ...');
                } else if (state is EmptyPassword) {
                  return Text('It is empty');
                } else {
                  Text('It is  else empty');
                }
                return Text('It is default empty');
              },
            )
          ],
        ),
      ),
    );
  }
}
