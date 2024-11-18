## PALINK 

**Role-Playing System for Improving Friend Relationships Using LLM**

A lack of self-expression becomes most apparent in situations where one needs to refuse a request.

PALINK is a system designed to enhance self-expression by allowing users to practice communication skills through simulated conversations with a virtual friend, focusing on the theme of "refusing requests."

![014](https://github.com/aengzu/palink_v2/assets/102356873/dbaf5178-7f2d-4fe7-8434-204332f6fef0)

## Background

![009](https://github.com/aengzu/palink_v2/assets/102356873/129ba3de-a3a2-490d-889b-e87813a67f8c)

## Our GOAL
**[Goal]**
The goal of this study is to develop a role-playing-based interpersonal practice system aimed at improving interpersonal relationship issues and to validate its effectiveness.

**[Key Elements for Achieving the Goal]**
1. Conversation simulation with a virtual friend
2. Practice of communication techniques
3. Real-time conversation evaluation and guidance

![012](https://github.com/aengzu/palink_v2/assets/102356873/efb257bf-a165-499e-93a2-efa2f31e5ca2)
![013](https://github.com/aengzu/palink_v2/assets/102356873/220aaf0a-7496-4fa4-a536-880f27e1ed0d)


## Content
**1. Role-Playing Therapy Technique**
Role-playing therapy involves recreating interpersonal scenarios to experience therapeutic effects. Leveraging this technique, users engage in role-playing with AI characters in specific situations, such as practicing refusals.

**2. Positive Mindset Formation**
Before loading screens or the start of a conversation, the system displays encouraging phrases to help users build confidence and foster a positive mindset.

**3. Quest-Based Learning**
Users receive guidance through quests, allowing them to follow structured steps to learn effective refusal techniques. Quests are detected by prompts designed to identify refusal categories, which are then processed in the code to track quest progress.

**4. Tip Assistance and Feedback**
If users struggle to find an appropriate response during a conversation, they can use a "Tip" button to receive textual guidance. Once the conversation ends, the dialogue history is analyzed using a prompt, and comprehensive final feedback is provided.
![015](https://github.com/aengzu/palink_v2/assets/102356873/a4d9b79d-6694-4d0c-b440-03f87384969f)

## Stack
![016](https://github.com/aengzu/palink_v2/assets/102356873/1873440f-7c14-4ba1-a122-302ced4330fb)

## Feedback
![018](https://github.com/aengzu/palink_v2/assets/102356873/bbdc07bd-149b-48a2-9b37-e93ce682c4b0)

## 핵심 Flow
- Flow 1 : 캐릭터 선택 → 로딩 중(대화창 및 초기 메시지 생성) → 대화창 및 초기 메시지 생성 완료
![채팅방생성 drawio (1)](https://github.com/user-attachments/assets/4b8dd0c1-a31e-4329-9786-8ff25b38013a)


## SHOWCASES
- 전체 데모 영상


https://github.com/user-attachments/assets/14608270-134c-464f-a5c8-2b1af5091ead





- 4개의 다른 캐릭터 페르소나
  - 미연, 진혁, 세진, 현아
  - We have adjusted the prompts to create four different characters with distinct personas. This allows users to practice refusal scenarios tailored to each character type.
<p float="left">
  <img src="https://github.com/user-attachments/assets/c89d9da7-7120-4b44-b03a-f664517c5825" width="200" />
  <img src="https://github.com/user-attachments/assets/9970cf03-0e97-48fd-a942-94bec70048b1" width="200" /> 
  <img src="https://github.com/user-attachments/assets/1a064fe8-aeee-4b5f-9ae9-7fcde74ca7e1" width="200" /> 
  <img src="https://github.com/user-attachments/assets/8e6fa0c2-1683-4ba4-bbef-0f7d6551cc13" width="200" /> 
</p>

- 팁 기능
<p float="left">
  <img src="https://github.com/user-attachments/assets/ec728301-46c7-492d-8837-b9317ef3ae92" width="200" />
  <img src="https://github.com/user-attachments/assets/136bf50d-1130-41a6-b4ed-0042a44e1148" width="200" /> 
</p>

- 퀘스트 제공 및 탐지
(퀘스트 달성 시 토스트 메시지 (퀘스트 3 ‘상대방이 처한 상황 파악하기’가 달성된 모습))

https://github.com/user-attachments/assets/2b7a9242-dcd6-48e5-8ebe-93d1f78053e8


## Deploy
- 웹앱 배포 : Amazon S3 (CloudFront 와 연동)
- DB 서버 배포 : Amazon EC2
- DB : Amazon RDS

Flutter 웹앱으로 배포를 하였으나, AI API 비용상의 문제로 링크 비공개 처리하였습니다 🥲


## Getting Started
My flutter version : Flutter 3.23.0-8.0.pre.3


