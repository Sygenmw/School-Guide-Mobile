import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:school_guide/services/automated_email_service.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:school_guide/views/widgets/custom_dialog.dart';
import 'package:school_guide/views/widgets/custom_form_field.dart';
import 'package:school_guide/views/widgets/custom_snackbar.dart';
import 'package:school_guide/views/widgets/custom_text.dart';
import 'package:school_guide/views/widgets/top_text_widget.dart';
import 'package:school_guide/style/app_styles.dart';

class AdvertiseBusiness extends StatefulWidget {
  const AdvertiseBusiness({super.key});

  @override
  State<AdvertiseBusiness> createState() => _AdvertiseBusinessState();
}

class _AdvertiseBusinessState extends State<AdvertiseBusiness> {
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
          CustomFormField(controller: emailController, hintText: 'Email address', keyboardType: TextInputType.emailAddress, labelText: 'Email address'),
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
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Container(
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
                    String br = '<br/>';
                    String message =
                        'Dear Sir/Madam,$br$br Thank you for choosing School Guide.$br$br You have applied to have the item with the following description to be advertised on the School Guide Platform:$br$br ${descController.text.trim()}$br$br For any inquiries, please contact us on this same email address or on our mobile phone number +265 880 01 26 74.$br$br Best Regards.';
                    String userDetails =
                        "${nameController.text.trim()} sent you an email requesting to have an advert on your platform!${br}Here are the details${br}Name:        ${nameController.text.trim()}${br}Email:       ${emailController.text.trim()}${br}Phone:       ${phoneController.text.trim()}{$br}ADVERT DESCRIPTION$br ${descController.text.trim()}$br$br Best Regards${br}School Guide Mobile";
                    if (emailController.text.trim().isEmpty && nameController.text.trim().isEmpty && phoneController.text.trim().isEmpty && descController.text.trim().isEmpty) {
                      // showDialog
                      CustomSnackBar.showSnackBar(message: 'One or more fields look empty', title: 'Error!', color: AppColors.errorColor);
                    } else {
                      HapticFeedback.vibrate();
                      CustomDialog.showCustomDialog();
                      EmailService.sendEmail(email: 'info@sygen.com', message: userDetails, subject: 'APPLICATION FOR ADVERTISEMENT');
                      EmailService.sendEmail(email: emailController.text.trim(), message: message, subject: 'APPLICATION FOR ADVERTISEMENT');
                      Get.back();
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
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 4),
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
