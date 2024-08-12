import 'dart:convert';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:palink_v2/core/constants/prompts.dart';
import 'package:palink_v2/data/models/ai_response.dart';
import 'package:palink_v2/domain/entities/analysis/analysis_dto.dart';
import 'package:palink_v2/domain/entities/tip/tip.dart';
import 'package:palink_v2/domain/repository/ai_repository.dart';

class AIRepositoryImpl implements AIRepository {
  final ChatOpenAI openAI;
  final ConversationBufferMemory memoryBuffer;
  final ConversationBufferMemory tipMemoryBuffer;
  final ConversationChain chatChain;
  final LLMChain tipChain;
  final LLMChain analyzeChain;

  AIRepositoryImpl(this.openAI, this.memoryBuffer, this.tipMemoryBuffer,
      this.chatChain, this.tipChain, this.analyzeChain);

  @override
  Future<Map<String, dynamic>> getMemory() async {
    final variables = await memoryBuffer.loadMemoryVariables();
    return variables;
  }

  @override
  Future<void> saveMemoryContext(Map<String, dynamic> inputValues,
      Map<String, dynamic> outputValues) async {
    await memoryBuffer.saveContext(
        inputValues: inputValues, outputValues: outputValues);
  }

  @override
  Future<AIResponse?> processChat(Map<String, dynamic> inputs) async {
    try {
      final result = await chatChain.invoke(inputs);
      final AIChatMessage aiChatMessage = result['response'] as AIChatMessage;
      final Map<String, dynamic> contentMap = jsonDecode(aiChatMessage.content);
      AIResponse aiResponse = AIResponse.fromJson(contentMap);
      return aiResponse;
    } catch (e) {
      print('Failed to process chat: $e');
      return null;
    }
  }

  @override
  Future<TipDto?> getTip(String message) async {
    final inputs = {'input': "${Prompt.tipPrompt}\n${message}"};
    try {
      print('getTip inputs: $inputs'); // 로그 추가
      final result = await tipChain.invoke({'input': inputs, 'memory': tipMemoryBuffer});

      AIChatMessage aiChatMessage = result['output'] as AIChatMessage;
      final Map<String, dynamic> tipMap = jsonDecode(aiChatMessage.content);
      return TipDto.fromJson(tipMap);

    } catch (e) {
      print('Failed to get tip: $e');
      return null;
    }
  }

  @override
  Future<AnalysisDto?> analyzeResponse(String input) async {
    try {
      final inputs = {'input': input};
      final result = await analyzeChain.invoke(inputs);
      final AIChatMessage aiChatMessage = result['output'] as AIChatMessage;
      String jsonString = aiChatMessage.content;
      if (jsonString.startsWith('```json') && jsonString.endsWith('```')) {
        jsonString = jsonString.substring(7, jsonString.length - 3).trim();
      }
      final Map<String, dynamic> analyzeMap = jsonDecode(jsonString);
      return AnalysisDto.fromJson(analyzeMap);
    } catch (e) {
      print('Failed to analyze response: $e');
      return null;
    }
  }
}