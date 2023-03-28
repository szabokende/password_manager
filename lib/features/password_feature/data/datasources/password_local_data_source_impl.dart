import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/throw_server_exception.dart';
import '../../domain/entities/password_entity.dart';
import '../models/password_model.dart';
import 'password_local_data_source.dart';
import 'package:http/http.dart' as http;

class PasswordLocalDataSourceImpl implements PasswordLocalDataSource {
  PasswordLocalDataSourceImpl({required this.storage});

  final FlutterSecureStorage storage;

  IOSOptions _getIOSOptions() => const IOSOptions(
        accountName: AppleOptions.defaultAccountName,
      );

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
        // sharedPreferencesName: 'Test2',
        // preferencesKeyPrefix: 'Test'
      );

  @override
  Future<void> createPassword(PasswordEntity passwordEntity) async {
    try {
      await storage.write(
        key: passwordEntity.website,
        value: passwordEntity.password,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions(),
      );
    } on Exception catch (e) {
      throw Exception();
    }
  }

  @override
  Future<void> editPassword(PasswordEntity passwordEntity) async {
    try {
      var map = {};
      //await passwordCollection.doc(passwordEntity.uid).update(map);
    } on FirebaseException catch (e) {
      throwException(e);
    }
  }

  @override
  Future<List<PasswordEntity>> getAllPasswords() async {
    print('get all passwords called');
    List<PasswordModel> passwords = [];
    late var results;
    try {
      final all = await storage.readAll(
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions(),
      );
print('all: ' +  all.keys.first);
      results = all.entries
          .map(
              (entry) => PasswordEntity(website: entry.key, password: entry.value))
          .toList(growable: false);
      return results;
    } on FirebaseException catch (e) {
      throwException(e);
    }
    return passwords;
  }

  @override
  Future<PasswordEntity> getPasswordById(
      List<PasswordEntity> passwordList) async {
    List<PasswordModel> passwordModelList = [];
    passwordList.forEach((element) {
      passwordModelList.add(
        PasswordModel(
          website: element.website,
          password: element.password,
        ),
      );
    });
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization':
          'Bearer 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'
    };
    print(
      'kakas: ' + passwordModelList[0].toJson().toString(),
    );
    List<Map<String, dynamic>> passwordMapList = [];
    passwordModelList.forEach(
      (element) {
        passwordMapList.add(element.toJson());
        print('kakas2: ' + element.toJson().toString());
      },
    );
    passwordMapList.forEach(
      (element) {
        print('passwordMapList: ' + element.toString());
      },
    );
    final data = {
      'model': 'gpt-3.5-turbo',
      'passwords': passwordMapList,
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));
    print(response.body);
    final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
    final dataMap = jsonResponse as Map<String, dynamic>;
    final PasswordModel password = PasswordModel.fromJson(dataMap);
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print(responseData);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return password;
  }
}
