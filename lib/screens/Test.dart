import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/base/CustomText.dart';
import 'package:weblectuer_attendancesystem_nodejs/common/colors/color.dart';
import 'package:weblectuer_attendancesystem_nodejs/services/API.dart';

class TestApp extends StatefulWidget {
  const TestApp({super.key});

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String textDesciption =
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged';
    return Scaffold(
        body: Center(
      child: Container(
        height: MediaQuery.of(context).size.height - 100,
        width: MediaQuery.of(context).size.width - 350,
        color: Colors.amber,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width - 100,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  historyDetailReports(textDesciption),
                  historyFeedbacks(textDesciption),
                ],
              ),
            ),
            Container(
              height: 200,
              width: 600,
              color: Colors.white,
              child: Text('${MediaQuery.of(context).size.width - 100}'),
            )
          ],
        ),
      ),
    ));
  }

  Container historyDetailReports(String textDesciption) {
    return Container(
      height: 200,
      width: 400,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                      message: 'History Reports',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText),
                  Container(
                    height: 20,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: const Center(
                        child: CustomText(
                            message: 'ID: 1',
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: AppColors.primaryText)),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              customRichText('Topic12321321:', 12, FontWeight.normal,
                  AppColors.primaryText, 'Topic: '),
              SizedBox(
                height: 10,
              ),
              customRichText(
                  'aasdasdlksajdaslkjdlaskjdklsajdlkjadasdasdasdasdasdslcnzxcmnaskjhdsjlkjj',
                  12,
                  FontWeight.normal,
                  AppColors.primaryText,
                  'Problem: '),
              SizedBox(
                height: 10,
              ),
              customRichText('Status:', 12, FontWeight.normal,
                  AppColors.primaryText, 'Status: '),
              SizedBox(
                height: 10,
              ),
              customRichText('Created:', 12, FontWeight.normal,
                  AppColors.primaryText, 'Created: '),
              SizedBox(
                height: 10,
              ),
              customRichText(textDesciption, 12, FontWeight.normal,
                  AppColors.primaryText, 'Message: '),
            ],
          ),
        ),
      ),
    );
  }

  Container historyFeedbacks(String textDesciption) {
    return Container(
      height: 200,
      width: 400,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                      message: 'History Feedbacks',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText),
                  Container(
                    height: 20,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: const Center(
                        child: CustomText(
                            message: 'ID: 1',
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: AppColors.primaryText)),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              customRichText('Topic12321321:', 12, FontWeight.normal,
                  AppColors.primaryText, 'Topic: '),
              SizedBox(
                height: 10,
              ),
              customRichText('Status:', 12, FontWeight.normal,
                  AppColors.primaryText, 'Status: '),
              SizedBox(
                height: 10,
              ),
              customRichText('Created:', 12, FontWeight.normal,
                  AppColors.primaryText, 'Created: '),
              SizedBox(
                height: 10,
              ),
              customRichText(textDesciption, 12, FontWeight.normal,
                  AppColors.primaryText, 'Message: '),
            ],
          ),
        ),
      ),
    );
  }

  Widget customRichText(String message, double fontSize, FontWeight fontWeight,
      Color color, String title) {
    return Text.rich(
      TextSpan(
        text: title,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: AppColors.primaryText,
        ),
        children: [
          TextSpan(
            text: message,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      maxLines: null,
    );
  }
}
