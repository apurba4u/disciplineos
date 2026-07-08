import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/env_config.dart';
import '../logger/app_logger.dart';
import 'ai_provider.dart';
import 'ai_response.dart';

class DeepSeekProvider implements AIProvider {
  final http.Client _client;

  DeepSeekProvider({http.Client? client}) : _client = client ?? http.Client();

  @override
  String get name => 'DeepSeek';

  String get _baseUrl => 'https://api.deepseek.com/v1/chat/completions';

  @override
  Future<AIResponse> chat({
    required String prompt,
    required Map<String, dynamic> context,
  }) async {
    try {
      final systemPrompt = _buildChatSystemPrompt(context);
      final response = await _callDeepSeek([
        {'role': 'system', 'content': systemPrompt},
        {'role': 'user', 'content': prompt},
      ]);
      return _parseResponse(response);
    } catch (e) {
      AppLogger.error('DeepSeek chat failed', e);
      return AIResponse.failure('DeepSeek chat failed: ${e.toString()}');
    }
  }

  @override
  Future<AIResponse> generatePlan({
    required String type,
    required Map<String, dynamic> context,
  }) async {
    try {
      final messages = [
        {
          'role': 'system',
          'content': 'You are an AI productivity coach. Always respond with valid JSON.',
        },
        {
          'role': 'user',
          'content': _buildPlanPrompt(type, context),
        },
      ];
      final response = await _callDeepSeek(messages);
      return _parseResponse(response);
    } catch (e) {
      AppLogger.error('DeepSeek plan generation failed', e);
      return AIResponse.failure('Plan generation failed: ${e.toString()}');
    }
  }

  @override
  Future<AIResponse> analyze({
    required String analysisType,
    required Map<String, dynamic> context,
  }) async {
    try {
      final messages = [
        {
          'role': 'system',
          'content': 'You are an AI productivity analyst. Always respond with valid JSON.',
        },
        {
          'role': 'user',
          'content': _buildAnalysisPrompt(analysisType, context),
        },
      ];
      final response = await _callDeepSeek(messages);
      return _parseResponse(response);
    } catch (e) {
      AppLogger.error('DeepSeek analysis failed', e);
      return AIResponse.failure('Analysis failed: ${e.toString()}');
    }
  }

  @override
  Future<AIResponse> verifyProof({
    required String imageUrl,
    required Map<String, dynamic> taskContext,
  }) async {
    try {
      final messages = [
        {
          'role': 'system',
          'content': 'You are a task verification assistant. Analyze proof images and determine completion confidence.',
        },
        {
          'role': 'user',
          'content': _buildProofPrompt(imageUrl, taskContext),
        },
      ];
      final response = await _callDeepSeek(messages);
      return _parseResponse(response);
    } catch (e) {
      AppLogger.error('DeepSeek proof verification failed', e);
      return AIResponse.failure('Proof verification failed: ${e.toString()}');
    }
  }

  @override
  Future<AIResponse> summarize({
    required String summaryType,
    required Map<String, dynamic> context,
  }) async {
    try {
      final messages = [
        {
          'role': 'system',
          'content': 'You are an AI report generator. Always respond with valid JSON.',
        },
        {
          'role': 'user',
          'content': _buildSummaryPrompt(summaryType, context),
        },
      ];
      final response = await _callDeepSeek(messages);
      return _parseResponse(response);
    } catch (e) {
      AppLogger.error('DeepSeek summarization failed', e);
      return AIResponse.failure('Summarization failed: ${e.toString()}');
    }
  }

  Future<String> _callDeepSeek(List<Map<String, String>> messages) async {
    final apiKey = EnvConfig.deepseekApiKey;
    if (apiKey.isEmpty) {
      throw Exception('DeepSeek API key not configured');
    }

    final response = await _client.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'deepseek-chat',
        'messages': messages,
        'temperature': 0.7,
        'max_tokens': 2048,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('DeepSeek API error: ${response.statusCode}');
    }

    final data = jsonDecode(response.body);
    return data['choices'][0]['message']['content'] as String;
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
