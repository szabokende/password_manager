import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:password_manager/features/password_feature/domain/entities/password_entity.dart';
import 'package:password_manager/utils/collection_names.dart';



import 'core/throw_server_exception.dart';

Future<void> syncUp(String location, PasswordEntity passwordEntity, String key )async {

  CollectionReference passwordCollection =
  FirebaseFirestore.instance.collection(PASSWORD_COLLECTION + "/" + location);
  passwordEntity = encodePassword(key, passwordEntity);
  try {
    var map = {"website" : passwordEntity.website,
    "password" : passwordEntity.password};
    await passwordCollection.add(map);
  } on FirebaseException catch (e) {
    throwException(e);
  }


}


PasswordEntity encodePassword(String key, PasswordEntity passwordEntity){

  final encrypter = Encrypter(AES(Key.fromUtf8(key)));

  final encrypted = encrypter.encrypt(passwordEntity.password, iv: IV.fromLength(8));
  passwordEntity.password  = encrypted.base64;

  return passwordEntity;
}

