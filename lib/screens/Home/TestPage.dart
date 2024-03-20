import 'package:flutter/material.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/ReportPage/AttendanceReport.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/ReportPage/ReportData.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/API.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _RepositoryClassPageState();
}

class _RepositoryClassPageState extends State<TestPage> {
  AttendanceReport? _attendanceReport;
  List<ReportData> listReportData = [];
  void _fetchData() async {
    var temp = await API(context).getReports();
    var temp2 = await API(context)
        .getReportStudentClass(temp.first.classID, temp.first.reportID);
    setState(() {
      listReportData = temp;
      _attendanceReport = temp2;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 250,
      height: MediaQuery.of(context).size.height,
      color: Colors.pink,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const CustomText(
                message: 'Repository Class',
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryText),
            const SizedBox(
              height: 10,
            ),
            _attendanceReport != null
                ? Container(
                    child: Text(
                        '${_attendanceReport!.attendanceDetail.attendanceForm}'),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
