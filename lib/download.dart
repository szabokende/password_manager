import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:password_manager/utils/collection_names.dart';
import 'dart:convert';
import 'core/throw_server_exception.dart';
import 'features/password_feature/data/models/password_model.dart';
import 'features/password_feature/domain/entities/password_entity.dart';

Future<List<PasswordEntity>> syncDown(String location) async {

  CollectionReference passwordCollection =
  FirebaseFirestore.instance.collection(PASSWORD_COLLECTION + "/" + location);
  List<PasswordModel> passwords = [];
  try {

      await passwordCollection

          .get()
          .then(
            (data) => data.docs.forEach(
              (doc) {
                final PasswordModel password =
                    PasswordModel.fromJson(doc.data() as Map<String, dynamic>);
                passwords.add(password);
              },
            ),
          );



  } on FirebaseException catch (e) {
    throwException(e);
  }
  return passwords;
}

PasswordEntity decode(PasswordEntity passwordEntity, String key){

  final encrypter = Encrypter(AES(Key.fromUtf8(key)));


  String decodedString = utf8.decode(base64.decode(passwordEntity.password));
  Encrypted encrepted = decodedString as Encrypted;
  final decrypted = encrypter.decrypt(encrepted, iv: IV.fromLength(8));

  passwordEntity.password = decrypted;

  return passwordEntity;
}