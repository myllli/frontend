import 'package:flutter/material.dart';
import 'quest_verification_screen.dart';
import '../widgets/custom_app_bar.dart';

class QuestScreen extends StatefulWidget {
  const QuestScreen({super.key});

  @override
  State<QuestScreen> createState() => _QuestScreenState();
}

class _QuestScreenState extends State<QuestScreen> {
  // 퀘스트 완료 상태를 관리할 변수 추가
  bool isWaterQuestCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E4E2),
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildQuestSection('1단계', [
              _buildQuestItem('첫뱃지에 알려기', true),
              _buildQuestItem('손목 운동하기', true),
              _buildQuestItem(
                '물 한 잔 마시기',
                isWaterQuestCompleted, // 변수 사용
                needsVerification: !isWaterQuestCompleted, // 완료되지 않았을 때만 인증 필요
              ),
            ], true),
            _buildQuestSection('2단계', [], false),
            _buildQuestSection('3단계', [], false),
            _buildQuestSection('4단계', [], false),
            _buildQuestSection('5단계', [], false),
            _buildQuestSection('6단계', [], false),
            _buildQuestSection('7단계', [], false),
            _buildQuestSection('8단계', [], false), // 추가
            _buildQuestSection('9단계', [], false), // 추가
            _buildQuestSection('10단계', [], false), // 추가
            const SizedBox(height: 16), // 하단 여백 추가
          ],
        ),
      ),
    );
  }

  Widget _buildQuestSection(
    String title,
    List<Widget> quests,
    bool isUnlocked,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ), // 8,16 -> 10,20으로 증가
      decoration: BoxDecoration(
        color: const Color(0xFF8B7E74),
        borderRadius: BorderRadius.circular(12), // 8 -> 12로 증가
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18, // 폰트 크기 증가
          ),
        ),
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        trailing: Icon(
          isUnlocked ? Icons.expand_more : Icons.lock,
          color: Colors.white,
          size: 24, // 아이콘 크기 증가
        ),
        children: isUnlocked ? quests : [],
      ),
    );
  }

  Widget _buildQuestItem(
    String title,
    bool isCompleted, {
    bool needsVerification = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ), // 16,8 -> 20,12로 증가
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16, // 폰트 크기 증가
            ),
          ),
          GestureDetector(
            onTap:
                needsVerification
                    ? () async {
                      // 인증 화면으로 이동하고 결과 받기
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuestVerificationScreen(),
                        ),
                      );
                      // 인증이 완료되면 퀘스트 상태 업데이트
                      if (result == true) {
                        completeWaterQuest();
                      }
                    }
                    : null,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ), // 12,4 -> 16,6으로 증가
              decoration: BoxDecoration(
                color:
                    isCompleted
                        ? Colors.grey
                        : (needsVerification
                            ? Colors.orange[700]
                            : Colors.transparent),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                isCompleted ? '완료' : (needsVerification ? '인증필요' : ''),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14, // 폰트 크기 증가
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 퀘스트 완료 상태를 업데이트하는 메서드 추가
  void completeWaterQuest() {
    setState(() {
      isWaterQuestCompleted = true;
    });
  }
}
