import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/privacy-policy/dot_text.dart';
import '/providers/color_provider.dart';
import '/utils/custom_appbar.dart';

import 'bullet_points.dart';
import 'definition_item.dart';
import 'section_title.dart';
import 'sub_section_title.dart';

class PrivacyPolicy extends ConsumerWidget {
  static const String routePath= "/privacy-policy";
  static const String routeName = "PrivacyPolicy";
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(colorProvider);
    return ScreenUtilInit(
      builder: (context,child) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width*.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                const CustomAppbar(title: "Privacy Policy"),
                SizedBox(height: context.height*.04,),
                 Text(
                'Privacy Policy',
                style: TextStyle(
                  color: notifier.buttonColor,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'Last updated: January 14, 2025\n\nThis Privacy Policy describes Our policies and procedures on the collection, use, and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.\n\nWe use Your Personal Data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy.',
                style: TextStyle(fontSize: 14.sp, height: 1.5.h),
              ),
              
              SizedBox(height: 20.h),
              const SectionTitle(title: 'Interpretation and Definitions'),
              SizedBox(height: 10.h),
              const SectionTitle(title: 'Interpretation', isSubsection: true),
              Text(
                'The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.',
                style: TextStyle(fontSize: 14.sp, height: 1.5.h),
              ),
              SizedBox(height: 20.h),
              const SectionTitle(title: 'Definitions', isSubsection: true),
              SizedBox(height: 10.h),
              const DefinitionItem(
                term: 'Account',
                description: 'A unique account created for You to access our Service or parts of our Service.',
              ),
              DefinitionItem(
                term: 'Affiliate',
                description:
                    'An entity that controls, is controlled by or is under common control with a party.',
              ),
              DefinitionItem(
                term: 'Application',
                description: 'Hamara Ticket, the software program provided by the Company.',
              ),
              DefinitionItem(
                term: 'Company',
                description: 'ParivartanX, located in Patna, Bihar, India.',
              ),
              DefinitionItem(
                term: 'Cookies',
                description: 'Small files placed on Your device, containing browsing history details.',
              ),
              DefinitionItem(
                term: 'Country',
                description: 'Bihar, India.',
              ),
              DefinitionItem(
                term: 'Device',
                description:
                    'Any device that can access the Service such as a computer, cellphone, or tablet.',
              ),
              DefinitionItem(
                term: 'Personal Data',
                description: 'Any information that relates to an identified or identifiable individual.',
              ),
              DefinitionItem(
                term: 'Service',
                description: 'The Application or the Website or both.',
              ),
              DefinitionItem(
                term: 'Service Provider',
                description:
                    'Third-party companies or individuals employed to facilitate the Service.',
              ),
              DefinitionItem(
                term: 'Website',
                description: 'Hamara Ticket, accessible from https://hamaraticket.com.',
              ),
              DefinitionItem(
                term: 'You',
                description:
                    'The individual accessing or using the Service, or the company, or other legal entity.',
              ),
              SizedBox(height: 20.h),
            SectionTitle(title: 'Collecting and Using Your Personal Data'),
            SizedBox(height: 10.h),
            SectionTitle(title: 'Types of Data Collected', isSubsection: true),
            SizedBox(height: 10.h),
            SectionTitle(title: 'Personal Data', isSubsection: true),
            Text(
              'While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to:',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 10.h),
            const DotText(text: "Email Address"),
            const DotText(text: "First name and last name"),
            const DotText(text: "Phone number"),
            const DotText(text: "Address, State, Province, ZIP/Postal code, City"),
            SizedBox(height: 20.h),
            const SectionTitle(title: 'Usage Data', isSubsection: true),
            Text(
              'Usage Data is collected automatically when using the Service.\n\nUsage Data may include information such as Your Device\'s Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on those pages, unique device identifiers and other diagnostic data.\n\nWhen You access the Service by or through a mobile device, We may collect certain information automatically, including, but not limited to, the type of mobile device You use, Your mobile device unique ID, the IP address of Your mobile device, Your mobile operating system, the type of mobile Internet browser You use, unique device identifiers and other diagnostic data.\n\nWe may also collect information that Your browser sends whenever You visit our Service or when You access the Service by or through a mobile device.',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 20.h,),
            SectionTitle(title: 'Information from Third-Party Social Media Services'),
            SizedBox(height: 10.h),
            Text(
              'The Company allows You to create an account and log in to use the Service through the following Third-party Social Media Services:',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 10.h),
            DotText(text: 'Google',),
            DotText(text: 'Facebook', ),
            DotText(text: 'Instagram',),
            DotText(text: 'Twitter',),
            DotText(text: 'LinkedIn',),
            SizedBox(height: 10.h),
            Text(
              'If You decide to register through or otherwise grant us access to a Third-Party Social Media Service, We may collect Personal Data that is already associated with Your account, such as Your name, email address, activities, or contact list. You may also have the option of sharing additional information, giving the Company permission to use, share, and store it as per this Privacy Policy.',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 20.h),
            SectionTitle(title: 'Information Collected while Using the Application'),
            SizedBox(height: 10.h),
            Text(
              'While using Our Application, in order to provide features of Our Application, We may collect, with Your prior permission:',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 10.h),
            DotText(text: 'Information regarding your location', ),
            DotText(
              text: 'Pictures and other information from your Device\'s camera and photo library',
            ),
            SizedBox(height: 10.h),
            Text(
              'We use this information to provide features of Our Service and to improve and customize it. The information may be uploaded to the Company\'s servers and/or a Service Provider\'s server, or it may be stored on Your device. You can enable or disable access to this information at any time through Your Device settings.',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 20.h),
            SectionTitle(title: 'Tracking Technologies and Cookies'),
            SizedBox(height: 10.h),
            Text(
              'We use Cookies and similar tracking technologies to track activity on Our Service and store certain information. These technologies include:',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 10.h),
            DefinitionItem(term: 'Cookies or Browser Cookies', description: 'Small files placed on Your Device to track activity.'),
            DefinitionItem(term: 'Web Beacons', description: 'Small electronic files (e.g., clear gifs, pixel tags) to count users and record statistics.'),
            SizedBox(height: 10.h),
            Text(
              'Cookies can be "Persistent" or "Session" Cookies. Persistent Cookies remain on Your computer or device when offline, while Session Cookies are deleted when You close Your browser.',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 10.h),
            SectionTitle(title: 'Types of Cookies Used', isSubsection: true),
            SizedBox(height: 10.h),
            DefinitionItem(
              term: 'Necessary / Essential Cookies',
              description: 'Session Cookies administered by Us to enable core services and features.',
            ), 
            Text("Purpose: These Cookies are essential to provide You with services available through the Website and to enable You to use some of its features. They help to authenticate users and prevent fraudulent use of user accounts. Without these Cookies, the services that You have asked for cannot be provided, and We only use these Cookies to provide You with those services."),
            DefinitionItem(
              term: 'Cookies Policy / Notice Acceptance Cookies',
              description: 'Persistent Cookies to identify if users have accepted cookies.',
            ),
            Text("Purpose: These Cookies identify if users have accepted the use of cookies on the Website."),
            DefinitionItem(
              term: 'Functionality Cookies',
              description: 'Persistent Cookies to remember preferences like login details or language settings.',
            ),
            Text("Purpose: These Cookies allow us to remember choices You make when You use the Website, such as remembering your login details or language preference. The purpose of these Cookies is to provide You with a more personal experience and to avoid You having to re-enter your preferences every time You use the Website."),
            SizedBox(height: 10.h),
            Text(
              'For more information about the cookies we use and your choices regarding cookies, please visit our Cookies Policy or the Cookies section of our Privacy Policy.',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SectionTitle(title: 'Use of Your Personal Data'),
            SizedBox(height: 10.h),
            Text(
              'The Company may use Personal Data for the following purposes:',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 10.h),
            DefinitionItem(
              term: 'To provide and maintain our Service',
              description:
                  'Including to monitor the usage of our Service.',
            ),
            DefinitionItem(
              term: 'To manage Your Account',
              description:
                  'To manage Your registration as a user of the Service. The Personal Data You provide can give You access to different functionalities of the Service that are available to You as a registered user.',
            ),
            DefinitionItem(
              term: 'For the performance of a contract',
              description:
                  'The development, compliance, and undertaking of the purchase contract for the products, items, or services You have purchased or any other contract with Us through the Service.',
            ),
            DefinitionItem(
              term: 'To contact You',
              description:
                  'To contact You by email, telephone calls, SMS, or other equivalent forms of electronic communication, such as push notifications, regarding updates or informative communications related to functionalities, products, or contracted services.',
            ),
            DefinitionItem(
              term: 'To provide You with news and special offers',
              description:
                  'To provide You with general information about other goods, services, and events which we offer that are similar to those you have already purchased or enquired about unless You have opted not to receive such information.',
            ),
            DefinitionItem(
              term: 'To manage Your requests',
              description: 'To attend and manage Your requests to Us.',
            ),
            DefinitionItem(
              term: 'For business transfers',
              description:
                  'We may use Your information to evaluate or conduct a merger, divestiture, restructuring, reorganization, dissolution, or other sale or transfer of some or all of Our assets in which Personal Data held by Us is among the assets transferred.',
            ),
            DefinitionItem(
              term: 'For other purposes',
              description:
                  'We may use Your information for purposes such as data analysis, identifying usage trends, determining the effectiveness of our promotional campaigns, and improving our Service, products, services, and marketing.',
            ),
            SizedBox(height: 20.h),
            SectionTitle(title: 'Sharing Your Personal Data'),
            SizedBox(height: 10.h),
            Text(
              'We may share Your personal information in the following situations:',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 10.h),
            DefinitionItem(
              term: 'With Service Providers',
              description:
                  'We may share Your personal information with Service Providers to monitor and analyze the use of our Service or to contact You.',
            ),
            DefinitionItem(
              term: 'For business transfers',
              description:
                  'We may share or transfer Your personal information in connection with, or during negotiations of, any merger, sale of Company assets, financing, or acquisition of Our business by another company.',
            ),
            DefinitionItem(
              term: 'With Affiliates',
              description:
                  'We may share Your information with Our affiliates. Affiliates include Our parent company and any subsidiaries, joint venture partners, or other companies under common control with Us.',
            ),
            DefinitionItem(
              term: 'With business partners',
              description:
                  'We may share Your information with Our business partners to offer You certain products, services, or promotions.',
            ),
            DefinitionItem(
              term: 'With other users',
              description:
                  'When You share personal information in public areas, it may be viewed by all users. If You interact with other users through a Third-Party Social Media Service, Your contacts may see details like Your profile and activity.',
            ),
            DefinitionItem(
              term: 'With Your consent',
              description:
                  'We may disclose Your personal information for any other purpose with Your consent.',
            ),
            SizedBox(height: 20.h),
            SectionTitle(title: 'Retention of Your Personal Data'),
            SizedBox(height: 10.h),
            Text(
              'The Company will retain Your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use Your Personal Data to the extent necessary to comply with our legal obligations (for example, if we are required to retain your data to comply with applicable laws), resolve disputes, and enforce our legal agreements and policies.',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 10.h),
            Text(
              'The Company will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period of time, except when this data is used to strengthen the security or to improve the functionality of Our Service, or We are legally obligated to retain this data for longer time periods.',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 20.h),
            SectionTitle(title: 'Transfer of Your Personal Data'),
            SizedBox(height: 10.h),
            Text(
              'Your information, including Personal Data, is processed at the Company\'s operating offices and in any other places where the parties involved in the processing are located. This means that Your information may be transferred to — and maintained on — computers located outside of Your state, province, country or other governmental jurisdiction where the data protection laws may differ from those in Your jurisdiction.',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 10.h),
            Text(
              'Your consent to this Privacy Policy followed by Your submission of such information represents Your agreement to that transfer.',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 10.h),
            Text(
              'The Company will take all steps reasonably necessary to ensure that Your data is treated securely and in accordance with this Privacy Policy. No transfer of Your Personal Data will take place to an organization or a country unless there are adequate controls in place, including the security of Your data and other personal information.',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 20.h,),
            SectionTitle(title: 'Delete Your Personal Data'),
            SizedBox(height: 10.h),
            Text(
              'You have the right to delete or request that We assist in deleting the Personal Data that We have collected about You.',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 10.h),
            Text(
              'Our Service may give You the ability to delete certain information about You from within the Service.',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 10.h),
            Text(
              'You may update, amend, or delete Your information at any time by signing in to Your Account, if you have one, and visiting the account settings section that allows you to manage Your personal information. You may also contact Us to request access to, correct, or delete any personal information that You have provided to Us.',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 10.h),
            Text(
              'Please note, however, that We may need to retain certain information when we have a legal obligation or lawful basis to do so.',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),

            SizedBox(height: 20.h),
            SectionTitle(title: 'Disclosure of Your Personal Data'),
            SizedBox(height: 10.h),
            SubSectionTitle(title: 'Business Transactions'),
            Text(
              'If the Company is involved in a merger, acquisition, or asset sale, Your Personal Data may be transferred. We will provide notice before Your Personal Data is transferred and becomes subject to a different Privacy Policy.',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 10.h),
            SubSectionTitle(title: 'Law Enforcement'),
            Text(
              'Under certain circumstances, the Company may be required to disclose Your Personal Data if required to do so by law or in response to valid requests by public authorities (e.g., a court or a government agency).',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 10.h),
            SubSectionTitle(title: 'Other Legal Requirements'),
            Text(
              'The Company may disclose Your Personal Data in the good faith belief that such action is necessary to:',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 10.h),
            const BulletPoints(points: [
              'Comply with a legal obligation.',
              'Protect and defend the rights or property of the Company.',
              'Prevent or investigate possible wrongdoing in connection with the Service.',
              'Protect the personal safety of Users of the Service or the public.',
              'Protect against legal liability.',
            ]),

            SizedBox(height: 20.h),
            SectionTitle(title: 'Security of Your Personal Data'),
            SizedBox(height: 10.h),
            Text(
              'The security of Your Personal Data is important to Us, but remember that no method of transmission over the Internet, or method of electronic storage, is 100% secure. While We strive to use commercially acceptable means to protect Your Personal Data, We cannot guarantee its absolute security.',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 20.h),
            SectionTitle(title: 'Children’s Privacy'),
            SizedBox(height: 10.h),
            Text(
              'Our Service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from anyone under the age of 13. If You are a parent or guardian and You are aware that Your child has provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data from anyone under the age of 13 without verification of parental consent, We take steps to remove that information from Our servers.',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 10.h),
            Text(
              'If We need to rely on consent as a legal basis for processing Your information and Your country requires consent from a parent, We may require Your parent’s consent before We collect and use that information.',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),

            SizedBox(height: 20.h),
            SectionTitle(title: 'Links to Other Websites'),
            SizedBox(height: 10.h),
            Text(
              'Our Service may contain links to other websites that are not operated by Us. If You click on a third party link, You will be directed to that third party’s site. We strongly advise You to review the Privacy Policy of every site You visit.',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 10.h),
            Text(
              'We have no control over and assume no responsibility for the content, privacy policies, or practices of any third party sites or services.',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),

            SizedBox(height: 20.h),
            SectionTitle(title: 'Changes to this Privacy Policy'),
            SizedBox(height: 10.h),
            Text(
              'We may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page.',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 10.h),
            Text(
              'We will let You know via email and/or a prominent notice on Our Service, prior to the change becoming effective and update the "Last updated" date at the top of this Privacy Policy.',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 10.h),
            Text(
              'You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),

            SizedBox(height: 20.h),
            SectionTitle(title: 'Contact Us'),
            SizedBox(height: 10.h),
            Text(
              'If you have any questions about this Privacy Policy, You can contact us:',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
            SizedBox(height: 10.h),
            BulletPoints(points: [
              'By email: parivartanx.info@gmail.com',
              'By visiting this page on our website: https://hamaraticket.com/contact-us',
              'By phone number: 09060924752',
            ]),

            SizedBox(height: 20.h),

              ],),
            ),
          ),
        ),
      ),
    );
  }
}