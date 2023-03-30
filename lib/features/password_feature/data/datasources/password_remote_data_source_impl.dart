import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../../../core/throw_server_exception.dart';
import '../../../../utils/collection_names.dart';
import '../../domain/entities/password_entity.dart';
import '../models/password_model.dart';
import 'password_remote_data_source.dart';
import 'package:http/http.dart' as http;

class PasswordRemoteDataSourceImpl implements PasswordRemoteDataSource {
  PasswordRemoteDataSourceImpl({required this.client});

  late final http.Client client;

  @override
  Future<void> createPassword(PasswordEntity passwordEntity) async {
    try {
      var map = {};
      //await passwordCollection.add(map);
    } on FirebaseException catch (e) {
      throwException(e);
    }
  }
  @override
  Future<void> syncPassword(PasswordEntity passwordEntity) async {

    CollectionReference passwordCollection =
    FirebaseFirestore.instance.collection(PASSWORD_COLLECTION);

    try {
      var map = {};
      await passwordCollection.add(map);
    } on FirebaseException catch (e) {
      throwException(e);
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

    CollectionReference passwordCollection =
    FirebaseFirestore.instance.collection(PASSWORD_COLLECTION);
    List<PasswordModel> passwords = [];
    try {
/*
      await passwordCollection
          .where('posterUid', isEqualTo: getFirebaseUserUid())
          .get()
          .then(
            (data) => data.docs.forEach(
              (doc) {
                final PasswordModel password =
                    PasswordModel.fromJson(doc.data() as Map<String, dynamic>);
                password.uid = doc.id;
                passwords.add(password);
              },
            ),
          );
      */
      // TODO throw exceptions from all methods in all data impl classes and all feature

    } on FirebaseException catch (e) {
      throwException(e);
    }
    return passwords;
  }

  @override
  Future<PasswordEntity> getPasswordById(List<PasswordEntity> passwordList) async {
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
