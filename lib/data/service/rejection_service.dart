import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:palink_v2/data/models/ai_response/rejection_response.dart';

class RejectionService {
  final LLMChain rejectionJudgmentChain;

  RejectionService._(this.rejectionJudgmentChain);

  factory RejectionService.initialize() {
    final openAI = ChatOpenAI(
      apiKey: dotenv.env['API_KEY']!,
      defaultOptions: const ChatOpenAIOptions(
        temperature: 0.4,
        model: 'gpt-4o-mini',
        maxTokens: 50,
      ),
    );

    // 거절 점수 판단 프롬프트
    final rejectionPrompt = ChatPromptTemplate.fromTemplate('''
      당신은 주어진 message를 바탕으로 거절 카테고리를 출력하는 역할을 합니다. 
      message가 주어지면, 해당 내용에 따라 거절 카테고리를 반환하세요. message 가 10자 미만이라면 거절 카테고리는 가장 그럴 듯한 최대 1개까지 반환할 수 있습니다.

      
      message : {message}

      [거절 카테고리]
      거절 승낙: ("알겠어", "그래", "알았어", "그래 뭘 도와줄까?", "그래 뭐하면돼?", "알았엉", "좋아", "그래! 뭐할까?" 등 승낙의 단어가 포함된 경우 승낙으로 판단, 이 경우 다른 거절 카테고리와 중복 불가)
      상황에 대한 공감: ("힘들었겠다", "이해해" 등 상대방의 말에 대한 공감)
      대안 제시: (단, 명확한 거절이 포함되지 않은 경우 점수 변동 없음 만약 "그래 대신 다른 데서 하자!"와 같은 거절 승낙의 뉘앙스 시 적용 안됨, "다른 방법으로 도와줄게" 등)
      단호한 거절: ("싫어", "아니", "안돼" 등)
      부탁 내용 확인: ("무슨 일인데?", "무슨 도움이 필요해?" 등)
      과거 배려에 대한 감사함 표시:  ( "그때 도와줘서 고마웠어" 등)
      잘못에 대한 사과: ("내가 흥분을 해서 화를 내버렸네 미안.” 등)
      명확한 경계 설정 ("더 이상 이 주제에 말하기 불편해" 등)
      시간 제한 ("나 지금 10분밖에 시간이 없어.", "나 시간이 없어서 빨리 말해줘" 등)
      반복된 요청에 재차 단호한 거절 ("이미 말했지만, 이번엔 정말 도와줄 수 없어.", "아까도 말했잖아 안돼" 등) 
      이유 있는 거절: (거절의 이유를 명확하게 설명하고, 설득력 있게 거절한 경우, "다른 계획이 있어서 안 돼", "알바가 있어서 어려워" 등 구체적인 이유가 포함되어야 함)
      수락하지 못함에 대한 아쉬움 표현: ("정말 미안해", "다음에 꼭 도울게" 등)
      무시하거나 냉담한 반응: ("내가 왜 신경 써야 해?", "알아서 해" 등)
      비꼬는 태도: ("네가 그걸 할 수 있다고?" 등)
      불성실한 대답: ("몰라", "어쩔핑" 등)
      이유 없는 거절: ("안 돼", "안 할래" 등 단순히 거절만 표현하고 구체적인 이유를 제공하지 않는 경우 )
      원인을 상대로 돌리기: ("네가 잘못했으니까 안 도와줄 거야" 등)
      주제에서 벗어난 말: ("저녁 뭐 먹지?", "나랑 사귈래?" 등)
      세 글자 이하의 성의 없는 답변: ("ㅇㅇ", "ㄴㄴ" 등)
      티 나는 거짓말: ("내일 우주여행 가서 못해", "할머니 돌아가셨어" 등)
      욕설 또는 인신공격: ("꺼져", "시발", "ㄲㅈ", "너 같은 미친", '미친놈','장애인',"니 애미" 등 부모님에 관한 언급)
      거절이 아닌 단순 반응은 계산하지 않습니다.

      [출력 형식]
      거절 카테고리를 리스트로 반환하세요. 출력은 다음과 같은 형식으로 반환됩니다: 
      - 출력은 'rejectionContent' 의 JSON객체입니다. (전체는 50자 이내로 출력되어야합니다.)
      - 'rejectionContent' 는 ["거절 카테고리1", "거절 카테고리2"] 등의 string 리스트입니다. 리스트에 포함되는 카테고리 개수는 0-2개입니다. 아무 카테고리에도 속하지 않는다면 rejectionContent는 빈 리스트입니다.
    "rejectionContent": [] 을 JSON 객체로 반환하세요. ( 절대로 \'''json로 시작하는 문자열을 생성하지 않는다.)
    ''');


    final rejectionJudgmentChain = LLMChain(
      prompt: rejectionPrompt,
      llm: openAI,
      outputKey: 'rejection',
    );

    return RejectionService._(rejectionJudgmentChain);
  }

  Future<RejectionResponse?> judgeRejection(String message) async {
    try {
      final inputs = {'message': message};
      final result = await rejectionJudgmentChain.invoke(inputs);
      final AIChatMessage aiChatMessage = result['rejection'] as AIChatMessage;

      final String aiContent = aiChatMessage.content;
      final Map<String, dynamic> aiResponseMap = jsonDecode(aiContent);

      return RejectionResponse.fromJson(aiResponseMap);
    } catch (e) {
      print('Failed to analyze rejection: $e');
      return null;
    }
  }
}
