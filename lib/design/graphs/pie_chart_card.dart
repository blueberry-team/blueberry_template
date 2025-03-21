import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/// 파이 차트를 표시하는 카드 컴포넌트
class PieChartCard extends StatelessWidget {
  /// 카드 제목
  final String title;

  /// 파이 차트에 표시할 섹션 데이터
  final List<PieChartSectionData> sections;

  /// PieChartCard 생성자
  const PieChartCard({super.key, required this.title, required this.sections});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: sections,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
