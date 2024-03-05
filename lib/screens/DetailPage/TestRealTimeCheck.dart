import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/AttendanceSummary.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/StudentAttendance.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/socketServer_data_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/API.dart';

class TestRealTimeCheck extends StatefulWidget {
  const TestRealTimeCheck({Key? key}) : super(key: key);

  @override
  State<TestRealTimeCheck> createState() => _RealtimeCheckAttendanceState();
}

class _RealtimeCheckAttendanceState extends State<TestRealTimeCheck> {
  TextEditingController searchInDashboardController = TextEditingController();
  late AttendanceSummary attendanceSummary;
  int all = 0;
  int present = 0;
  int absent = 0;
  int late = 0;
  late Future<AttendanceSummary> fetchData;

  @override
  void initState() {
    super.initState();

    fetchData = API().getAttendanceSummary();
    fetchData.then((attendanceSummary) {
      all = attendanceSummary.all;
      present = attendanceSummary.present;
      absent = attendanceSummary.absent;
      late = attendanceSummary.late;
    });
    Future.delayed(Duration.zero, () {
      var socketServerProvider =
          Provider.of<SocketServerProvider>(context, listen: false);
      socketServerProvider.connectToSocketServer('5202111_09_t000');
      socketServerProvider.getAttendanceDetail();
      socketServerProvider.attendanceStream.listen((data) {
        updateData(data);
      });
    });
  }

  void updateData(dynamic data) {
    String studentID = data['studentDetail'];
    print('studentID: $studentID');

    for (int i = 0; i < attendanceSummary.data.length; i++) {
      if (studentID.contains(attendanceSummary.data[i].studentDetail)) {
        if (data['result'].toString() == '1') {
          setState(() {
            absent = absent - 1;
            present = present + 1;
            attendanceSummary.data[i].result = data['result'];
          });
        } else if (data['result'].toString() == '0.5') {
          setState(() {
            late = late + 1;
            absent = absent - 1;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 250,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: FutureBuilder(
          future: fetchData,
          builder: (context, AsyncSnapshot<AttendanceSummary> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              attendanceSummary = snapshot.data!;
              return Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('All: ${all}'),
                    Text('Present: ${present}'),
                    Text('Absent: ${absent}'),
                    Text('Late: ${late}'),
                    SizedBox(height: 20),
                    AttendanceDataTable(data: attendanceSummary.data),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class AttendanceDataTable extends StatelessWidget {
  final List<StudentAttendance> data;

  AttendanceDataTable({required this.data});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Student Detail')),
        DataColumn(label: Text('Result')),
        DataColumn(label: Text('Date Attended')),
      ],
      rows: data
          .map(
            (student) => DataRow(cells: [
              DataCell(Text(student.studentDetail)),
              DataCell(Text(student.result.toString())),
              DataCell(Text(student.dateAttendanced.toString())),
            ]),
          )
          .toList(),
    );
  }
}
