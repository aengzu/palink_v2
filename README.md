## Quest-Based Conversation Practice Simulation (LLM) Project (퀘스트 기반 대화 시뮬레이션 (LLM) 프로젝트)

[(English Description)](#english-description) | [(한국어 설명)](#한국어-설명)

---

## English Description
**Role-Playing System for Improving Friend Relationships Using LLM**

A lack of self-expression becomes most apparent in situations where one needs to refuse a request.  

PALINK is a system designed to enhance self-expression by allowing users to practice communication skills through simulated conversations with a virtual friend, focusing on the theme of "refusing requests."

![014](https://github.com/aengzu/palink_v2/assets/102356873/dbaf5178-7f2d-4fe7-8434-204332f6fef0)

### Background
A survey conducted with 57 Korean adolescents asked, "What do you think needs improvement in your interpersonal relationships? Please select the option that applies to you." The majority (47.4%) identified "awareness of others" as the key area for improvement. This tendency is closely linked to a lack of self-expression.
![009](https://github.com/aengzu/palink_v2/assets/102356873/129ba3de-a3a2-490d-889b-e87813a67f8c)

### Our GOAL
**[Goal]**  
The goal of this study is to develop a role-playing-based interpersonal practice system aimed at improving interpersonal relationship issues and to validate its effectiveness.

**[Key Elements for Achieving the Goal]**
1. Conversation simulation with a virtual friend  
2. Practice of communication techniques  
3. Real-time conversation evaluation and guidance  

![012](https://github.com/aengzu/palink_v2/assets/102356873/efb257bf-a165-499e-93a2-efa2f31e5ca2)

### Content
**1. Role-Playing Therapy Technique**  
Role-playing therapy involves recreating interpersonal scenarios to experience therapeutic effects. Leveraging this technique, users engage in role-playing with AI characters in specific situations, such as practicing refusals.

**2. Positive Mindset Formation**  
Before loading screens or the start of a conversation, the system displays encouraging phrases to help users build confidence and foster a positive mindset.

**3. Quest-Based Learning**  
Users receive guidance through quests, allowing them to follow structured steps to learn effective refusal techniques. Quests are detected by prompts designed to identify refusal categories, which are then processed in the code to track quest progress.

**4. Tip Assistance and Feedback**  
If users struggle to find an appropriate response during a conversation, they can use a "Tip" button to receive textual guidance. Once the conversation ends, the dialogue history is analyzed using a prompt, and comprehensive final feedback is provided.

<br>

![015](https://github.com/aengzu/palink_v2/assets/102356873/a4d9b79d-6694-4d0c-b440-03f87384969f)

### Stack
![기술스택](https://github.com/user-attachments/assets/bf0a8b75-d4c6-4ef8-8a42-95e640ef62cb)

### Flow
![작동 메커니즘](https://github.com/user-attachments/assets/f0a7e74f-338e-4458-a28f-8ee76b039df2)

### Prompt Structure
**1. Response Generation Prompt**  
- Generates appropriate replies for the conversation based on the user's statements.  

**2. Refusal Detection Prompt**  
- Analyzes the user's statements to detect refusal patterns or categories.  

**3. Tip Generation Prompt**  
- Provides example responses or tips to guide the user when they struggle to reply.  

**4. Final Analysis Prompt**  
- Evaluates the entire conversation to deliver comprehensive feedback and insights for improvement.  

### SHOWCASES
- Demo

https://github.com/user-attachments/assets/14608270-134c-464f-a5c8-2b1af5091ead  

- Four Different Character Personas (미연, 진혁, 세진, 현아)  
We have adjusted the prompts to create four different characters with distinct personas. This allows users to practice refusal scenarios tailored to each character type.  

<p float="left">
  <img src="https://github.com/user-attachments/assets/c89d9da7-7120-4b44-b03a-f664517c5825" width="200" />
  <img src="https://github.com/user-attachments/assets/9970cf03-0e97-48fd-a942-94bec70048b1" width="200" /> 
  <img src="https://github.com/user-attachments/assets/1a064fe8-aeee-4b5f-9ae9-7fcde74ca7e1" width="200" /> 
  <img src="https://github.com/user-attachments/assets/8e6fa0c2-1683-4ba4-bbef-0f7d6551cc13" width="200" /> 
</p>

- Tip Feature via Button (Example Answer Generation)  
<p float="left">
  <img src="https://github.com/user-attachments/assets/ec728301-46c7-492d-8837-b9317ef3ae92" width="200" />
  <img src="https://github.com/user-attachments/assets/136bf50d-1130-41a6-b4ed-0042a44e1148" width="200" /> 
</p>

- Quest Provision and Detection Tailored to Each Persona  
(Quest 3: “상대방이 처한 상황 파악하기” 달성 시 토스트 메시지)

https://github.com/user-attachments/assets/2b7a9242-dcd6-48e5-8ebe-93d1f78053e8  

### Getting Started
My flutter version : Flutter 3.23.0-8.0.pre.3  
It will be rewritten after code maintenance.

---

## 한국어 설명
**LLM을 활용하여 친구 관계를 개선하기 위한 롤플레잉 시스템**

자기 표현의 부족은 거절해야 하는 상황에서 가장 두드러지게 나타납니다.  

PALINK는 거절 상황을 중심으로 가상 친구와의 대화를 통해 의사소통 능력을 연습하고 자기 표현을 강화하도록 돕는 시스템입니다.

![014](https://github.com/aengzu/palink_v2/assets/102356873/dbaf5178-7f2d-4fe7-8434-204332f6fef0)

### 배경 (Background)
57명의 한국 청소년을 대상으로 “대인 관계에서 무엇을 개선해야 한다고 생각합니까?”라는 설문을 진행한 결과, 응답자의 47.4%가 ‘타인에 대한 인식’을 가장 필요한 개선 영역으로 꼽았습니다. 이는 자기 표현 부족과 밀접하게 연결된 경향입니다.  
![009](https://github.com/aengzu/palink_v2/assets/102356873/129ba3de-a3a2-490d-889b-e87813a67f8c)

### 목표 (Our GOAL)
**[목표]**  
이 연구의 목표는 롤플레잉 기반 대인관계 연습 시스템을 개발하여 대인관계 문제를 개선하고 그 효과를 검증하는 것입니다.  

**[목표 달성을 위한 핵심 요소]**
1. 가상 친구와의 대화 시뮬레이션  
2. 의사소통 기법 연습  
3. 실시간 대화 평가와 피드백 제공  

![012](https://github.com/aengzu/palink_v2/assets/102356873/efb257bf-a165-499e-93a2-efa2f31e5ca2)

### 주요 내용 (Content)
**1. 롤플레잉 치료 기법**  
롤플레잉 치료는 대인관계 상황을 재현하여 치료적 효과를 경험하도록 돕는 기법입니다. 본 시스템에서는 이 방식을 활용하여 사용자가 특정 상황(예: 거절 연습)에서 AI 캐릭터와 롤플레잉을 진행합니다.  

**2. 긍정적 마음가짐 형성**  
로딩 화면이나 대화 시작 전 격려 문구를 제공하여 자신감을 높이고 긍정적인 태도를 유지할 수 있도록 돕습니다.  

**3. 퀘스트 기반 학습**  
사용자는 퀘스트를 따라가며 효과적인 거절 기법을 단계적으로 학습할 수 있습니다. 거절 유형을 탐지하는 프롬프트가 퀘스트 달성 여부를 감지하고 코드에서 이를 처리해 진행 상황을 추적합니다.  

**4. 팁 기능과 피드백**  
사용자가 대화 도중 적절한 응답을 찾기 어려울 때 ‘팁(Tip)’ 버튼을 눌러 예시 문장을 참고할 수 있습니다. 대화 종료 후에는 대화 내역 전체를 분석해 종합적인 피드백과 개선 방향을 제공합니다.  

<br>

![015](https://github.com/aengzu/palink_v2/assets/102356873/a4d9b79d-6694-4d0c-b440-03f87384969f)

### 기술 스택 (Stack)
![기술스택](https://github.com/user-attachments/assets/bf0a8b75-d4c6-4ef8-8a42-95e640ef62cb)

### 플로우 (Flow)
![작동 메커니즘](https://github.com/user-attachments/assets/f0a7e74f-338e-4458-a28f-8ee76b039df2)

### 프롬프트 구조 (Prompt Structure)
**1. 응답 생성 프롬프트**  
- 사용자의 발화를 기반으로 적절한 대화 응답을 생성합니다.  

**2. 거절 탐지 프롬프트**  
- 사용자의 발화를 분석하여 거절 패턴이나 유형을 감지합니다.  

**3. 팁 생성 프롬프트**  
- 사용자가 답변에 어려움을 겪을 때 예시 응답이나 힌트를 제공합니다.  

**4. 최종 분석 프롬프트**  
- 대화 전체를 평가해 종합적인 피드백과 개선 방향을 제시합니다.  

### 시연 (SHOWCASES)
- 데모

https://github.com/user-attachments/assets/14608270-134c-464f-a5c8-2b1af5091ead  

- 네 가지 캐릭터 페르소나 (미연, 진혁, 세진, 현아)  
각 캐릭터가 다른 성격을 갖도록 프롬프트를 조정해, 다양한 유형에 맞춘 거절 연습이 가능합니다.  

<p float="left">
  <img src="https://github.com/user-attachments/assets/c89d9da7-7120-4b44-b03a-f664517c5825" width="200" />
  <img src="https://github.com/user-attachments/assets/9970cf03-0e97-48fd-a942-94bec70048b1" width="200" /> 
  <img src="https://github.com/user-attachments/assets/1a064fe8-aeee-4b5f-9ae9-7fcde74ca7e1" width="200" /> 
  <img src="https://github.com/user-attachments/assets/8e6fa0c2-1683-4ba4-bbef-0f7d6551cc13" width="200" /> 
</p>

- 팁 기능 (예시 답변 생성)  
<p float="left">
  <img src="https://github.com/user-attachments/assets/ec728301-46c7-492d-8837-b9317ef3ae92" width="200" />
  <img src="https://github.com/user-attachments/assets/136bf50d-1130-41a6-b4ed-0042a44e1148" width="200" /> 
</p>

- 퀘스트 제공 및 탐지 (페르소나별 맞춤)  
(퀘스트 3 ‘상대방이 처한 상황 파악하기’ 달성 시 토스트 메시지 예시)

https://github.com/user-attachments/assets/2b7a9242-dcd6-48e5-8ebe-93d1f78053e8  


### 시작하기 (Getting Started)
현재 코드 보수 중이며, 완료 후 내용을 재작성할 예정입니다.
Flutter 버전 : Flutter 3.23.0-8.0.pre.3  
