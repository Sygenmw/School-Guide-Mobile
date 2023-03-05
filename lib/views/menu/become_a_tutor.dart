import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:school_guide/controllers/time_controller.dart';
import 'package:school_guide/services/automated_email_service.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:school_guide/views/widgets/custom_dialog.dart';
import 'package:school_guide/views/widgets/custom_form_field.dart';
import 'package:school_guide/views/widgets/custom_snackbar.dart';
import 'package:school_guide/views/widgets/custom_text.dart';
import 'package:school_guide/views/widgets/top_text_widget.dart';
import 'package:flutter/cupertino.dart';

class BecomeATutor extends StatefulWidget {
  BecomeATutor({super.key});

  @override
  State<BecomeATutor> createState() => _BecomeATutorState();
}

class _BecomeATutorState extends State<BecomeATutor> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String date = '';
  DateTime nDate = DateTime.now();
  // Gender
  var selectedGender;
  List<String> genders = ["Male", "Female", "Other"];
  var selectedLocation;

  List<String> location = ["Blantyre", "Zomba", "Mzuzu", "Lilongwe"];

  // curriculum
  bool igsceChoice = false;
  bool manebChoice = false;

  List<String> curriculums = ["IGCSE", "MANEB"];
  String selectedCurriculum = '';
  List<String> selectedCurriculumChoices = [];
  // subjects

  List<String> subjects = ["Physics", "Chemistry", "Biology", "Mathematics", "ICT", "Geography", "History", "English", "Business", "Economics", "Accounting"];
  String selectedSubject = '';
  List<String> selectedChoices = [];

  _buildSubjectsChoiceList() {
    List<Widget> choices = [];
    subjects.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          backgroundColor: Color.fromARGB(255, 170, 170, 170),
          label: CustomText(
            item,
            pLeft: 0,
            pTop: 0,
            pBottom: 0,
            pRight: 0,
            color: AppColors.white,
            needsIcon: false,
          ),
          selected: selectedChoices.contains(item),
          selectedColor: AppColors.primaryColor,
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item) ? selectedChoices.remove(item) : selectedChoices.add(item);
            });
            HapticFeedback.heavyImpact();
          },
        ),
      ));
    });
    return choices;
  }

  _buildCurriculumChoicesList() {
    List<Widget> choices = [];
    curriculums.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          backgroundColor: Color.fromARGB(255, 170, 170, 170),
          label: CustomText(
            item,
            pLeft: 0,
            pTop: 0,
            pBottom: 0,
            pRight: 0,
            color: AppColors.white,
            needsIcon: false,
          ),
          selected: selectedCurriculumChoices.contains(item),
          selectedColor: AppColors.primaryColor,
          onSelected: (selected) {
            setState(() {
              selectedCurriculumChoices.contains(item) ? selectedCurriculumChoices.remove(item) : selectedCurriculumChoices.add(item);
            });
            HapticFeedback.heavyImpact();
          },
        ),
      ));
    });
    return choices;
  }

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
                  'Tutors help students learn and understand curriculum based concepts and help in studying, assigenments and many more.',
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          TopBlackText(text: 'Please, fill in the form below, to register as a tutor.'),
          SizedBox(height: 6),
          CustomFormField(controller: nameController, hintText: 'Enter full name', keyboardType: TextInputType.name, labelText: 'Full name'),
          CustomFormField(controller: phoneController, hintText: 'Phone number', keyboardType: TextInputType.phone, labelText: 'Phone number'),
          CustomFormField(controller: emailController, hintText: 'Email address', keyboardType: TextInputType.emailAddress, labelText: 'Email address'),
          SizedBox(height: 5),
          SizedBox(
            height: 50,
            child: Container(
              decoration: BoxDecoration(color: AppColors.grey, borderRadius: BorderRadius.circular(8)),
              child: Padding(
                  padding: const EdgeInsets.only(top: 0.0, left: 10, right: 14),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Gender',
                        ),
                      ),
                      Expanded(
                        child: DropdownButtonFormField(
                          iconSize: 30,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                          hint: const Text(''),
                          value: selectedGender,
                          items: genders.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: TopBlackText(text: value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value as String;
                            });
                          },
                          icon: Center(
                            child: Icon(Icons.keyboard_arrow_down),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
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
                        isExpanded: false,
                        iconSize: 30,
                        decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                        ),
                        hint: const Text(''),
                        value: selectedLocation,
                        items: location.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: TopBlackText(text: value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedLocation = value as String;
                          });
                        },
                        icon: Center(
                          child: Icon(Icons.keyboard_arrow_down),
                        ),
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
                    height: 250,
                    color: Colors.transparent,
                    child: Stack(
                      children: [
                        Positioned(
                            top: 2,
                            left: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Material(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(8),
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(8),
                                    onTap: () {
                                      HapticFeedback.vibrate();
                                      Get.back();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Icon(
                                        Icons.close,
                                        size: 35,
                                        color: AppColors.primaryColor,
                                      ),
                                    )),
                              ),
                            )),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
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
                                  nDate = newDateTime;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    )),
              );
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(color: AppColors.grey, borderRadius: BorderRadius.circular(8)),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(date.isEmpty ? 'Birthdate' : TimeConversion.convertDateTime(nDate)),
                  )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(color: AppColors.grey, borderRadius: BorderRadius.circular(8)),
            child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TopBlackText(text: 'Curriculums'),
                      SizedBox(
                        height: 2,
                      ),
                      Wrap(
                        children: _buildCurriculumChoicesList(),
                      )
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
                  child: Wrap(
                    children: _buildSubjectsChoiceList(),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10),

          // button to send the values above to an email
          Container(
            height: 40,
            width: Get.size.width / 3,
            margin: const EdgeInsets.only(left: 60, right: 60),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Material(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  bool notEmpty = nameController.text.isNotEmpty &&
                      emailController.text.isNotEmpty &&
                      phoneController.text.isNotEmpty &&
                      date.isNotEmpty &&
                      selectedChoices.isNotEmpty &&
                      selectedCurriculumChoices.isNotEmpty;
                  bool notBlank = (selectedGender.toString().isNotEmpty && selectedLocation.toString().isNotEmpty);
                  if (notEmpty && notBlank) {
                    HapticFeedback.vibrate();
                    String subject = 'APPLICATION FOR A TUTORSHIP';

                    String br = '<br/>';
                    String message =
                        'Dear Sir/Madam,$br$br Thank you for choosing School Guide.$br$br You have applied to be a tutor on the School Guide Platform.$br$br The following are the subjects you can be turoring: $br$br -${selectedChoices.join('$br$br -')}$br$br .The Selected Curricula include$br$br -${selectedCurriculumChoices.join('$br$br - ')}.$br$br For any inquiries, please contact us on this same email address or on our mobile phone number +265 880 01 26 74$br$br Best Regards.';
                    String userDetails =
                        "${nameController.text.trim()} sent you an email requesting to be a tutor!${br}Here are the details${br}Name:        ${nameController.text.trim()}${br}Email:       ${emailController.text.trim()}${br}Phone:       ${phoneController.text.trim()}${br}Location:       ${selectedLocation.text.trim()}${br}Gender:       $selectedGender${br}Birthday:    $date$br${br}SUBJECTS$br- ${selectedChoices.join('$br$br - ')}$br${br}CURRICULUM(S)$br$br- ${selectedCurriculumChoices.join('$br$br - ')}$br$br Best Regards${br}School Guide Mobile";
                    // User email service
                    EmailService.sendEmail(email: emailController.text.trim(), message: message, subject: subject);
                    // Admin email service
                    EmailService.sendEmail(email: 'info@sygen.com', message: userDetails, subject: subject);
                    Get.back();
                    CustomDialog.showCustomDialog();
                  } else {
                    // show snackbar
                    CustomSnackBar.showSnackBar(message: 'One or more fields look empty', title: 'Error!', color: AppColors.errorColor);
                  }
                },
                child: Center(
                  child: CustomText(
                    'Send',
                    pLeft: 0,
                    pTop: 0,
                    pBottom: 0,
                    pRight: 0,
                    color: AppColors.white,
                    needsIcon: false,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 10),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 4),
    );
  }
}
