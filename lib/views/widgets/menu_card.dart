import 'package:flutter/material.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/custom_text.dart';

class MenuCardItem extends StatelessWidget {
  const MenuCardItem({Key? key, required this.onTap, required this.text, required this.icon}) : super(key: key);

  final VoidCallback onTap;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(0),
        color: AppColors.grey,
        child: InkWell(
          borderRadius: BorderRadius.circular(0),
          onTap: onTap,
          child: SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text,
                    fontSize: 15,
                    icon: icon,
                    pLeft: 12,
                    pBottom: 0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
