import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class HeaderGenerator {
  late String InstID;
  late String Nonce;
  late String Timestamp;
  late String SignatureMethod;
  late String Signature;
  late String Authorization;

  Map<String, String> generateHeaders(String instID, String clientID,
      String clientSecret, String httpRequest, String path) {
    SignatureMethod = "SHA1";
    InstID = instID;

    //Creating NONCE
    RegExp nonceRegex = RegExp(r"-");
    String rawNonce = generateUUID();
    String nonce = rawNonce.replaceAll(nonceRegex, '');
    Nonce = nonce;

    //Creating the Timestamp
    DateTime now = DateTime.now();
    String timestamp = now.millisecondsSinceEpoch.toString(); // Dart uses milliseconds since epoch
    Timestamp = timestamp;

    //URL Creation
    Uri uri = Uri(
      scheme: 'https',
      host: 'testids.interswitch.co.ke',
      port: 18082,
      path: path,
    );

    // Creating a URLRequest object and encoding it
    http.Request request = http.Request("POST", uri);
    String encodedUrl = Uri.encodeFull(uri.toString());

    List<String> signatureItems = [
      httpRequest,
      encodedUrl,
      timestamp,
      nonce,
      clientID,
      clientSecret
    ];
    List<int> hashedJoinedItems = utf8.encode(signatureItems.join("&"));
    List<int> sha1Bytes = sha1.convert(hashedJoinedItems).bytes;

    Signature = base64.encode(sha1Bytes);
    String encodedClientId = base64.encode(utf8.encode(clientID));
    Authorization = "InterswitchAuth ${utf8.decode(base64.decode(encodedClientId))}";

    return {
      "InstID": InstID,
      "Nonce": Nonce,
      "Timestamp": Timestamp,
      "SignatureMethod": SignatureMethod,
      "Signature": Signature,
      "Authorization": Authorization
    };

    /*
    "HEADERS SAMPLE::
    InstID: 54
    Nonce: 37BA885F9B8048AEA5BAC30DB763DE31
    Timestamp: 1709038265
    SignatureMethod: SHA1
    Signature: CukwIyJTZec3MLbNXIF8wxMw2es=
    Authorization: InterswitchAuth SUtJQTk3MUZCNTk5NkVBREJEMTY1MzQ0OTRDQjg3QjkwRDFEQjNFQUQxMDU="
     */
  }

  String generateUUID() {
    // Generate a random-based UUID
    Random random = Random();
    int randomNumber() => random.nextInt(256);
    List<int> bytes = List<int>.generate(16, (index) => randomNumber());

    // Set the version (4 indicates random-based UUID)
    bytes[6] = (bytes[6] & 0x0f) | 0x40;

    // Set the variant (2 indicates Leach-Salz)
    bytes[8] = (bytes[8] & 0x3f) | 0x80;

    // Convert bytes to hexadecimal format
    String byteToHex(int byte) => byte.toRadixString(16).padLeft(2, '0');
    return List.generate(16, (index) => byteToHex(bytes[index])).join();
  }
}
