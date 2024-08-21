import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomButton.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomRichText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/main.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/AttendanceForm.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/Class.dart';
import 'package:weblectuer_attendancesystem_nodejs/models/Main/FormPage/FormData.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/activate_form_data_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/edit_attendance_form_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/provider/selected_page_provider.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/CreateAttendanceForm.dart';
import 'package:weblectuer_attendancesystem_nodejs/screens/DetailPage/edit_attendance_form.dart';
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
    _fetchFormData = API(context).getFormForTeacher(classes.classID!);
    _fetchFormData.then((value) {
      setState(() {
        listData = value;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedPage = Provider.of<SelectedPageProvider>(context);
    final editAttendanceFormProvider =
        Provider.of<EditAttendanceFormProvider>(context);
    final activateFormProvider = Provider.of<ActivateFormDataProvider>(context);
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
                      return _customBox(form, selectedPage,
                          editAttendanceFormProvider, activateFormProvider);
                    })),
          ],
        ),
      ),
    );
  }

  String getTypeForm(int type) {
    if (type == 0) {
      return 'Scan face';
    } else if (type == 1) {
      return 'Check in class';
    }
    return 'Scan QR';
  }

  Container _customBox(
      FormData form,
      SelectedPageProvider selectedPageProvider,
      EditAttendanceFormProvider editAttendanceFormProvider,
      ActivateFormDataProvider activateFormDataProvider) {
    return Container(
      width: 380,
      // height: 370,
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
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  // width: 340,
                  child: Center(
                    child: customRichText(
                        title: form.periodDateTime != 'null' ? 'Date Open: ' : '',
                        message: form.periodDateTime != 'null' &&
                                form.periodDateTime != null &&
                                form.periodDateTime != ""
                            ? formatDate(form.periodDateTime ?? '')
                            : 'undefined',
                        fontWeightTitle: FontWeight.w600,
                        fontWeightMessage: FontWeight.w400,
                        colorText: AppColors.primaryText,
                        fontSize: 15,
                        colorTextMessage: AppColors.primaryText),
                  ),
                ),
              ],
            ),
            Divider(
              color: AppColors.primaryText.withOpacity(0.2),
              thickness: 0.5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customRichText(
                          title: 'Type: ',
                          message: getTypeForm(form.type ?? 0),
                          fontWeightTitle: FontWeight.w600,
                          fontWeightMessage: FontWeight.w400,
                          colorText: AppColors.primaryText,
                          fontSize: 15,
                          colorTextMessage: AppColors.primaryText),
                      const SizedBox(
                        height: 15,
                      ),
                      customRichText(
                          title: 'Radius: ',
                          message: form.radius.toString(),
                          fontWeightTitle: FontWeight.w600,
                          fontWeightMessage: FontWeight.w400,
                          colorText: AppColors.primaryText,
                          fontSize: 15,
                          colorTextMessage: AppColors.primaryText),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          customRichText(
                              title: 'Latitude: ',
                              message: form.latitude.toString(),
                              fontWeightTitle: FontWeight.w600,
                              fontWeightMessage: FontWeight.w400,
                              colorText: AppColors.primaryText,
                              fontSize: 15,
                              colorTextMessage: AppColors.primaryText),
                          const SizedBox(
                            width: 20,
                          ),
                          customRichText(
                              title: 'Longitude: ',
                              message: form.longitude.toString(),
                              fontWeightTitle: FontWeight.w600,
                              fontWeightMessage: FontWeight.w400,
                              colorText: AppColors.primaryText,
                              fontSize: 15,
                              colorTextMessage: AppColors.primaryText),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          customRichText(
                              title: 'StartTime: ',
                              message: formatTime(form.startTime),
                              fontWeightTitle: FontWeight.w600,
                              fontWeightMessage: FontWeight.w400,
                              colorText: AppColors.primaryText,
                              fontSize: 15,
                              colorTextMessage: AppColors.primaryText),
                          const SizedBox(
                            width: 20,
                          ),
                          customRichText(
                              title: 'EndTime: ',
                              message: formatTime(form.endTime),
                              fontWeightTitle: FontWeight.w600,
                              fontWeightMessage: FontWeight.w400,
                              colorText: AppColors.primaryText,
                              fontSize: 15,
                              colorTextMessage: AppColors.primaryText),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const customRichText(
                          title: 'Push notification to everyone: ',
                          message: 'ON',
                          fontWeightTitle: FontWeight.w600,
                          fontWeightMessage: FontWeight.w400,
                          colorText: AppColors.primaryText,
                          fontSize: 15,
                          colorTextMessage: AppColors.primaryText),
                    ],
                  ),
                  Column(
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomButton(
                                  buttonName:
                                      form.status ? "Deactivate" : 'Activate',
                                  backgroundColorButton: form.status
                                      ? AppColors.secondaryText
                                      : AppColors.primaryButton
                                          .withOpacity(0.7),
                                  borderColor: Colors.white,
                                  textColor: Colors.white,
                                  function: form.status
                                      ? () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Confirm Deactivation'),
                                                content: Text(
                                                    'Are you sure you want to deactivate this form?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('Cancel'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text('Deactivate'),
                                                    onPressed: () async {
                                                      bool checkEdit = await API(
                                                              context)
                                                          .editStatusForm(
                                                              classes.classID ??
                                                                  '',
                                                              form.formID ?? '',
                                                              false);
                                                      if (checkEdit) {
                                                        Navigator.pop(context);
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title:
                                                                  Text('Form'),
                                                              content: Text(
                                                                  'Deactivate successfully'),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  child: Text(
                                                                      'OK'),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      form.status =
                                                                          false;
                                                                    });
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      } else {
                                                        Navigator.of(context)
                                                            .pop();
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title:
                                                                  Text('Form'),
                                                              content: Text(
                                                                  'Deactivate fail'),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  child: Text(
                                                                      'OK'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      : () {
                                          activateFormDataProvider
                                              .setFormId(form.formID ?? '');
                                          activateFormDataProvider
                                              .setClassData(classes);
                                          selectedPageProvider
                                              .setCheckEditAttendanceForm(
                                                  false);
                                          selectedPageProvider
                                              .setCheckAttendanceForm(true);
                                          selectedPageProvider
                                              .setCheckHome(false);
                                          selectedPageProvider
                                              .setCheckNoti(false);
                                          selectedPageProvider
                                              .setCheckReport(false);
                                          selectedPageProvider
                                              .setCheckForm(false);
                                        },
                                  height: 40,
                                  width: null,
                                  fontSize: 12,
                                  colorShadow: Colors.transparent,
                                  borderRadius: 5),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: CustomButton(
                                  buttonName: 'Edit',
                                  backgroundColorButton: form.status == false
                                      ? AppColors.secondaryText
                                      : AppColors.primaryButton
                                          .withOpacity(0.7),
                                  borderColor: Colors.white,
                                  textColor: Colors.white,
                                  function: form.status == false
                                      ? null
                                      : () {
                                          selectedPageProvider
                                              .setCheckEditAttendanceForm(true);
                                          selectedPageProvider
                                              .setCheckAttendanceForm(false);
                                          selectedPageProvider
                                              .setCheckHome(false);
                                          selectedPageProvider
                                              .setCheckNoti(false);
                                          selectedPageProvider
                                              .setCheckReport(false);
                                          selectedPageProvider
                                              .setCheckForm(false);
                                          editAttendanceFormProvider
                                              .setAttendanceForm(AttendanceForm(
                                                  formID: form.formID ?? '',
                                                  classes:
                                                      classes.classID ?? '',
                                                  startTime: form.startTime,
                                                  endTime: form.endTime,
                                                  dateOpen: form.dateOpen,
                                                  status: form.status,
                                                  typeAttendance:
                                                      form.type ?? 0,
                                                  location: '',
                                                  latitude: form.latitude ?? 0,
                                                  longtitude:
                                                      form.longitude ?? 0,
                                                  radius: double.parse(
                                                      form.radius.toString())));
                                        },
                                  height: 40,
                                  width: null,
                                  fontSize: 12,
                                  colorShadow: Colors.transparent,
                                  borderRadius: 5),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

String formatDate(String? date) {
  if (date != null && date != "" && date != 'null') {
    DateTime serverDateTime = DateTime.parse(date);
    String formattedDate = DateFormat('MMMM d, y').format(serverDateTime);
    return formattedDate;
  }
  return '';
}

String formatTime(String? time) {
  if (time != null && time != "" && time != 'null') {
    DateTime serverDateTime = DateTime.parse(time!);
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
