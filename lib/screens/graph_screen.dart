import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../design/graphs/graph_section.dart';
import '../design/graphs/line_chart_card.dart';
import '../design/graphs/bar_chart_card.dart';
import '../design/graphs/pie_chart_card.dart';
import '../theme/app_color.dart';

/// 다양한 종류의 그래프를 표시하는 화면
class GraphScreen extends StatelessWidget {
  /// GraphScreen 생성자
  const GraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('그래프')),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 16),
              GraphSection(title: '라인 차트', graphs: [_buildLineChart(context)]),
              const SizedBox(height: 16),
              GraphSection(title: '막대 차트', graphs: [_buildBarChart(context)]),
              const SizedBox(height: 16),
              GraphSection(title: '파이 차트', graphs: [_buildPieChart(context)]),
              const SizedBox(height: 16),
            ]),
          ),
        ],
      ),
    );
  }

  /// 라인 차트 위젯을 생성하는 메소드
  Widget _buildLineChart(BuildContext context) {
    final dataPoints = const [
      FlSpot(0, 3),
      FlSpot(1, 1),
      FlSpot(2, 4),
      FlSpot(3, 2),
      FlSpot(4, 5),
      FlSpot(5, 3),
    ];

    return LineChartCard(
      title: '주간 활동',
      dataPoints: dataPoints,
      lineColor: AppColor.primary,
    );
  }

  /// 막대 차트 위젯을 생성하는 메소드
  Widget _buildBarChart(BuildContext context) {
    final barGroups = [
      BarChartGroupData(
        x: 0,
        barRods: [BarChartRodData(toY: 10, color: AppColor.primary)],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [BarChartRodData(toY: 7, color: AppColor.primary)],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [BarChartRodData(toY: 12, color: AppColor.primary)],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [BarChartRodData(toY: 5, color: AppColor.primary)],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [BarChartRodData(toY: 8, color: AppColor.primary)],
      ),
    ];

    return BarChartCard(title: '월별 데이터', barGroups: barGroups);
  }

  /// 파이 차트 위젯을 생성하는 메소드
  Widget _buildPieChart(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.labelMedium;

    final sections = [
      PieChartSectionData(
        color: AppColor.primary,
        value: 30,
        title: '30%',
        radius: 50,
        titleStyle: textStyle,
      ),
      PieChartSectionData(
        color: AppColor.secondary,
        value: 40,
        title: '40%',
        radius: 50,
        titleStyle: textStyle,
      ),
      PieChartSectionData(
        color: AppColor.success,
        value: 30,
        title: '30%',
        radius: 50,
        titleStyle: textStyle,
      ),
    ];

    return PieChartCard(title: '카테고리 분포', sections: sections);
  }
}
