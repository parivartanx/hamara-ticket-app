import 'package:flutter/material.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}

class KeyPoint extends StatelessWidget {
  final String title;
  final String description;

  const KeyPoint({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class TableOfContentsItem extends StatelessWidget {
  final int index;
  final String title;

  const TableOfContentsItem({
    Key? key,
    required this.index,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // TODO: Implement scroll to section
          },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      '$index',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InfoSection extends StatelessWidget {
  final String title;
  final String shortDescription;
  final List<Widget> children;

  const InfoSection({
    Key? key,
    required this.title,
    required this.shortDescription,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'In Short: $shortDescription',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

class InfoSubSection extends StatelessWidget {
  final String title;
  final List<String> items;
  final String? description;

  const InfoSubSection({
    Key? key,
    required this.title,
    required this.items,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (description != null) ...[
            const SizedBox(height: 8),
            Text(
              description!,
              style: const TextStyle(fontSize: 16),
            ),
          ],
          if (items.isNotEmpty) ...[
            const SizedBox(height: 12),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontSize: 16)),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ],
      ),
    );
  }
}

class PrivacyPolicyScreen extends StatelessWidget {
  static const routeName = 'Privacy Policy Screen';
  static const routePath = '/privacy-policy-screen';

  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Last updated February 23, 2025',
              style: TextStyle(
                color: context.colorScheme.outline,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'This Privacy Notice for Parivartan X ("we", "us", or "our"), describes how and why we might access, collect, store, use, and/or share ("process") your personal information when you use our services ("Services"), including when you:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const BulletPoint(
              text: 'Visit our website at http://www.hamaraticket.com, or any website of ours that links to this Privacy Notice',
            ),
            const BulletPoint(
              text: 'Download and use our mobile application (HamaraTicket), or any other application of ours that links to this Privacy Notice',
            ),
            const BulletPoint(
              text: 'Use HamaraTicket - A E-Ticket Booking Platform',
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'HamaraTicket is an e-ticket booking platform that enables users to purchase tickets for parks, water parks, and private events in their vicinity. The platform offers a seamless ticketing experience, allowing customers to conveniently book tickets online. HamaraTicket is powered by ParivartanX, a leading software development agency specializing in web and mobile applications.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Questions or concerns?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Reading this Privacy Notice will help you understand your privacy rights and choices. We are responsible for making decisions about how your personal information is processed. If you do not agree with our policies and practices, please do not use our Services.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  const TextSpan(
                    text: 'If you still have any questions or concerns, please contact us at ',
                  ),
                  TextSpan(
                    text: 'parivartanx.info@gmail.com',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'SUMMARY OF KEY POINTS',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'This summary provides key points from our Privacy Notice, but you can find out more details about any of these topics by clicking the link following each key point or by using our table of contents below to find the section you are looking for.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const KeyPoint(
              title: 'What personal information do we process?',
              description: 'When you visit, use, or navigate our Services, we may process personal information depending on how you interact with us and the Services, the choices you make, and the products and features you use.',
            ),
            const KeyPoint(
              title: 'Do we process any sensitive personal information?',
              description: 'Some of the information may be considered \'special\' or \'sensitive\' in certain jurisdictions. We do not process sensitive personal information.',
            ),
            const KeyPoint(
              title: 'Do we collect any information from third parties?',
              description: 'We do not collect any information from third parties.',
            ),
            const KeyPoint(
              title: 'How do we process your information?',
              description: 'We process your information to provide, improve, and administer our Services, communicate with you, for security and fraud prevention, and to comply with law. We process your information only when we have a valid legal reason to do so.',
            ),
            const KeyPoint(
              title: 'How do we keep your information safe?',
              description: 'We aim to protect your personal information through a system of organisational and technical security measures.',
            ),
            const KeyPoint(
              title: 'What are your rights?',
              description: 'Depending on where you are located geographically, the applicable privacy law may mean you have certain rights regarding your personal information.',
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.menu_book,
                        color: Theme.of(context).primaryColor,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'TABLE OF CONTENTS',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  const TableOfContentsItem(
                    index: 1,
                    title: 'WHAT INFORMATION DO WE COLLECT?',
                  ),
                  const TableOfContentsItem(
                    index: 2,
                    title: 'HOW DO WE PROCESS YOUR INFORMATION?',
                  ),
                  const TableOfContentsItem(
                    index: 3,
                    title: 'WHEN AND WITH WHOM DO WE SHARE YOUR PERSONAL INFORMATION?',
                  ),
                  const TableOfContentsItem(
                    index: 4,
                    title: 'DO WE USE COOKIES AND OTHER TRACKING TECHNOLOGIES?',
                  ),
                  const TableOfContentsItem(
                    index: 5,
                    title: 'HOW DO WE HANDLE YOUR SOCIAL LOGINS?',
                  ),
                  const TableOfContentsItem(
                    index: 6,
                    title: 'HOW LONG DO WE KEEP YOUR INFORMATION?',
                  ),
                  const TableOfContentsItem(
                    index: 7,
                    title: 'HOW DO WE KEEP YOUR INFORMATION SAFE?',
                  ),
                  const TableOfContentsItem(
                    index: 8,
                    title: 'DO WE COLLECT INFORMATION FROM MINORS?',
                  ),
                  const TableOfContentsItem(
                    index: 9,
                    title: 'WHAT ARE YOUR PRIVACY RIGHTS?',
                  ),
                  const TableOfContentsItem(
                    index: 10,
                    title: 'CONTROLS FOR DO-NOT-TRACK FEATURES',
                  ),
                  const TableOfContentsItem(
                    index: 11,
                    title: 'DO WE MAKE UPDATES TO THIS NOTICE?',
                  ),
                  const TableOfContentsItem(
                    index: 12,
                    title: 'HOW CAN YOU CONTACT US ABOUT THIS NOTICE?',
                  ),
                  const TableOfContentsItem(
                    index: 13,
                    title: 'HOW CAN YOU REVIEW, UPDATE, OR DELETE THE DATA WE COLLECT FROM YOU?',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            InfoSection(
              title: '1. WHAT INFORMATION DO WE COLLECT?',
              shortDescription: 'We collect personal information that you provide to us.',
              children: [
                Text(
                  'We collect personal information that you voluntarily provide to us when you register on the Services, express an interest in obtaining information about us or our products and Services, when you participate in activities on the Services, or otherwise when you contact us.',
                  style: TextStyle(fontSize: 16),
                ),
                InfoSubSection(
                  title: 'Personal Information Provided by You',
                  description: 'The personal information that we collect depends on the context of your interactions with us and the Services, the choices you make, and the products and features you use. The personal information we collect may include the following:',
                  items: [
                    'names',
                    'phone numbers',
                    'email addresses',
                    'passwords',
                    'usernames',
                    'debit/credit card numbers',
                    'contact preferences',
                    'contact or authentication data',
                  ],
                ),
                InfoSubSection(
                  title: 'Sensitive Information',
                  description: 'We do not process sensitive information.',
                  items: [],
                ),
                InfoSubSection(
                  title: 'Payment Data',
                  description: 'We may collect data necessary to process your payment if you make purchases, such as your payment instrument number, and the security code associated with your payment instrument.',
                  items: [],
                ),
                InfoSubSection(
                  title: 'Social Media Login Data',
                  description: 'We may provide you with the option to register with us using your existing social media account details. If you choose to register in this way, we will collect certain profile information about you from the social media provider. You can find more details in the section called \'HOW DO WE HANDLE YOUR SOCIAL LOGINS?\' below.',
                  items: [],
                ),
                InfoSubSection(
                  title: 'Application Data',
                  description: 'If you use our application(s), we also may collect the following information if you choose to provide us with access or permission:',
                  items: [
                    'Geolocation Information. We may request access or permission to track location-based information from your mobile device, either continuously or while you are using our mobile application(s), to provide certain location-based services.',
                    'Mobile Device Access. We may request access or permission to certain features from your mobile device, including your mobile device\'s sms messages, contacts, social media accounts, storage, and other features.',
                    'Mobile Device Data. We automatically collect device information, operating system, version information and system configuration information.',
                    'Push Notifications. We may request to send you push notifications regarding your account or certain features of the application(s).',
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'All personal information that you provide to us must be true, complete, and accurate, and you must notify us of any changes to such personal information.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                InfoSubSection(
                  title: 'Information automatically collected',
                  description: 'Some information — such as your Internet Protocol (IP) address and/or browser and device characteristics — is collected automatically when you visit our Services.',
                  items: [
                    'Log and Usage Data. Log and usage data is service-related, diagnostic, usage, and performance information our servers automatically collect when you access or use our Services and which we record in log files.',
                    'Device Data. We collect device data such as information about your computer, phone, tablet, or other device you use to access the Services.',
                    'Location Data. We collect location data such as information about your device\'s location, which can be either precise or imprecise.',
                  ],
                ),
                InfoSubSection(
                  title: 'Google API',
                  description: 'Our use of information received from Google APIs will adhere to Google API Services User Data Policy, including the Limited Use requirements.',
                  items: [],
                ),
              ],
            ),
            const SizedBox(height: 32),
            InfoSection(
              title: '2. HOW DO WE PROCESS YOUR INFORMATION?',
              shortDescription: 'We process your information to provide, improve, and administer our Services, communicate with you, for security and fraud prevention, and to comply with law. We may also process your information for other purposes with your consent.',
              children: [
                Text(
                  'We process your personal information for a variety of reasons, depending on how you interact with our Services, including:',
                  style: TextStyle(fontSize: 16),
                ),
                InfoSubSection(
                  title: 'To facilitate account creation and authentication and otherwise manage user accounts',
                  description: 'We may process your information so you can create and log in to your account, as well as keep your account in working order.',
                  items: [],
                ),
                InfoSubSection(
                  title: 'To request feedback',
                  description: 'We may process your information when necessary to request feedback and to contact you about your use of our Services.',
                  items: [],
                ),
                InfoSubSection(
                  title: 'To deliver targeted advertising to you',
                  description: 'We may process your information to develop and display personalised content and advertising tailored to your interests, location, and more.',
                  items: [],
                ),
                InfoSubSection(
                  title: 'To post testimonials',
                  description: 'We post testimonials on our Services that may contain personal information.',
                  items: [],
                ),
                InfoSubSection(
                  title: 'To administer prize draws and competitions',
                  description: 'We may process your information to administer prize draws and competitions.',
                  items: [],
                ),
                InfoSubSection(
                  title: 'To evaluate and improve our Services, products, marketing, and your experience',
                  description: 'We may process your information when we believe it is necessary to identify usage trends, determine the effectiveness of our promotional campaigns, and to evaluate and improve our Services, products, marketing, and your experience.',
                  items: [],
                ),
                InfoSubSection(
                  title: 'To determine the effectiveness of our marketing and promotional campaigns',
                  description: 'We may process your information to better understand how to provide marketing and promotional campaigns that are most relevant to you.',
                  items: [],
                ),
              ],
            ),
            const SizedBox(height: 32),
            InfoSection(
              title: '3. WHEN AND WITH WHOM DO WE SHARE YOUR PERSONAL INFORMATION?',
              shortDescription: 'We may share information in specific situations described in this section and/or with the following categories of third parties.',
              children: [
                InfoSubSection(
                  title: 'Vendors, Consultants, and Other Third-Party Service Providers',
                  description: 'We may share your data with third-party vendors, service providers, contractors, or agents (\'third parties\') who perform services for us or on our behalf and require access to such information to do that work.\n\nThe categories of third parties we may share personal information with are as follows:',
                  items: [
                    'Cloud Computing Services',
                    'Payment Processors',
                    'Performance Monitoring Tools',
                    'Website Hosting Service Providers',
                    'Data Analytics Services',
                    'Data Storage Service Providers',
                    'User Account Registration & Authentication Services',
                  ],
                ),
                InfoSubSection(
                  title: 'Business Transfers',
                  description: 'We may share or transfer your information in connection with, or during negotiations of, any merger, sale of company assets, financing, or acquisition of all or a portion of our business to another company.',
                  items: [],
                ),
                InfoSubSection(
                  title: 'When we use Google Maps Platform APIs',
                  description: 'We may share your information with certain Google Maps Platform APIs. Google Maps uses GPS, Wi-Fi, and cell towers to estimate your location. GPS is accurate to about 20 meters, while Wi-Fi and cell towers help improve accuracy when GPS signals are weak, like indoors. We obtain and store on your device (\'cache\') your location. You may revoke your consent anytime by contacting us at the contact details provided at the end of this document.',
                  items: [],
                ),
                InfoSubSection(
                  title: 'Affiliates',
                  description: 'We may share your information with our affiliates, in which case we will require those affiliates to honour this Privacy Notice. Affiliates include our parent company and any subsidiaries, joint venture partners, or other companies that we control or that are under common control with us.',
                  items: [],
                ),
                InfoSubSection(
                  title: 'Business Partners',
                  description: 'We may share your information with our business partners to offer you certain products, services, or promotions.',
                  items: [],
                ),
                InfoSubSection(
                  title: 'Offer Wall',
                  description: 'Our application(s) may display a third-party hosted \'offer wall\'. Such an offer wall allows third-party advertisers to offer virtual currency, gifts, or other items to users in return for the acceptance and completion of an advertisement offer. Such an offer wall may appear in our application(s) and be displayed to you based on certain data, such as your geographic area or demographic information. When you click on an offer wall, you will be brought to an external website belonging to other persons and will leave our application(s). A unique identifier, such as your user ID, will be shared with the offer wall provider in order to prevent fraud and properly credit your account with the relevant reward.',
                  items: [],
                ),
              ],
            ),
            const SizedBox(height: 32),
            InfoSection(
              title: '4. DO WE USE COOKIES AND OTHER TRACKING TECHNOLOGIES?',
              shortDescription: 'We may use cookies and other tracking technologies to collect and store your information.',
              children: [
                InfoSubSection(
                  title: 'Tracking Technologies',
                  description: 'We may use cookies and similar tracking technologies (like web beacons and pixels) to gather information when you interact with our Services. Some online tracking technologies help us maintain the security of our Services and your account, prevent crashes, fix bugs, save your preferences, and assist with basic site functions.',
                  items: [],
                ),
                InfoSubSection(
                  title: 'Third-Party Tracking',
                  description: 'We also permit third parties and service providers to use online tracking technologies on our Services for analytics and advertising, including to help manage and display advertisements, to tailor advertisements to your interests, or to send abandoned shopping cart reminders (depending on your communication preferences). The third parties and service providers use their technology to provide advertising about products and services tailored to your interests which may appear either on our Services or on other websites.',
                  items: [],
                ),
                InfoSubSection(
                  title: 'Cookie Notice',
                  description: 'Specific information about how we use such technologies and how you can refuse certain cookies is set out in our Cookie Notice.',
                  items: [],
                ),
                InfoSubSection(
                  title: 'Google Analytics',
                  description: 'We may share your information with Google Analytics to track and analyse the use of the Services. The Google Analytics Advertising Features that we may use include: Remarketing with Google Analytics.',
                  items: [],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Opt-out Options',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'You can opt out of tracking in the following ways:',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      _buildOptOutLink(
                        context,
                        'Google Analytics Opt-out',
                        'https://tools.google.com/dlpage/gaoptout',
                      ),
                      _buildOptOutLink(
                        context,
                        'Network Advertising Initiative Opt-out',
                        'http://optout.networkadvertising.org/',
                      ),
                      _buildOptOutLink(
                        context,
                        'Mobile Choice Opt-out',
                        'http://www.networkadvertising.org/mobile-choice',
                      ),
                      const SizedBox(height: 12),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                          children: [
                            const TextSpan(
                              text: 'For more information on the privacy practices of Google, please visit the ',
                            ),
                            TextSpan(
                              text: 'Google Privacy & Terms page',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const TextSpan(text: '.'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            InfoSection(
              title: '5. HOW DO WE HANDLE YOUR SOCIAL LOGINS?',
              shortDescription: 'If you choose to register or log in to our Services using a social media account, we may have access to certain information about you.',
              children: [
                Text(
                  'Our Services offer you the ability to register and log in using your third-party social media account details (like your Facebook or X logins). Where you choose to do this, we will receive certain profile information about you from your social media provider. The profile information we receive may vary depending on the social media provider concerned, but will often include your name, email address, friends list, and profile picture, as well as other information you choose to make public on such a social media platform.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Text(
                  'We will use the information we receive only for the purposes that are described in this Privacy Notice or that are otherwise made clear to you on the relevant Services. Please note that we do not control, and are not responsible for, other uses of your personal information by your third-party social media provider. We recommend that you review their privacy notice to understand how they collect, use, and share your personal information, and how you can set your privacy preferences on their sites and apps.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 32),
            InfoSection(
              title: '6. HOW LONG DO WE KEEP YOUR INFORMATION?',
              shortDescription: 'We keep your information for as long as necessary to fulfil the purposes outlined in this Privacy Notice unless otherwise required by law.',
              children: [
                Text(
                  'We will only keep your personal information for as long as it is necessary for the purposes set out in this Privacy Notice, unless a longer retention period is required or permitted by law (such as tax, accounting, or other legal requirements). No purpose in this notice will require us keeping your personal information for longer than six (6) months past the termination of the user\'s account.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Text(
                  'When we have no ongoing legitimate business need to process your personal information, we will either delete or anonymise such information, or, if this is not possible (for example, because your personal information has been stored in backup archives), then we will securely store your personal information and isolate it from any further processing until deletion is possible.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 32),
            InfoSection(
              title: '7. HOW DO WE KEEP YOUR INFORMATION SAFE?',
              shortDescription: 'We aim to protect your personal information through a system of organisational and technical security measures.',
              children: [
                Text(
                  'We have implemented appropriate and reasonable technical and organisational security measures designed to protect the security of any personal information we process. However, despite our safeguards and efforts to secure your information, no electronic transmission over the Internet or information storage technology can be guaranteed to be 100% secure, so we cannot promise or guarantee that hackers, cybercriminals, or other unauthorised third parties will not be able to defeat our security and improperly collect, access, steal, or modify your information.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Text(
                  'Although we will do our best to protect your personal information, transmission of personal information to and from our Services is at your own risk. You should only access the Services within a secure environment.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 32),
            InfoSection(
              title: '8. DO WE COLLECT INFORMATION FROM MINORS?',
              shortDescription: 'We do not knowingly collect data from or market to children under 18 years of age.',
              children: [
                Text(
                  'We do not knowingly collect, solicit data from, or market to children under 18 years of age, nor do we knowingly sell such personal information. By using the Services, you represent that you are at least 18 or that you are the parent or guardian of such a minor and consent to such minor dependent\'s use of the Services. If we learn that personal information from users less than 18 years of age has been collected, we will deactivate the account and take reasonable measures to promptly delete such data from our records.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      const TextSpan(
                        text: 'If you become aware of any data we may have collected from children under age 18, please contact us at ',
                      ),
                      TextSpan(
                        text: 'parivartanx.info@gmail.com',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(text: '.'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            InfoSection(
              title: '9. WHAT ARE YOUR PRIVACY RIGHTS?',
              shortDescription: 'You may review, change, or terminate your account at any time, depending on your country, province, or state of residence.',
              children: [
                InfoSubSection(
                  title: 'Withdrawing your consent',
                  description: 'If we are relying on your consent to process your personal information, which may be express and/or implied consent depending on the applicable law, you have the right to withdraw your consent at any time. You can withdraw your consent at any time by contacting us by using the contact details provided in the section \'HOW CAN YOU CONTACT US ABOUT THIS NOTICE?\' below.\n\nHowever, please note that this will not affect the lawfulness of the processing before its withdrawal nor, when applicable law allows, will it affect the processing of your personal information conducted in reliance on lawful processing grounds other than consent.',
                  items: [],
                ),
                InfoSubSection(
                  title: 'Opting out of marketing and promotional communications',
                  description: 'You can unsubscribe from our marketing and promotional communications at any time by clicking on the unsubscribe link in the emails that we send, or by contacting us using the details provided in the section \'HOW CAN YOU CONTACT US ABOUT THIS NOTICE?\' below. You will then be removed from the marketing lists. However, we may still communicate with you — for example, to send you service-related messages that are necessary for the administration and use of your account, to respond to service requests, or for other non-marketing purposes.',
                  items: [],
                ),
                InfoSubSection(
                  title: 'Account Information',
                  description: 'If you would at any time like to review or change the information in your account or terminate your account, you can:',
                  items: [
                    'Log in to your account settings and update your user account.',
                    'Contact us using the contact information provided.',
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Upon your request to terminate your account, we will deactivate or delete your account and information from our active databases. However, we may retain some information in our files to prevent fraud, troubleshoot problems, assist with any investigations, enforce our legal terms and/or comply with applicable legal requirements.',
                  style: TextStyle(fontSize: 16),
                ),
                InfoSubSection(
                  title: 'Cookies and similar technologies',
                  description: 'Most Web browsers are set to accept cookies by default. If you prefer, you can usually choose to set your browser to remove cookies and to reject cookies. If you choose to remove cookies or reject cookies, this could affect certain features or services of our Services.',
                  items: [],
                ),
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      const TextSpan(
                        text: 'If you have questions or comments about your privacy rights, you may email us at ',
                      ),
                      TextSpan(
                        text: 'parivartanx.info@gmail.com',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(text: '.'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            InfoSection(
              title: '10. CONTROLS FOR DO-NOT-TRACK FEATURES',
              shortDescription: 'We currently do not respond to DNT browser signals.',
              children: [
                Text(
                  'Most web browsers and some mobile operating systems and mobile applications include a Do-Not-Track (\'DNT\') feature or setting you can activate to signal your privacy preference not to have data about your online browsing activities monitored and collected. At this stage, no uniform technology standard for recognising and implementing DNT signals has been finalised. As such, we do not currently respond to DNT browser signals or any other mechanism that automatically communicates your choice not to be tracked online. If a standard for online tracking is adopted that we must follow in the future, we will inform you about that practice in a revised version of this Privacy Notice.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 32),
            InfoSection(
              title: '11. DO WE MAKE UPDATES TO THIS NOTICE?',
              shortDescription: 'Yes, we will update this notice as necessary to stay compliant with relevant laws.',
              children: [
                Text(
                  'We may update this Privacy Notice from time to time. The updated version will be indicated by an updated \'Revised\' date at the top of this Privacy Notice. If we make material changes to this Privacy Notice, we may notify you either by prominently posting a notice of such changes or by directly sending you a notification. We encourage you to review this Privacy Notice frequently to be informed of how we are protecting your information.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 32),
            InfoSection(
              title: '12. HOW CAN YOU CONTACT US ABOUT THIS NOTICE?',
              shortDescription: 'You can contact us by email or post if you have any questions about this notice.',
              children: [
                Text(
                  'If you have questions or comments about this notice, you may email us at parivartanx.info@gmail.com or contact us by post at:',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: context.colorScheme.outline.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Parivartan X\n\nShadalichak Patna\nDariyapur Brajeshwar market\nPatna, Bihar 804453\nIndia',
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            InfoSection(
              title: '13. HOW CAN YOU REVIEW, UPDATE, OR DELETE THE DATA WE COLLECT FROM YOU?',
              shortDescription: 'You have the right to request access to, update, or delete your personal information.',
              children: [
                Text(
                  'Based on the applicable laws of your country, you may have the right to request access to the personal information we collect from you, details about how we have processed it, correct inaccuracies, or delete your personal information. You may also have the right to withdraw your consent to our processing of your personal information. These rights may be limited in some circumstances by applicable law.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Text(
                  'To request to review, update, or delete your personal information, please visit:',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'https://hamaraticket.com/contact-us',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildOptOutLink(BuildContext context, String title, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            Icons.arrow_right,
            size: 20,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: url,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}