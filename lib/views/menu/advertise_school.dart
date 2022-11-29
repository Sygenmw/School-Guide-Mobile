import 'package:flutter/material.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:school_guide/views/widgets/custom_form_field.dart';
import 'package:school_guide/views/widgets/submit_button.dart';
import 'package:school_guide/views/widgets/top_text_widget.dart';
import 'package:school_guide/style/app_styles.dart';

class AdvertiseSchool extends StatefulWidget {
  const AdvertiseSchool({super.key});

  @override
  State<AdvertiseSchool> createState() => _AdvertiseSchoolState();
}

class _AdvertiseSchoolState extends State<AdvertiseSchool> {
  TextEditingController phoneController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController descController = TextEditingController();

  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomBody(
        text: 'Advertising request form',
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
                      child: Icon(
                        Icons.workspace_premium_outlined,
                        color: AppColors.primaryColor,
                        size: 35,
                      ),
                    ),
                  )),
              Expanded(
                flex: 5,
                child: Text(
                  'Need to advertise your business on the app? Send us details of what we can do, for you to increase exposure to the app users.',
                ),
              ),
            ],
          ),
          Divider(),
          CustomFormField(controller: nameController, hintText: 'Full name', keyboardType: TextInputType.name, labelText: 'Full name'),
          CustomFormField(controller: phoneController, hintText: 'Phone number', keyboardType: TextInputType.phone, labelText: 'Phone number'),
          CustomFormField(controller: phoneController, hintText: 'Phone number', keyboardType: TextInputType.emailAddress, labelText: 'Email address'),
          CustomDescFormField(hintText: 'Describe your banner idea', controller: descController, labelText: 'Description'),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              height: 40,
              margin: const EdgeInsets.only(top: 0, bottom: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.grey,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Checkbox(value: true, onChanged: (val) {}),
                  ),
                  Expanded(
                    flex: 4,
                    child: TopBlackText(text: 'Banner - K50,000/month'),
                  ),
                ],
              ),
            ),
          ),
          SubmitButton(
              subject: 'REQUEST TO ADVERTISE ON YOUR PLATFORM',
              body:
                  'Respected Sir. \nThe above subject in reference matters. I am ${nameController.text.trim()} and am writing you this email, requesting to advertise my business on your platform. The idea of having my banner is as follows :\n\n${descController.text.trim()}\n\nI will be glad if my advertisement request is taken into consideration at your earliest inconvenience.\nFor any other inquiries, please contact me on this same email address or on my mobile phone number : ${phoneController.text.trim()}.\n\nRegards\n${nameController.text.trim()}.',
              controllers: [nameController, emailController, descController, phoneController])
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  buildItem(value) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: 40,
        margin: const EdgeInsets.only(top: 0, bottom: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.grey,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Checkbox(value: true, onChanged: (val) {}),
            ),
            Expanded(
              flex: 4,
              child: TopBlackText(text: 'Banner - K50,000/month'),
            ),
          ],
        ),
      ),
    );
  }
}
