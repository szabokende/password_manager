import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:password_manager/utils/collection_names.dart';
import 'dart:convert';
import 'core/throw_server_exception.dart';
import 'features/password_feature/data/models/password_model.dart';
import 'features/password_feature/domain/entities/password_entity.dart';

Future<List<PasswordEntity>> syncDown(String location, String encryptionKey) async {
  CollectionReference passwordCollection = FirebaseFirestore.instance
      .collection(PASSWORD_COLLECTION);
  List<PasswordModel> passwords = [];
  try {
    await passwordCollection.where('location', isEqualTo: location).get().then(
          (data) => data.docs.forEach(
            (doc) {
              final PasswordModel password =
                  PasswordModel.fromJson(doc.data() as Map<String, dynamic>);
              print('verify: ' + password.password);
              decode(password, encryptionKey);
              passwords.add(password);
            },
          ),
        );
  } on FirebaseException catch (e) {
    throwException(e);
  }
  print('this is  the password: ' + passwords.first.password);
  return passwords;
}

PasswordEntity decode(PasswordEntity passwordEntity, String key) {
  final decrypter = Encrypter(AES(Key.fromUtf8(key), mode: AESMode.ecb));
  final decrypted = decrypter.decrypt(Encrypted(base64.decode(passwordEntity.password)), iv: IV.fromLength(16));

  print('decryped: ' + decrypted.toString());
  //String decodedString = utf8.decode(decrypted);

  //Encrypted encryped = decodedString as Encrypted;


  passwordEntity.password = decrypted;

  return passwordEntity;
}
