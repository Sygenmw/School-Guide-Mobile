// ignore_for_file: unnecessary_statements

import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:school_guide/services/automated_email_service.dart';
import 'package:school_guide/services/currency_formatter.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:school_guide/views/widgets/custom_dialog.dart';
import 'package:school_guide/views/widgets/custom_form_field.dart';
import 'package:school_guide/views/widgets/custom_snackbar.dart';
import 'package:school_guide/views/widgets/custom_text.dart';
import 'package:school_guide/views/widgets/premium_item_card.dart';
import 'package:school_guide/views/widgets/top_text_widget.dart';

class Premium extends StatefulWidget {
  const Premium({super.key});

  @override
  State<Premium> createState() => _PremiumState();
}

class _PremiumState extends State<Premium> {
  // Premium features
  // double.parse(CurrencyFormatter.format(1000, CurrencyF.kwachaSettings))

  List<Feature> features = [
    Feature(featureName: '3+ Images', featurePrice: '10000', icon: Icons.browse_gallery),
    Feature(featureName: 'School on home page', featurePrice: '15000', icon: Icons.branding_watermark),
    Feature(featureName: 'Advert on banner', featurePrice: '50000', icon: FontAwesomeIcons.adversal),
    Feature(featureName: 'Video Ad of the school', featurePrice: '50000', icon: FontAwesomeIcons.video),
    Feature(featureName: 'Map and directions to school', featurePrice: '40000', icon: FontAwesomeIcons.mapLocation),
  ];

  String selectedFeature = '';
  List<String> selectedFeaturesChoices = [];
  List<Feature> selectedFeatures = [];
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<String> featureStrings = features.map((e) => e.featureName).toList();
    _buildPremiumFeatures() {
      List<Widget> choices = [];
      featureStrings.forEach((item) {
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
            selected: selectedFeaturesChoices.contains(item),
            selectedColor: AppColors.primaryColor,
            onSelected: (selected) {
              HapticFeedback.heavyImpact();

              setState(() {
                selectedFeaturesChoices.contains(item)
                    ? {
                        features.forEach((element) {
                          if (element.featureName == item) {
                            totalAmount -= double.parse(element.featurePrice);
                            selectedFeatures.remove(element);
                          }
                        })
                      }
                    : {
                        features.forEach((element) {
                          if (element.featureName == item) {
                            totalAmount += double.parse(element.featurePrice);
                            selectedFeatures.add(element);
                          }
                        })
                      };
                selectedFeaturesChoices.contains(item) ? selectedFeaturesChoices.remove(item) : selectedFeaturesChoices.add(item);
              });
            },
          ),
        ));
      });
      return choices;
    }

    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomBody(
        text: 'Premium',
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
                  'Register for premium features including having a map to your school and many more.',
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          CustomFormField(controller: nameController, hintText: 'School/Company name', keyboardType: TextInputType.name, labelText: 'School/Company name'),
          CustomFormField(controller: emailController, hintText: 'Email', keyboardType: TextInputType.emailAddress, labelText: 'Email'),
          CustomFormField(controller: phoneController, hintText: 'Phone number', keyboardType: TextInputType.phone, labelText: 'Phone number'),
          SizedBox(height: 6),
          TopBlackText(text: 'Select premium features.'),
          Divider(),
          Wrap(
            children: _buildPremiumFeatures(),
          ),
          selectedFeatures.isEmpty
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Divider(),
                    CustomText(
                      'Quote',
                      needsIcon: false,
                      textAlign: TextAlign.left,
                      pLeft: 0,
                    ),
                    Column(
                      children: selectedFeatures.map((e) => PremiumItemCard(feature: e)).toList(),
                    ),
                    Row(
                      children: [
                        Expanded(flex: 4, child: Container()),
                        Expanded(flex: 3, child: Divider(thickness: 2)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: CustomText(
                              '',
                              needsIcon: false,
                              textAlign: TextAlign.left,
                              pLeft: 0,
                              pBottom: 0,
                            ),
                          ),
                        ),
                        CustomText(
                          CurrencyFormatter.format(totalAmount, CurrencyF.kwachaSettings),
                          textAlign: TextAlign.right,
                          needsIcon: false,
                          pBottom: 0,
                          pLeft: 0,
                          pRight: 11,
                        ),
                      ],
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
                                  'Dear Sir/Madam,$br$br Thank you for choosing School Guide Premium features.$br$br You have applied for the following features:$br$br${selectedFeaturesChoices.join('$br$br- ')}.$br$br For any inquiries, please contact us on this same email address or on our mobile phone number +265 880 01 26 74.$br$br Best Regards.';
                              String userDetails =
                                  "${nameController.text.trim()} sent you an email applying for premium features${br}Here are the details${br}Name:        ${nameController.text.trim()}${br}Email:       ${emailController.text.trim()}${br}Phone:       ${phoneController.text.trim()}${br}REQUESTED FEATURES$br-${selectedFeaturesChoices.join('$br$br- ')}$br{$br}Best Regards${br}School Guide Mobile";
                              if (emailController.text.trim().isEmpty && nameController.text.trim().isEmpty && phoneController.text.trim().isEmpty) {
                                // showDialog
                                CustomSnackBar.showSnackBar(message: 'One or more fields look empty', title: 'Error!', color: AppColors.errorColor);
                              } else {
                                HapticFeedback.vibrate();
                                EmailService.sendEmail(email: 'info@sygen.com', message: userDetails, subject: 'APPLICATION FOR PREMIUM FEATURES');

                                EmailService.sendEmail(email: emailController.text.trim(), message: message, subject: 'APPLICATION FOR PREMIUM FEATURES');
                                Get.back();
                                CustomDialog.showCustomDialog();
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
                    SizedBox(height: 10),
                  ],
                )
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 4),
    );
  }

  double totalAmount = 0;
  List<double> amountList = [];
}

class Feature {
  final String featureName;
  final String featurePrice;
  final IconData icon;

  Feature({required this.featureName, required this.featurePrice, this.icon = Icons.workspace_premium});
}
