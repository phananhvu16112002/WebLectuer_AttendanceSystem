import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomButton.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/Class.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/FormPage/FormData.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/API.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key, required this.classes});
  final Class classes;

  @override
  State<FormPage> createState() => _RepositoryClassPageState();
}

class _RepositoryClassPageState extends State<FormPage> {
  late Class classes;
  late Future<List<FormData>> _fetchFormData;
  List<FormData> listData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    classes = widget.classes;
    _fetchData();
  }

  void _fetchData() async {
    _fetchFormData = API(context).getFormForTeacher(classes.classID);
    _fetchFormData.then((value) {
      setState(() {
        listData = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 250,
      height: MediaQuery.of(context).size.height,
      color: AppColors.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const CustomText(
                message: 'Forms',
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryText),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1.25,
                            mainAxisSpacing: 10),
                    itemCount: listData.length,
                    itemBuilder: (context, index) {
                      final form = listData[index];
                      return customForm(
                          form.formID,
                          form.radius,
                          form.latitude,
                          form.longitude,
                          form.dateOpen,
                          form.type,
                          form.startTime,
                          form.endTime);
                    })),
          ],
        ),
      ),
    );
  }
}

Widget customForm(
  String formID,
  int radius,
  double latitude,
  double longitude,
  String? dateOpen,
  int typeAttendance,
  String? startTime,
  String? endTime,
) {
  return Container(
    width: 380,
    height: 370,
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: AppColors.primaryText.withOpacity(0.1), width: 0.2),
        boxShadow: [
          BoxShadow(
              color: AppColors.primaryText.withOpacity(0.2),
              blurRadius: 2,
              offset: const Offset(0, 1))
        ]),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 280,
                    child: cusTomText('FormID: $formID', 12, FontWeight.w500,
                        AppColors.primaryText)),
                InkWell(
                    onTap: () {},
                    mouseCursor: SystemMouseCursors.click,
                    child: const Icon(Icons.more_vert))
              ],
            ),
          ),
          Divider(
            color: AppColors.primaryText.withOpacity(0.2),
            thickness: 0.5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  message: 'Radius: $radius',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryText),
              const SizedBox(
                height: 10,
              ),
              CustomText(
                  message: 'Latitude: $latitude - Longitude: $longitude',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryText),
              const SizedBox(
                height: 10,
              ),
              CustomText(
                  message: 'Date: ${dateOpen!}',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryText),
              const SizedBox(
                height: 10,
              ),
              CustomText(
                  message: typeAttendance == 1
                      ? 'Type: Scan face'
                      : 'Type: Check in class',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryText),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CustomText(
                      message: 'StartTime: ${formatTime(startTime!)}',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText),
                  const SizedBox(
                    width: 20,
                  ),
                  CustomText(
                      message: 'EndTime: ${formatTime(endTime!)}',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomText(
                  message: 'Push Notification to everyone: ON',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryText),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: CustomButton(
                    buttonName: 'Edit',
                    backgroundColorButton:
                        AppColors.primaryButton.withOpacity(0.7),
                    borderColor: Colors.white,
                    textColor: Colors.white,
                    function: () {},
                    height: 30,
                    width: 185,
                    fontSize: 12,
                    colorShadow: Colors.transparent,
                    borderRadius: 5),
              )
            ],
          )
        ],
      ),
    ),
  );
}

String formatDate(String? date) {
  if (date != null || date != '') {
    DateTime serverDateTime = DateTime.parse(date!).toLocal();
    String formattedDate = DateFormat('MMMM d, y').format(serverDateTime);
    return formattedDate;
  }
  return '';
}

String formatTime(String? time) {
  if (time != null || time != ""){
    DateTime serverDateTime = DateTime.parse(time!).toLocal();
    String formattedTime = DateFormat("HH:mm:ss a").format(serverDateTime);
    return formattedTime;
  }
  return "";
}

Widget cusTomText(
    String message, double fontSize, FontWeight fontWeight, Color color) {
  return Text(message,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
          fontSize: fontSize, fontWeight: fontWeight, color: color));
}
