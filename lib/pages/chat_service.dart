import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  static const String apiUrl =
      "https://api-inference.huggingface.co/models/facebook/blenderbot-3B";
  static const String apiKey = "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";

  static Future<String> sendMessage(String userMessage) async {
    final headers = {
      "Authorization": "Bearer $apiKey",
      "Content-Type": "application/json",
    };

    final body = jsonEncode({"inputs": userMessage});

    try {
      final response = await http
          .post(Uri.parse(apiUrl), headers: headers, body: body)
          .timeout(const Duration(seconds: 50)); // Increased timeout

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse[0]["generated_text"] ?? "No response from AI.";
      } else if (response.statusCode == 503) {
        return "Model is still loading, please wait a few seconds and try again.";
      } else {
        return "Error: ${response.statusCode} - ${response.body}";
      }
    } catch (e) {
      return "Error: Failed to connect to AI.";
    }
  }
}
