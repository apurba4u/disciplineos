import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/env_config.dart';
import '../logger/app_logger.dart';
import 'ai_provider.dart';
import 'ai_response.dart';

class GeminiProvider implements AIProvider {
  final http.Client _client;

  GeminiProvider({http.Client? client}) : _client = client ?? http.Client();

  @override
  String get name => 'Gemini';

  String get _baseUrl =>
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

  @override
  Future<AIResponse> chat({
    required String prompt,
    required Map<String, dynamic> context,
  }) async {
    try {
      final systemPrompt = _buildChatSystemPrompt(context);
      final response = await _callGemini('$systemPrompt\n\nUser: $prompt');
      return _parseResponse(response);
    } catch (e) {
      AppLogger.error('Gemini chat failed', e);
      return AIResponse.failure('Gemini chat failed: ${e.toString()}');
    }
  }

  @override
  Future<AIResponse> generatePlan({
    required String type,
    required Map<String, dynamic> context,
  }) async {
    try {
      final prompt = _buildPlanPrompt(type, context);
      final response = await _callGemini(prompt);
      return _parseResponse(response);
    } catch (e) {
      AppLogger.error('Gemini plan generation failed', e);
      return AIResponse.failure('Plan generation failed: ${e.toString()}');
    }
  }

  @override
  Future<AIResponse> analyze({
    required String analysisType,
    required Map<String, dynamic> context,
  }) async {
    try {
      final prompt = _buildAnalysisPrompt(analysisType, context);
      final response = await _callGemini(prompt);
      return _parseResponse(response);
    } catch (e) {
      AppLogger.error('Gemini analysis failed', e);
      return AIResponse.failure('Analysis failed: ${e.toString()}');
    }
  }

  @override
  Future<AIResponse> verifyProof({
    required String imageUrl,
    required Map<String, dynamic> taskContext,
  }) async {
    try {
      final prompt = _buildProofPrompt(imageUrl, taskContext);
      final response = await _callGemini(prompt);
      return _parseResponse(response);
    } catch (e) {
      AppLogger.error('Gemini proof verification failed', e);
      return AIResponse.failure('Proof verification failed: ${e.toString()}');
    }
  }

  @override
  Future<AIResponse> summarize({
    required String summaryType,
    required Map<String, dynamic> context,
  }) async {
    try {
      final prompt = _buildSummaryPrompt(summaryType, context);
      final response = await _callGemini(prompt);
      return _parseResponse(response);
    } catch (e) {
      AppLogger.error('Gemini summarization failed', e);
      return AIResponse.failure('Summarization failed: ${e.toString()}');
    }
  }

  Future<String> _callGemini(String prompt) async {
    final apiKey = EnvConfig.geminiApiKey;
    if (apiKey.isEmpty) {
      throw Exception('Gemini API key not configured');
    }

    final response = await _client.post(
      Uri.parse('$_baseUrl?key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': prompt},
            ],
          },
        ],
        'generationConfig': {
          'temperature': 0.7,
          'maxOutputTokens': 2048,
        },
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Gemini API error: ${response.statusCode}');
    }

    final data = jsonDecode(response.body);
    return data['candidates'][0]['content']['parts'][0]['text'] as String;
  }

  String _buildChatSystemPrompt(Map<String, dynamic> context) {
    return '''You are an AI Discipline Coach for Discipline OS.
Your role is to help users become more disciplined and productive.

Current Date: ${DateTime.now().toIso8601String()}

User Context:
${jsonEncode(context)}

Rules:
- Always respond using valid JSON
- Never invent user data
- Use available context only
- Provide actionable recommendations
- Be encouraging but realistic

Response format:
{
  "status": "success",
  "summary": "Your summary here",
  "confidence": 0.95,
  "recommendations": ["action 1", "action 2"],
  "actions": []
}''';
  }

  String _buildPlanPrompt(String type, Map<String, dynamic> context) {
    return '''Generate a $type plan for the user.

Context: ${jsonEncode(context)}

Return JSON with:
{
  "status": "success",
  "summary": "Plan summary",
  "confidence": 0.9,
  "recommendations": ["step 1", "step 2"],
  "actions": []
}''';
  }

  String _buildAnalysisPrompt(String analysisType, Map<String, dynamic> context) {
    return '''Analyze the user's $analysisType.

Context: ${jsonEncode(context)}

Return JSON with:
{
  "status": "success",
  "summary": "Analysis summary",
  "confidence": 0.9,
  "recommendations": ["insight 1", "insight 2"],
  "actions": []
}''';
  }

  String _buildProofPrompt(String imageUrl, Map<String, dynamic> taskContext) {
    return '''Analyze this proof image for task completion verification.

Task Context: ${jsonEncode(taskContext)}
Image URL: $imageUrl

Determine if the image likely shows the task was completed.

Return JSON with:
{
  "status": "success",
  "verified": true/false,
  "confidence": 85,
  "reason": "Your analysis",
  "suggestions": ["suggestion if uncertain"]
}''';
  }

  String _buildSummaryPrompt(String summaryType, Map<String, dynamic> context) {
    return '''Generate a $summaryType summary for the user.

Context: ${jsonEncode(context)}

Return JSON with:
{
  "status": "success",
  "summary": "The summary content",
  "confidence": 0.9,
  "recommendations": ["recommendation 1"]
}''';
  }

  AIResponse _parseResponse(String response) {
    try {
      final cleaned = response.replaceAll('```json', '').replaceAll('```', '').trim();
      final data = jsonDecode(cleaned);

      return AIResponse(
        status: data['status'] as String? ?? 'success',
        summary: data['summary'] as String?,
        confidence: (data['confidence'] as num?)?.toDouble(),
        recommendations: (data['recommendations'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        actions: (data['actions'] as List<dynamic>?)
                ?.map((e) => AIAction(
                      type: e['type'] as String? ?? 'unknown',
                      data: Map<String, dynamic>.from(e['data'] ?? {}),
                    ))
                .toList() ??
            [],
      );
    } catch (e) {
      return AIResponse(
        status: 'success',
        summary: response,
        confidence: 0.8,
      );
    }
  }
}
