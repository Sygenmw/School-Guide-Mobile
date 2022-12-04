// ignore_for_file: unnecessary_statements

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:school_guide/views/widgets/custom_form_field.dart';
import 'package:school_guide/views/widgets/custom_text.dart';
import 'package:school_guide/views/widgets/premium_item_card.dart';
import 'package:school_guide/views/widgets/submit_button.dart';
import 'package:school_guide/views/widgets/top_text_widget.dart';

class Premium extends StatefulWidget {
  const Premium({super.key});

  @override
  State<Premium> createState() => _PremiumState();
}

class _PremiumState extends State<Premium> {
  // Premium features
  List<Feature> features = [
    Feature(featureName: '10+ Images', featurePrice: 10000, icon: Icons.browse_gallery),
    Feature(featureName: 'School on home page', featurePrice: 40000, icon: Icons.branding_watermark),
    Feature(featureName: 'Advert on banner', featurePrice: 50000, icon: FontAwesomeIcons.adversal),
    Feature(featureName: 'Video Ad of the school', featurePrice: 50000, icon: FontAwesomeIcons.video),
    Feature(featureName: 'School brochure(with design)', featurePrice: 45000, icon: FontAwesomeIcons.boxArchive),
    Feature(featureName: 'Map and directions to school', featurePrice: 40000, icon: FontAwesomeIcons.mapLocation),
  ];

  String selectedFeature = '';
  List<String> selectedFeaturesChoices = [];
  List<Feature> selectedFeatures = [];
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
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
                            totalAmount -= element.featurePrice;
                            selectedFeatures.remove(element);
                          }
                        })
                      }
                    : {
                        features.forEach((element) {
                          if (element.featureName == item) {
                            totalAmount += element.featurePrice;
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
                              'Total (K)         ',
                              needsIcon: false,
                              textAlign: TextAlign.left,
                              pLeft: 0,
                              pBottom: 0,
                            ),
                          ),
                        ),
                        CustomText(
                          totalAmount.toString(),
                          textAlign: TextAlign.right,
                          needsIcon: false,
                          pBottom: 0,
                          pLeft: 0,
                          pRight: 11,
                        ),
                      ],
                    ),
                    SubmitButton(
                      subject: 'REGISTRATION FOR PREMIUM FEATURES.',
                      body:
                          'Dear Sir/Madam, \nThe above subject in reference matters. We at ${nameController.text.trim()} are writing you this email, applying for the following premium features :\n${selectedFeaturesChoices.join('\n- ')}.\n\nWe will be glad if our application is taken into consideration at your earliest inconvenience.\nFor any other inquiries, please contact us on this same email address or on our mobile phone number : ${phoneController.text.trim()}.\n\nReceive our Best Regards\n${nameController.text.trim()}.',
                      controllers: [nameController, phoneController],
                    ),
                    SizedBox(height: 10),
                  ],
                )
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  double totalAmount = 0;
  List<double> amountList = [];
}

class Feature {
  final String featureName;
  final double featurePrice;
  final IconData icon;

  Feature({required this.featureName, required this.featurePrice, this.icon = Icons.workspace_premium});
}
