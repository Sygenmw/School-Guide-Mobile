import 'package:flutter/material.dart';
import 'package:school_guide/views/widgets/top_text_widget.dart';

class CustomBody extends StatelessWidget {
  const CustomBody({
    Key? key,
    required this.children,
    this.text = '',
    this.needsHeader = true,
    this.hPadding = 8.0,
    this.topPadding = 10.0,
  }) : super(key: key);
  final List<Widget> children;
  final String text;
  final bool needsHeader;
  final double hPadding;
  final double topPadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: hPadding),
        child: needsHeader
            ? ListView(
                children: [
                  SizedBox(
                    height: 35,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Center(child: TopText(text: text)),
                      ],
                    ),
                  ),
                  ...children
                ],
              )
            : Padding(
                padding:   EdgeInsets.only(top: topPadding),
                child: ListView(
                  children: children,
                ),
              ));
  }
}
