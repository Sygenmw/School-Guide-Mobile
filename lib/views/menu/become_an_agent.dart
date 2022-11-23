import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:school_guide/views/widgets/custom_form_field.dart';
import 'package:school_guide/views/widgets/custom_snackbar.dart';
import 'package:school_guide/views/widgets/custom_text.dart';
import 'package:school_guide/views/widgets/top_text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class BecomeAnAgent extends StatefulWidget {
  const BecomeAnAgent({super.key});

  @override
  State<BecomeAnAgent> createState() => _BecomeAnAgentState();
}

class _BecomeAnAgentState extends State<BecomeAnAgent> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController servicesController = TextEditingController();

  var selectedLocation;

  List<String> location = ["Blantyre", "Zomba", "Mzuzu", "Lilongwe"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomBody(
        text: 'Become an agent',
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
                  'An agent, finds open and verified scholarships or is contacted of open scholarhsip by a verified institution',
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          TopBlackText(text: 'Please, fill in the form below, to register as an Agent.'),
          SizedBox(height: 6),
          CustomFormField(controller: nameController, hintText: 'Company name', keyboardType: TextInputType.name, labelText: 'Company name'),
          CustomFormField(controller: phoneController, hintText: 'Phone number', keyboardType: TextInputType.phone, labelText: 'Phone number'),
          CustomFormField(controller: emailController, hintText: 'Email address', keyboardType: TextInputType.emailAddress, labelText: 'Email address'),
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
                        'Location',
                      ),
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        iconSize: 30,
                        decoration: const InputDecoration(enabledBorder: InputBorder.none),
                        hint: const Text(''),
                        value: selectedLocation,
                        items: location.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedLocation = value as String;
                          });
                        },
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(height: 5),
          CustomDescFormField(controller: servicesController, hintText: 'Services you provide', labelText: 'Services you provide'),
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
                  bool notEmpty = nameController.text.isNotEmpty || emailController.text.isNotEmpty || phoneController.text.isNotEmpty;

                  bool notBlank = (selectedLocation.toString().isNotEmpty || servicesController.text.isNotEmpty);
                  if (notEmpty && notBlank) {
                    HapticFeedback.vibrate();
                    String subject = 'APPLICATION TO BE AN AGENT.';
                    String body =
                        'Respected Sir. \nThe above subject in reference matters. We are ${nameController.text.trim()}, a Malawian Business specializing in providing services like ${servicesController.text.trim()} to those who need them. Our business is registered with the Registrar General of Businesses  and we are currently situated in $selectedLocation.\nWe henceforth write you this email in reference to the above subject applying to be offering services like ${servicesController.text.trim()} through your mobile application.\nWe will be glad if our application is taken into consideration at your earliest inconvenience.\nFor any other business inquiries, please contact us on this same email address or on our mobile phone number : ${phoneController.text.trim()}.\n\nReceive our Best Regards\n${nameController.text.trim()}.';
                    String query = 'mailto:info@sygenmw.com?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}';
                    launchUrl(Uri.parse(query));
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
      bottomNavigationBar: CustomBottomNavBar(),

    );
  }
}
