import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:school_guide/views/widgets/custom_form_field.dart';
import 'package:school_guide/views/widgets/top_text_widget.dart';
import 'package:flutter/cupertino.dart';

class BecomeATutor extends StatefulWidget {
  BecomeATutor({super.key});

  @override
  State<BecomeATutor> createState() => _BecomeATutorState();
}

class _BecomeATutorState extends State<BecomeATutor> {
  var controller = PageController(keepPage: true, initialPage: 1);

  String date = '';
  // Gender
  var selectedGender;
  List<String> genders = ["Male", "Female"];
  var selectedDistrict;
  List<String> districts = ["Blantyre", "Chiradzulu", "Balaka", "Zomba", "Mzuzu", "Lilongwe"];

  // curriculum
  bool igsceChoice = false;
  bool manebChoice = false;

  // subjects
  bool physics = false;
  bool chemistry = false;
  bool biology = false;
  bool math = false;
  bool ict = false;
  bool geography = false;
  bool history = false;
  bool english = false;
  bool business = false;
  bool economics = false;
  bool accounting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomBody(
        text: 'Become a tutor',
        needsHeader: true,
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Card(
                    margin: const EdgeInsets.only(top: 8, right: 8, bottom: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(AppImages.home, height: 30),
                    ),
                  )),
              Expanded(
                flex: 5,
                child: Text(
                  'A tutor\'s role is to offer Video/Educational content',
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          TopBlackText(text: 'Please, fill in the form below, to register into being a tutor.'),
          SizedBox(height: 6),
          CustomFormField(controller: TextEditingController(), hintText: 'enter full name', keyboardType: TextInputType.name, labelText: 'full name'),
          CustomFormField(controller: TextEditingController(), hintText: 'phone number', keyboardType: TextInputType.phone, labelText: 'phone number'),
          CustomFormField(controller: TextEditingController(), hintText: 'email address', keyboardType: TextInputType.emailAddress, labelText: 'email address'),
          SizedBox(height: 5),
          Container(
            height: 40,
            decoration: BoxDecoration(color: AppColors.grey, borderRadius: BorderRadius.circular(8)),
            child: Padding(
                padding: const EdgeInsets.only(top: 0.0, left: 10, right: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'Gender',
                      ),
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        iconSize: 30,
                        decoration: const InputDecoration(enabledBorder: InputBorder.none),
                        hint: const Text('select gender'),
                        value: selectedGender,
                        items: genders.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value as String;
                          });
                        },
                      ),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(color: AppColors.grey, borderRadius: BorderRadius.circular(8)),
            child: Padding(
                padding: const EdgeInsets.only(top: 0.0, left: 10, right: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'Location',
                      ),
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        iconSize: 30,
                        decoration: const InputDecoration(enabledBorder: InputBorder.none),
                        hint: const Text('Location'),
                        value: selectedDistrict,
                        items: districts.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDistrict = value as String;
                          });
                        },
                      ),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Get.bottomSheet(
                Container(
                  height: 200,
                  color: Colors.white,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime(2002),
                    // use24hFormat: true,
                    minimumDate: DateTime(1955),
                    maximumDate: DateTime(2005),
                    onDateTimeChanged: (DateTime newDateTime) {
                      setState(() {
                        date = newDateTime.toLocal().toString().substring(0, 10);
                      });
                    },
                  ),
                ),
              );
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(color: AppColors.grey, borderRadius: BorderRadius.circular(8)),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(date.isEmpty ? 'Birthdate' : date),
                  )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 150,
            decoration: BoxDecoration(color: AppColors.grey, borderRadius: BorderRadius.circular(8)),
            child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TopBlackText(text: 'Curriculum'),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TopBlackText(text: 'IGCSE'),
                          Checkbox(
                              splashRadius: 8,
                              value: igsceChoice,
                              onChanged: (value) {
                                setState(() {
                                  igsceChoice = value as bool;
                                });
                              })
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TopBlackText(text: 'MANEB'),
                            Checkbox(
                                splashRadius: 8,
                                value: manebChoice,
                                onChanged: (value) {
                                  setState(() {
                                    manebChoice = value as bool;
                                  });
                                })
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          SizedBox(height: 10),
          Container(
            color: AppColors.grey,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 2,
                          ),
                          TopBlackText(text: 'Subjects'),
                        ],
                      ),
                    )),
                Container(
                  height: 220,
                  child: PageView.builder(
                      controller: controller,
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 120,
                                height: 60,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                child: InteractiveViewer(
                                  panEnabled: false,
                                  boundaryMargin: const EdgeInsets.all(2),
                                  minScale: 0.5,
                                  maxScale: 20,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            TopBlackText(text: 'Physical science'),
                                            Checkbox(
                                                splashRadius: 8,
                                                value: physics,
                                                onChanged: (value) {
                                                  setState(() {
                                                    physics = value as bool;
                                                  });
                                                })
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 4.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              TopBlackText(text: 'Chemistry'),
                                              Checkbox(
                                                  splashRadius: 8,
                                                  value: chemistry,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      chemistry = value as bool;
                                                    });
                                                  })
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            TopBlackText(text: 'Biology'),
                                            Checkbox(
                                                splashRadius: 8,
                                                value: biology,
                                                onChanged: (value) {
                                                  setState(() {
                                                    biology = value as bool;
                                                  });
                                                })
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 4.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              TopBlackText(text: 'Mathematics'),
                                              Checkbox(
                                                  splashRadius: 8,
                                                  value: math,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      math = value as bool;
                                                    });
                                                  })
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
