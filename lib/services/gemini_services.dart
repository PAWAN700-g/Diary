import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static const apiKey = String.fromEnvironment("Gemini API Key");

  final model = GenerativeModel(
    model: "gemini-1.5-flash",
    apiKey: apiKey,
  );

  Future<String> generateTitle(String description) async {
    final response = await model.generateContent([
      Content.text("""
Generate a short diary title (maximum 5 words).

Diary:
$description

Only return the title.
"""),
    ]);

    return response.text ?? "Untitled";
  }
}