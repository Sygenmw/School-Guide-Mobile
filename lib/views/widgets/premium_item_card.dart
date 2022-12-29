import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:school_guide/services/currency_formatter.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/menu/premium.dart';
import 'package:school_guide/views/widgets/top_text_widget.dart';

class PremiumItemCard extends StatelessWidget {
  final Feature feature;

  const PremiumItemCard({super.key, required this.feature});
  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Icon(feature.icon, color: AppColors.primaryColor),
          ),
          Expanded(
            flex: 4,
            child: TopBlackText(text: feature.featureName),
          ),
          Expanded(
            flex: 3,
            child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 11.0),
                  child: TopBlackText(
                    text: CurrencyFormatter.format(feature.featurePrice, CurrencyF.kwachaSettings),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
