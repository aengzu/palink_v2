import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:palink_v2/data/models/ai_response/analysis_request.dart';
import 'package:palink_v2/data/models/ai_response/analysis_response.dart';

class ConversationAnalysisService {
  final LLMChain conversationAnalysisChain;

  ConversationAnalysisService._(this.conversationAnalysisChain);

  // Initialization with exception handling for API key
  factory ConversationAnalysisService.initialize() {
    final apiKey = dotenv.env['API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('API_KEY is not set in .env file');
    }

    final openAI = ChatOpenAI(
      apiKey: apiKey,
      defaultOptions: const ChatOpenAIOptions(
        temperature: 0.8,
        model: 'gpt-4-turbo',
        maxTokens: 600,
      ),
    );

    // TODO : 프롬프트 넣기
    final conversationAnalysisPrompt = ChatPromptTemplate.fromTemplate('''
    ''');

    final conversationAnalysisChain = LLMChain(
      llm: openAI,
      prompt: conversationAnalysisPrompt,
      outputKey: 'response',
    );

    return ConversationAnalysisService._(conversationAnalysisChain);
  }

  Future<AnalysisResponse?> analyzeConversation(AnalysisRequest analysisRequest) async {
    try {
      final result = await conversationAnalysisChain.invoke(analysisRequest.toJson());
      final AIChatMessage aiChatMessage = result['output'] as AIChatMessage;
      final AnalysisResponse? rejectionAnalysis = aiChatMessage.content as AnalysisResponse;
      return rejectionAnalysis;
    } catch (e) {
      print('Failed to analyze rejection: $e');
      return null;
    }
  }
}
