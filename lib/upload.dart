import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:password_manager/features/password_feature/domain/entities/password_entity.dart';
import 'package:password_manager/utils/collection_names.dart';

import 'core/throw_server_exception.dart';

Future<void> syncUp(
    String location, PasswordEntity passwordEntity, String key) async {
  CollectionReference passwordCollection =
      FirebaseFirestore.instance.collection(PASSWORD_COLLECTION);
  passwordEntity = encodePassword(key, passwordEntity);
  try {
    var map = {
      "website": passwordEntity.website,
      "password": passwordEntity.password,
      "location": location
    };
    await passwordCollection.add(map);
  } on FirebaseException catch (e) {
    print('error: ' + e.message!);
    throwException(e);
  }
}

PasswordEntity encodePassword(String key, PasswordEntity passwordEntity) {
  final encrypter = Encrypter(AES(Key.fromUtf8(key), mode: AESMode.ecb));

  final encrypted =
      encrypter.encrypt(passwordEntity.password, iv: IV.fromLength(16));
  passwordEntity.password = encrypted.base64;

  return passwordEntity;
}
