import 'package:dio/dio.dart';
import 'package:palink_v2/core/constants/app_url.dart';
import 'package:palink_v2/domain/models/chat/conversation.dart';
import 'package:palink_v2/domain/models/chat/message.dart';
import 'package:palink_v2/domain/models/likability.dart';




class ChatService {
  final Dio _dio = Dio(BaseOptions(baseUrl: AppUrl().baseUrl!!));

  ChatService() {
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  Future<Conversation> createConversation(
      ConversationDto conversationDto) async {
    try {
      final response = await _dio.post(
        '/api/conversation/create',
        data: conversationDto.toJson(),
      );

      if (response.statusCode == 200) {
        return Conversation.fromJson(response.data);
      } else {
        throw Exception('Failed to create chat room');
      }
    } catch (e) {
      throw Exception('Failed to create chat room: $e');
    }
  }

  Future<Conversation> getChatRoomById(int chatRoomId) async {
    try {
      final response = await _dio.get(
        '/api/conversation/get_by_conversation_id',
        queryParameters: {'conversation_id': chatRoomId},
      );

      if (response.statusCode == 200) {
        return Conversation.fromJson(response.data);
      } else {
        throw Exception('Failed to get chat room');
      }
    } catch (e) {
      throw Exception('Failed to get chat room: $e');
    }
  }

  Future<List<Conversation>> getConversationsByUserId(String userId) async {
    try {
      final response = await _dio.get(
        '/api/conversation/get_by_user_id',
        queryParameters: {'user_id': userId},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Conversation.fromJson(json)).toList();
      } else {
        throw Exception('Failed to get conversations');
      }
    } catch (e) {
      throw Exception('Failed to get conversations: $e');
    }
  }

  Future<Message?> sendMessage(MessageDto message) async {
    try {
      final response = await _dio.post(
        '/api/message/create',
        data: message.toJson(),
      );

      if (response.statusCode == 200) {
        return Message.fromJson(response.data);
      } else {
        throw Exception('Failed to send message');
      }
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  Future<List<Message>> getMessagesByChatRoomId(int conversationId) async {
    try {
      final response = await _dio.get(
        '/api/message/get_by_conversation_id',
        queryParameters: {'conversation_id': conversationId},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Message.fromJson(json)).toList();
      } else {
        throw Exception('Failed to get messages');
      }
    } catch (e) {
      throw Exception('Failed to get messages: $e');
    }
  }

  Future<Likability> sendLikingLevel(
      String userId, int characterId, int likingLevel, int messageId) async {
    try {
      final response = await _dio.post(
        '/api/liking/create',
        data: {
          'user_id': userId,
          'character_id': characterId,
          'liking_level': likingLevel,
          'message_id': messageId,
        },
      );

      if (response.statusCode == 200) {
        return Likability.fromJson(response.data);
      } else {
        throw Exception('Failed to send liking level');
      }
    } catch (e) {
      throw Exception('Failed to send liking level: $e');
    }
  }
}
