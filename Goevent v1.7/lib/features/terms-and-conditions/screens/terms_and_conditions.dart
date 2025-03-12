import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        centerTitle: true,
      ),
      body: const TermsAndConditionsBody(),
    );
  }
}

class TermsAndConditionsBody extends StatelessWidget {
  const TermsAndConditionsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LastUpdatedText(),
          SizedBox(height: 24),
          TableOfContents(),
          SizedBox(height: 24),
          AgreementSection(),
        ],
      ),
    );
  }
}

class LastUpdatedText extends StatelessWidget {
  const LastUpdatedText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Last updated February 23, 2025',
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),
    );
  }
}

class TableOfContents extends StatelessWidget {
  const TableOfContents({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TABLE OF CONTENTS',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...contents.map((content) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${content.index}. ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      content.title,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  static const List<ContentItem> contents = [
    ContentItem(1, 'OUR SERVICES'),
    ContentItem(2, 'INTELLECTUAL PROPERTY RIGHTS'),
    ContentItem(3, 'USER REPRESENTATIONS'),
    ContentItem(4, 'USER REGISTRATION'),
    ContentItem(5, 'PURCHASES AND PAYMENT'),
    ContentItem(6, 'PROHIBITED ACTIVITIES'),
    ContentItem(7, 'USER GENERATED CONTRIBUTIONS'),
    ContentItem(8, 'CONTRIBUTION LICENCE'),
    ContentItem(9, 'GUIDELINES FOR REVIEWS'),
    ContentItem(10, 'MOBILE APPLICATION LICENCE'),
    ContentItem(11, 'THIRD-PARTY WEBSITES AND CONTENT'),
    ContentItem(12, 'SERVICES MANAGEMENT'),
    ContentItem(13, 'PRIVACY POLICY'),
    ContentItem(14, 'TERM AND TERMINATION'),
    ContentItem(15, 'MODIFICATIONS AND INTERRUPTIONS'),
    ContentItem(16, 'GOVERNING LAW'),
    ContentItem(17, 'DISPUTE RESOLUTION'),
    ContentItem(18, 'CORRECTIONS'),
    ContentItem(19, 'DISCLAIMER'),
    ContentItem(20, 'LIMITATIONS OF LIABILITY'),
    ContentItem(21, 'INDEMNIFICATION'),
    ContentItem(22, 'USER DATA'),
    ContentItem(23, 'ELECTRONIC COMMUNICATIONS, TRANSACTIONS, AND SIGNATURES'),
    ContentItem(24, 'SMS TEXT MESSAGING'),
    ContentItem(25, 'MISCELLANEOUS'),
    ContentItem(26, 'CONTACT US'),
  ];
}

class ContentItem {
  final int index;
  final String title;

  const ContentItem(this.index, this.title);
}

class AgreementSection extends StatelessWidget {
  const AgreementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AGREEMENT TO OUR LEGAL TERMS',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...legalTermsParagraphs.map((paragraph) => ParagraphText(text: paragraph)),
        const SizedBox(height: 24),
      ],
    );
  }

  static const List<String> legalTermsParagraphs = [
    'We are Parivartan X ("Company", "we", "us", or "our").',
    'We operate the website http://www.hamaraticket.com (the "Site"), the mobile application HamaraTicket (the "App"), as well as any other related products and services that refer or link to these legal terms (the "Legal Terms") (collectively, the "Services").',
    'HamaraTicket is an e-ticket booking platform that enables users to purchase tickets for parks, water parks, and private events in their vicinity. The platform offers a seamless ticketing experience, allowing customers to conveniently book tickets online. HamaraTicket is powered by ParivartanX, a leading software development agency specializing in web and mobile applications.',
    'You can contact us by phone at +91 9060924752, email at parivartanx.info@gmail.com, or by mail to Shadalichak Patna, Patna, Bihar 804453, India.',
    'These Legal Terms constitute a legally binding agreement made between you, whether personally or on behalf of an entity ("you"), and Parivartan X, concerning your access to and use of the Services. You agree that by accessing the Services, you have read, understood, and agreed to be bound by all of these Legal Terms. IF YOU DO NOT AGREE WITH ALL OF THESE LEGAL TERMS, THEN YOU ARE EXPRESSLY PROHIBITED FROM USING THE SERVICES AND YOU MUST DISCONTINUE USE IMMEDIATELY.',
    'We will provide you with prior notice of any scheduled changes to the Services you are using. The modified Legal Terms will become effective upon posting or notifying you by parivartanx.info@gmail.com, as stated in the email message. By continuing to use the Services after the effective date of any changes, you agree to be bound by the modified terms.',
    'The Services are intended for users who are at least 18 years old. Persons under the age of 18 are not permitted to use or register for the Services.',
    'We recommend that you print a copy of these Legal Terms for your records.',
  ];
}

class ParagraphText extends StatelessWidget {
  final String text;

  const ParagraphText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          height: 1.5,
        ),
      ),
    );
  }
}