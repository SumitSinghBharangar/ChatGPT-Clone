import 'package:dio/dio.dart';
import 'package:sumit_GPT/utils/constant.dart';

import '../model/chat_message_model.dart';

class ChatRepo {
  static Future<String> chatTextGenerationRepo(List<ChatMessageModel> previousMessages) async {
    try {
      Dio dio = Dio();
      final response = await dio.post(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=${apiKey}",
          data: {"contents": previousMessages.map((e) => e.toMap()).toList()});
          if(response.statusCode!>= 200 && response.statusCode !< 300){
            return response.data["candidates"].first["content"]["parts"].first["text"];

          }
          return "";
      
    } catch (e) {
      print(e.toString());
      return "";
    }
    
  }
}
