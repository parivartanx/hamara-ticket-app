import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/attendees_list.dart';
import '../widgets/event_header_image.dart';
import '/extensions/media_query_ext.dart';
import '../../../home/ticket.dart';
import '/organizer/oprofile.dart';
import '/providers/color_provider.dart';
import '/utils/string.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../utils/botton.dart';

class EventDetailsScreen extends ConsumerStatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  ConsumerState<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends ConsumerState<EventDetailsScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    
    return ScreenUtilInit(
      builder: (context, child) => Scaffold(
        backgroundColor: context.colorScheme.surface,
        floatingActionButton: const BuyTicketButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const EventHeader(),
              SizedBox(height: context.height / 30),
              const EventBody(),
            ],
          ),
        ),
      ),
    );
  }
}

class BuyTicketButton extends StatelessWidget {

  const BuyTicketButton({super.key,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: SizedBox(
        height: 45.h,
        width: 410.w,
        child: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: const Ticket(),
            ),
          ),
          child: Custombutton.button(
            Theme.of(context).colorScheme.primary,
            CustomStrings.buy,
            SizedBox(width: context.width / 4.5),
            SizedBox(width: context.width / 20),
          ),
        ),
      ),
    );
  }
}

class EventHeader extends StatelessWidget { 
  const EventHeader({
    super.key,
    
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const EventHeaderImage(),
        Column(
          children: [
            SizedBox(height: context.height / 20),
            const HeaderActions(),
            SizedBox(height: context.height / 8.5),
            const AttendeesList(),
          ],
        ),
      ],
    );
  }
}


class HeaderActions extends StatelessWidget {

  const HeaderActions({super.key, });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: context.width / 20),
        const BackButton(color: Colors.white),
        SizedBox(width: context.width / 80),
        EventTitle(),
        const Spacer(),
        const SaveButton(),
        const SizedBox(width: 20),
      ],
    );
  }
}

class EventTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      CustomStrings.events,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w900,
        fontFamily: 'Gilroy Medium',
        color: Colors.white,
      ),
    );
  }
}

class SaveButton extends StatelessWidget {

  const SaveButton({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height / 25,
      width: context.width / 12,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(200),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Image.asset(
          "assets/image/save.png",
          color: Colors.white,
        ),
      ),
    );
  }
}

class InviteButton extends StatelessWidget {

  const InviteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height / 30,
      width: context.width / 6,
      color: const Color(0xff5669ff),
      child: Center(
        child: Text(
          "Invite",
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontFamily: 'Gilroy Bold',
          ),
        ),
      ),
    );
  }
}

class EventBody extends StatelessWidget {
  const EventBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EventTitleSection(colorScheme: context.colorScheme),
        SizedBox(height: context.height / 40),
        EventInfoCard(
          imagePath: "assets/image/date.png",
          title: "14 December, 2021",
          subtitle: "Tuesday, 4:00PM - 9:00PM",
          colorScheme: context.colorScheme,
          size: MediaQuery.of(context).size,
        ),
        SizedBox(height: context.height / 40),
        EventInfoCard(
          imagePath: "assets/image/direction.png",
          title: "Gala Convention Center",
          subtitle: "36 Guild Street London, UK",
          colorScheme: context.colorScheme,
          size: MediaQuery.of(context).size,
        ),
        SizedBox(height: context.height / 40),
        OrganizerCard(
          size: MediaQuery.of(context).size,
          colorScheme: context.colorScheme,
        ),
        SizedBox(height: context.height / 40),
        AboutEventSection(
          size: MediaQuery.of(context).size,
          colorScheme: context.colorScheme,
        ),
      ],
    );
  }
}

class EventInfoCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final ColorScheme colorScheme;
  final Size size;

  const EventInfoCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.colorScheme,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            height: size.height / 15,
            width: size.width / 7,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(imagePath),
            ),
          ),
          SizedBox(width: size.width / 40),
          EventInfoText(
            title: title,
            subtitle: subtitle,
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }
}

class EventTitleSection extends StatelessWidget {
  final ColorScheme colorScheme;

  const EventTitleSection({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        CustomStrings.music,
        style: TextStyle(
          fontSize: 35.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'Gilroy Medium',
          color: colorScheme.surface,
        ),
      ),
    );
  }
}

class EventInfoText extends StatelessWidget {
  final String title;
  final String subtitle;
  final ColorScheme colorScheme;

  const EventInfoText({
    super.key,
    required this.title,
    required this.subtitle,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'Gilroy Medium',
            color: colorScheme.surface,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'Gilroy Medium',
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class OrganizerCard extends StatelessWidget {
  final Size size;
  final ColorScheme colorScheme;

  const OrganizerCard({
    super.key,
    required this.size,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: const Organize(),
            ),
          );
        },
        child: Container(
          color: Colors.transparent,
          child: Row(
            children: [
              Container(
                height: size.height / 15,
                width: size.width / 7,
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset("assets/image/p1.png"),
                ),
              ),
              SizedBox(width: size.width / 38),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ashfak Sayem",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Gilroy Medium',
                      color: colorScheme.surface,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Organizer",
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Gilroy Medium',
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: const Organize(),
                    ),
                  );
                },
                child: Container(
                  height: size.height / 30,
                  width: size.width / 6,
                  color: colorScheme.surface,
                  child: Center(
                    child: Text(
                      "Follow",
                      style: TextStyle(
                        color: const Color(0xff5669ff),
                        fontSize: 12.sp,
                        fontFamily: 'Gilroy Bold',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AboutEventSection extends StatelessWidget {
  final Size size;
  final ColorScheme colorScheme;

  const AboutEventSection({
    super.key,
    required this.size,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            "About Event",
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'Gilroy Medium',
              color: colorScheme.surface,
            ),
          ),
        ],
      ),
    );
  }
}
