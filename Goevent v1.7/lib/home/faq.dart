import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../providers/color_provider.dart';
import '../utils/media.dart';

class Faq extends ConsumerStatefulWidget {
  const Faq({Key? key}) : super(key: key);

  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends ConsumerState<Faq> {
  
  @override
  void initState() {
    super.initState();
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
  }

  final _loremIpsum =
      "Open the GoEvent app to get started and follow the\nsteps. GoEvent doesn't charge a fee to create or\nmaintain your GoEvent account.";
  final _contentStyle = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    final notifire = ref.watch(colorProvider);
    return ScreenUtilInit(
      builder:  (BuildContext context, child) =>  Scaffold(
        backgroundColor: notifire.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height / 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width / 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child:
                        Icon(Icons.arrow_back, color: notifire.darksColor),
                  ),
                  SizedBox(
                    width: width / 80,
                  ),
                  Text(
                    "Helps & FAQs",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Gilroy Medium',
                      color: notifire.darksColor,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.more_vert,
                    color: notifire.darksColor,
                  ),
                  SizedBox(
                    width: width / 20,
                  ),
                ],
              ),
              SizedBox(
                height: height / 25,
              ),
              Row(
                children: [
                  SizedBox(width: width / 15),
                  Text(
                    "Top Questions :",
                    style: TextStyle(
                        color: notifire.buttonsColor,
                        fontSize: 17.sp,
                        fontFamily: 'Gilroy ExtraBold'),
                  ),
                ],
              ),
              //SizedBox(height: height / 50),
              Accordion(
                disableScrolling: true,
                flipRightIconIfOpen: true,
                contentVerticalPadding: 0,
                scrollIntoViewOfItems: ScrollIntoViewOfItems.fast,
                contentBorderColor: Colors.transparent,
                maxOpenSections: 1,
                headerBackgroundColorOpened: Colors.black54,
                headerPadding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                children: [
                  AccordionSection(
                    sectionClosingHapticFeedback: SectionHapticFeedback.light,
                    headerBackgroundColor: notifire.primaryColor,
                    header: Text(
                      'How to create a GoEvent account?',
                      style: TextStyle(
                          color: notifire.darksColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    content: Text(_loremIpsum, style: _contentStyle),
                    contentHorizontalPadding: 20,
                    contentBorderWidth: 1,
                  ),
                  AccordionSection(
                    // flipRightIconIfOpen: true,
                    headerBackgroundColor: notifire.primaryColor,
                    header: Text(
                      'How to add a payment method?',
                      style: TextStyle(
                          color: notifire.darksColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    content: Text(_loremIpsum, style: _contentStyle),
                    contentHorizontalPadding: 20,
                    contentBorderWidth: 1,
                  ),
                  AccordionSection(
                    // flipRightIconIfOpen: true,
                    headerBackgroundColor: notifire.primaryColor,
                    header: Text(
                      'How to buy stocks?',
                      style: TextStyle(
                          color: notifire.darksColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    content: Text(_loremIpsum, style: _contentStyle),
                    contentHorizontalPadding: 20,
                    contentBorderWidth: 1,
                  ),
                  AccordionSection(
                    sectionClosingHapticFeedback: SectionHapticFeedback.light,
                    headerBackgroundColor: notifire.primaryColor,
                    header: Text(
                      'How to create a GoEvent account?',
                      style: TextStyle(
                          color: notifire.darksColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    content: Text(_loremIpsum, style: _contentStyle),
                    contentHorizontalPadding: 20,
                    contentBorderWidth: 1,
                  ),
                  AccordionSection(
                    // flipRightIconIfOpen: true,
                    headerBackgroundColor: notifire.primaryColor,
                    header: Text(
                      'How to add a payment method?',
                      style: TextStyle(
                          color: notifire.darksColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    content: Text(_loremIpsum, style: _contentStyle),
                    contentHorizontalPadding: 20,
                    contentBorderWidth: 1,
                  ),
                  AccordionSection(
                    // flipRightIconIfOpen: true,
                    headerBackgroundColor: notifire.primaryColor,
                    header: Text(
                      'How to buy stocks?',
                      style: TextStyle(
                          color: notifire.darksColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    content: Text(_loremIpsum, style: _contentStyle),
                    contentHorizontalPadding: 20,
                    contentBorderWidth: 1,
                  ),
                  AccordionSection(
                    sectionClosingHapticFeedback: SectionHapticFeedback.light,
                    headerBackgroundColor: notifire.primaryColor,
                    header: Text(
                      'How to create a GoEvent account?',
                      style: TextStyle(
                          color: notifire.darksColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    content: Text(_loremIpsum, style: _contentStyle),
                    contentHorizontalPadding: 20,
                    contentBorderWidth: 1,
                  ),
                  AccordionSection(
                    // flipRightIconIfOpen: true,
                    headerBackgroundColor: notifire.primaryColor,
                    header: Text(
                      'How to add a payment method?',
                      style: TextStyle(
                          color: notifire.darksColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    content: Text(_loremIpsum, style: _contentStyle),
                    contentHorizontalPadding: 20,
                    contentBorderWidth: 1,
                  ),
                  AccordionSection(
                    // flipRightIconIfOpen: true,
                    headerBackgroundColor: notifire.primaryColor,
                    header: Text(
                      'How to buy stocks?',
                      style: TextStyle(
                        color: notifire.darksColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Text(
                      _loremIpsum,
                      style: _contentStyle,
                    ),
                    contentHorizontalPadding: 20,
                    contentBorderWidth: 1,
                  ),
                  AccordionSection(
                    sectionClosingHapticFeedback: SectionHapticFeedback.light,
                    headerBackgroundColor: notifire.primaryColor,
                    header: Text(
                      'How to create a GoEvent account?',
                      style: TextStyle(
                        color: notifire.darksColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Text(_loremIpsum, style: _contentStyle),
                    contentHorizontalPadding: 20,
                    contentBorderWidth: 1,
                  ),
                  AccordionSection(
                    // flipRightIconIfOpen: true,
                    headerBackgroundColor: notifire.primaryColor,
                    header: Text(
                      'How to add a payment method?',
                      style: TextStyle(
                        color: notifire.darksColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Text(_loremIpsum, style: _contentStyle),
                    contentHorizontalPadding: 20,
                    contentBorderWidth: 1,
                  ),
                  AccordionSection(
                    // flipRightIconIfOpen: true,
                    headerBackgroundColor: notifire.primaryColor,
                    header: Text(
                      'How to buy stocks?',
                      style: TextStyle(
                          color: notifire.darksColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    content: Text(_loremIpsum, style: _contentStyle),
                    contentHorizontalPadding: 20,
                    contentBorderWidth: 1,
                  ),
                ],
              ),
              // type("How to buy stocks?", Icons.add),
            ],
          ),
        ),
      ),
    );
  }
}
