import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method

String hash_password(String p) {
  var bytes = utf8.encode(p); // data being hashed

  var digest_string = sha256.convert(bytes).toString();
  var digest = sha256.convert(bytes);

  print("Digest as bytes: ${digest.bytes}");
  print("Digest as hex string: $digest");
  return digest_string;
}
