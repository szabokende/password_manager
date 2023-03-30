import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/features/password_feature/domain/entities/password_entity.dart';
import 'package:password_manager/features/password_feature/presentation/bloc/password_event.dart';

import '../../../../download.dart';
import '../bloc/password_bloc.dart';

class SyncDownPage extends StatefulWidget {
  const SyncDownPage({Key? key}) : super(key: key);

  @override
  State<SyncDownPage> createState() => _SyncDownPageState();
}

class _SyncDownPageState extends State<SyncDownPage> {
  TextEditingController locationTextEditingController = TextEditingController();
  TextEditingController encryptionKeyTextEditingController =
      TextEditingController();
  late List<PasswordEntity> passwordList;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Container(
            width: 1000,
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(  width: 1000,
                  child: TextField(
                    controller: locationTextEditingController,
                    decoration: InputDecoration(hintText: 'Enter the sync location'),
                  ),
                ),
                Container(  width: 1000,
                  child: TextField(
                    controller: encryptionKeyTextEditingController,
                    decoration: InputDecoration(hintText: 'Enter the encryption key'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    passwordList = await syncDown(locationTextEditingController.text,
                        encryptionKeyTextEditingController.text);

                    passwordList.forEach((element) {
                      BlocProvider.of<PasswordBloc>(context).add(
                        CreatePasswordEvent(
                          passwordEntity: PasswordEntity(
                            website: element.website,
                            password: element.password,
                          ),
                        ),
                      );
                    });
                  },
                  child: Text(
                    'Sync passwords with cloud',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
