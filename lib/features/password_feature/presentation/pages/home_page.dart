import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/download.dart';
import 'package:password_manager/features/password_feature/domain/entities/password_entity.dart';
import 'package:password_manager/features/password_feature/presentation/bloc/password_bloc.dart';
import 'package:password_manager/features/password_feature/presentation/bloc/password_event.dart';
import 'package:password_manager/upload.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'package:uuid/uuid.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/route_names.dart';
import '../bloc/password_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RandomPasswordGenerator passwordGenerator = RandomPasswordGenerator();
  TextEditingController webTextEditingController = TextEditingController();
  TextEditingController pwdTextEditingController = TextEditingController();

  final String syncLocation = Uuid().v1();
  late final String encryptionKey;

  @override
  void initState() {
    // TODO: implement initState
    encryptionKey = passwordGenerator.randomPassword(
        letters: true,
        uppercase: true,
        numbers: true,
        specialChar: false,
        passwordLength: 16);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SelectableText('your sync location is: ' + syncLocation),
              SelectableText('your encryption key is: ' + encryptionKey),
              Container(
                width: 1000,
                child: TextField(
                  controller: webTextEditingController,
                  decoration: InputDecoration(hintText: 'website'),
                ),
              ),
              Container(  width: 1000,
                child: TextField(
                  controller: pwdTextEditingController,
                  decoration: InputDecoration(hintText: 'password'),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(
                      () {
                        pwdTextEditingController.text =
                            passwordGenerator.randomPassword(
                          letters: true,
                          uppercase: true,
                          numbers: true,
                          specialChar: true,
                          passwordLength: 20,
                        );
                      },
                    );
                  },
                  child: Text('Suggest a strong password')),
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
                  'Confirm password and save',
                ),
              ),
              ElevatedButton(
                onPressed: () => {
                  BlocProvider.of<PasswordBloc>(context)
                      .add(GetAllPasswordsEvent())
                },
                child: Text(
                  'Show local passwords',
                ),
              ),
              BlocBuilder<PasswordBloc, PasswordState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () => {
                      BlocProvider.of<PasswordBloc>(context)
                          .add(GetAllPasswordsEvent()),
                      Future.delayed(Duration(seconds: 5), () {
                        if (state is LoadedPasswordList) {
                          state.passwordList.forEach((element) {
                            syncUp(
                                syncLocation,
                                PasswordEntity(
                                  website: element.website,
                                  password: element.password,
                                ),
                                encryptionKey);
                          });
                        }
                      }),
                    },
                    child: Text(
                      'Upload local passwords to cloud',
                    ),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () => {context.pushNamed(SYNC_DOWN_PAGE)},
                child: Text(
                  'Sync local passwords with cloud',
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
      ),
    );
  }
}
