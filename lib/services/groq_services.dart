import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GroqService {
  final String apiKey = dotenv.env['GROQ_API_KEY'] ?? '';
  Future<String> generateTitle(String description) async {
    if (apiKey.isEmpty) {
      throw Exception(
        "Groq API key not found. Pass it using --dart-define=GROQ_API_KEY=...",
      );
      // ...
    }

    final response = await http.post(
      Uri.parse("https://api.groq.com/openai/v1/chat/completions"),
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "llama-3.1-8b-instant",
        "messages": [
          {
            "role": "system",
            "content":
                "Generate a short diary title (maximum 5 words). Return only the title.",
          },
          {"role": "user", "content": description},
        ],
        "temperature": 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data["choices"][0]["message"]["content"].trim();
    }

    throw Exception(response.body);
  }
}
