import 'dart:convert';

class StringConverter {
  static String encodeContent(String content){
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encodedContent = stringToBase64.encode(content);
    return encodedContent;
  }
}
