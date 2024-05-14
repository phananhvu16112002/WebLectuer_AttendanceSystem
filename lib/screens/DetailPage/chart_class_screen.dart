// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/ChartPage/chart_data.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/Class.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/DetailPage/ClassModel.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/API.dart';

class ChartClassScreen extends StatefulWidget {
  const ChartClassScreen({Key? key, this.classes}) : super(key: key);
  final Class? classes;

  @override
  State<ChartClassScreen> createState() => _ChartClassScreenState();
}

enum ChartType { column, pie }

class _ChartClassScreenState extends State<ChartClassScreen> {
  late ChartType _currentChartType;
  late Future<ProgressModel?> _fetchProgress;
  int progressPass = 0;
  int progressWarning = 0;
  int progressBan = 0;
  int progressPresent = 0;
  int progressLate = 0;
  int progressAbsent = 0;
  int total = 0;
  int pass = 0;
  int warning = 0;
  int ban = 0;

  List<ChartData> chartData = <ChartData>[];
  List<PieData> pieData = [];

  @override
  void initState() {
    super.initState();
    _currentChartType = ChartType.column;
    fetchData();
  }

  void fetchData() async {
    _fetchProgress = API(context).getDataChart(widget.classes?.classID ?? '');
    _fetchProgress.then((value) {
      setState(() {
        pass = value?.pass ?? 0;
        ban = value?.ban ?? 0;
        warning = value?.warning ?? 0;
        total = value?.total ?? 0;
        progressPass = value?.progressPass ?? 0;
        progressBan = value?.progressBan ?? 0;
        progressWarning = value?.progressWarning ?? 0;
        chartData = value?.groupBarCharts?.map((groupBarChart) {
              return ChartData(
                x: groupBarChart.label ?? '',
                y: double.parse(groupBarChart.totalPresent.toString()), // y
                y1: double.parse(groupBarChart.totalLate.toString()), // y1
                y2: double.parse(groupBarChart.totalAbsent.toString()), // y2
              );
            }).toList() ??
            [];
        pieData = [
          PieData(label: 'Pass', percent: value?.progressPass?.toDouble() ?? 0),
          PieData(label: 'Ban', percent: value?.progressBan?.toDouble() ?? 0),
          PieData(
              label: 'Warning',
              percent: value?.progressWarning?.toDouble() ?? 0),
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 250,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const CustomText(
              message: 'Chart',
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryText,
            ),
            const SizedBox(
              height: 20,
            ),
            _buildChart(),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _toggleChartType,
              child: Text(
                _currentChartType == ChartType.column
                    ? 'Switch to Pie Chart'
                    : 'Switch to Column Chart',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    switch (_currentChartType) {
      case ChartType.column:
        return _buildColumnChart();
      case ChartType.pie:
        return _buildPieChart();
    }
  }

  Widget _buildColumnChart() {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 250,
          // height: 130,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: customBoxInformation(
                    'All', 'assets/icons/student.png', total, ChartType.column),
              ),
              const SizedBox(
                width: 40,
              ), // Show ben duoi theo class
              Expanded(
                child: customBoxInformation(
                    'Pass', 'assets/icons/present.png', pass, ChartType.column),
              ),
              const SizedBox(
                width: 40,
              ),
              Expanded(
                child: customBoxInformation(
                    'Ban', 'assets/icons/absent.png', ban, ChartType.column),
              ),
              const SizedBox(
                width: 40,
              ),
              Expanded(
                child: customBoxInformation('Warning',
                    'assets/icons/pending.png', warning, ChartType.column),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SfCartesianChart(
          onAxisLabelTapped: (axisLabelTapArgs) {},
          selectionGesture: ActivationMode.singleTap,
          primaryXAxis: CategoryAxis(
            minimum: 0,
            maximum: double.parse(chartData.length.toString()) -
                1, //totol length group tra ve
            labelRotation: 20,
            majorGridLines: const MajorGridLines(width: 0),
          ),
          primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: double.parse(total.toString()),
            axisLine: const AxisLine(width: 0),
            majorGridLines: const MajorGridLines(width: 1),
          ),
          plotAreaBorderWidth: 1,
          trackballBehavior: TrackballBehavior(
            enable: true,
            shouldAlwaysShow: true,
            tooltipSettings: const InteractiveTooltip(enable: true),
          ),
          legend: const Legend(isVisible: true, isResponsive: true),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <CartesianSeries>[
            ColumnSeries<ChartData, String>(
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelAlignment: ChartDataLabelAlignment.top,
                labelPosition: ChartDataLabelPosition.inside,
                textStyle: TextStyle(fontSize: 10, color: Colors.white),
              ),
              name: 'Present',
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y ?? 0,
              color: Colors.green,
            ),
            ColumnSeries<ChartData, String>(
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelAlignment: ChartDataLabelAlignment.top,
                labelPosition: ChartDataLabelPosition.inside,
                textStyle: TextStyle(fontSize: 10, color: Colors.white),
              ),
              name: 'Late',
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y1 ?? 0,
              color: Colors.orange,
            ),
            ColumnSeries<ChartData, String>(
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  labelAlignment: ChartDataLabelAlignment.top,
                  labelPosition: ChartDataLabelPosition.inside,
                  textStyle: TextStyle(fontSize: 10, color: Colors.white),
                ),
                name: 'Absent',
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y2 ?? 0,
                color: Colors.red),
          ],
        ),
      ],
    );
  }

  Widget _buildPieChart() {
    return Container(
      width: MediaQuery.of(context).size.width - 250,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 250,
            // height: 130,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: customBoxInformation('Pass',
                      'assets/icons/present.png', progressPass, ChartType.pie),
                ),
                const SizedBox(
                  width: 40,
                ),
                Expanded(
                  child: customBoxInformation(
                      'Warning',
                      'assets/icons/pending.png',
                      progressWarning,
                      ChartType.pie),
                ),
                const SizedBox(
                  width: 40,
                ),
                Expanded(
                  child: customBoxInformation('Ban', 'assets/icons/absent.png',
                      progressBan, ChartType.pie),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SfCircularChart(
            legend: const Legend(
              isVisible: true,
              position: LegendPosition.right,
              textStyle: TextStyle(fontSize: 12),
            ),
            series: <CircularSeries>[
              PieSeries<PieData, String>(
                dataSource: pieData,
                xValueMapper: (PieData data, _) => data.label,
                yValueMapper: (PieData data, _) => data.percent,
                dataLabelSettings: const DataLabelSettings(
                    isVisible: true, textStyle: TextStyle(color: Colors.white)),
                dataLabelMapper: (PieData data, _) =>
                    ' ${data.percent?.toStringAsFixed(2)}%',
                pointColorMapper: (PieData data, _) {
                  switch (data.label) {
                    case 'Pass':
                      return Colors.green;
                    case 'Ban':
                      return Colors.red;
                    case 'Warning':
                      return Colors.orange;
                    default:
                      return Colors.grey;
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _toggleChartType() {
    setState(() {
      _currentChartType = _currentChartType == ChartType.column
          ? ChartType.pie
          : ChartType.column;
    });
  }

  Widget customBoxInformation(
      String title, String imagePath, int count, ChartType chartType) {
    return InkWell(
      onTap: () {},
      mouseCursor: SystemMouseCursors.click,
      child: Container(
        width: 200,
        height: 91,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: const [
              BoxShadow(
                  color: AppColors.secondaryText,
                  blurRadius: 2,
                  offset: Offset(0, 2))
            ],
            border: Border.all(color: Colors.white)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      message: title,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.colorInformation),
                  CustomText(
                      message:
                          '$count ${chartType == ChartType.column ? '' : '%'}',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.colorNumberInformation),
                  const CustomText(
                      message: 'Students',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryText)
                ],
              ),
              Image.asset(
                imagePath,
                width: 60,
                height: 60,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleXValueTap(String xValue) {
    print('Tapped on label: $xValue');
  }
}

String getTitle(String title) {
  if (title == 'All') {
    return 'All';
  } else if (title == 'Presents') {
    return 'Presents';
  } else if (title == 'Late') {
    return 'Late';
  } else {
    return 'Absents';
  }
}

class ChartData {
  final String? x;
  final double? y;
  final double? y1;
  final double? y2;
  ChartData({
    this.x,
    this.y,
    this.y1,
    this.y2,
  });
}

class PieData {
  String? label;
  double? percent;
  PieData({
    this.label,
    this.percent,
  });
}
