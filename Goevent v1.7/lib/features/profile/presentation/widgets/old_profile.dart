// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:page_transition/page_transition.dart';
// import 'dart:ui';

// import '../../editprofile.dart';
// import '/extensions/media_query_ext.dart';
// import '/providers/color_provider.dart';
// import '/utils/string.dart';
// import '/models/user_model.dart';

// class Profile extends ConsumerStatefulWidget {
//   const Profile({Key? key}) : super(key: key);

//   @override
//   _ProfileState createState() => _ProfileState();
// }

// class _ProfileState extends ConsumerState<Profile> with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;

//   // Dummy user data - in a real app, this would come from your user provider or repository
//   final User user = User(
//     id: '1',
//     name: 'Vinita Bharti',
//     email: 'vinita@example.com',
//     phone: '+91 9876543210',
//   );

//   final List<InterestItem> interests = [
//     InterestItem(name: 'Games Online', color: const Color(0xff5669FF)),
//     InterestItem(name: 'Concert', color: const Color(0xffEE544A)),
//     InterestItem(name: 'Music', color: const Color(0xffFF8D5D)),
//     InterestItem(name: 'Art', color: const Color(0xff7D67EE)),
//     InterestItem(name: 'Movie', color: const Color(0xff29D697)),
//     InterestItem(name: 'Sports', color: const Color(0xff39D1F2)),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     ref.read(colorProvider.notifier).getdarkmodepreviousstate();
    
//     // Initialize animation controller
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
    
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeInOut,
//       ),
//     );
    
//     _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeOutCubic,
//       ),
//     );
    
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final primaryColor = ref.watch(colorProvider).primaryColor;
//     final darksColor = ref.watch(colorProvider).darksColor;
//     final buttonsColor = ref.watch(colorProvider).buttonsColor;
//     final textColor = ref.watch(colorProvider).textColor;
//     final height = context.height;
//     final width = context.width;
    
//     return ScreenUtilInit(
//       builder: (BuildContext context, child) => Scaffold(
//         backgroundColor: primaryColor,
//         body: CustomScrollView(
//           physics: const BouncingScrollPhysics(),
//           slivers: [
//             // Custom app bar with profile background
//             SliverToBoxAdapter(
//               child: ProfileHeader(
//                 user: user,
//                 darksColor: darksColor,
//                 height: height,
//                 width: width,
//                 fadeAnimation: _fadeAnimation,
//                 slideAnimation: _slideAnimation,
//               ),
//             ),
            
//             // Statistics section
//             SliverToBoxAdapter(
//               child: FadeTransition(
//                 opacity: _fadeAnimation,
//                 child: SlideTransition(
//                   position: _slideAnimation,
//                   child: ProfileStats(
//                     height: height,
//                     width: width,
//                     darksColor: darksColor,
//                   ),
//                 ),
//               ),
//             ),
            
//             // Edit profile button
//             SliverToBoxAdapter(
//               child: FadeTransition(
//                 opacity: _fadeAnimation,
//                 child: SlideTransition(
//                   position: _slideAnimation,
//                   child: ProfileEditButton(
//                     height: height,
//                     width: width,
//                     buttonsColor: buttonsColor,
//                   ),
//                 ),
//               ),
//             ),
            
//             // About section
//             SliverToBoxAdapter(
//               child: FadeTransition(
//                 opacity: _fadeAnimation,
//                 child: SlideTransition(
//                   position: _slideAnimation,
//                   child: ProfileAboutSection(
//                     height: height,
//                     textColor: textColor,
//                   ),
//                 ),
//               ),
//             ),
            
//             // Interests section
//             SliverToBoxAdapter(
//               child: FadeTransition(
//                 opacity: _fadeAnimation,
//                 child: SlideTransition(
//                   position: _slideAnimation,
//                   child: ProfileInterestSection(
//                     height: height,
//                     width: width,
//                     textColor: textColor,
//                     buttonsColor: buttonsColor,
//                     pinkColor: const Color(0xFFFCE5EA),
//                     interests: interests,
//                   ),
//                 ),
//               ),
//             ),
            
//             // Bottom padding
//             SliverToBoxAdapter(
//               child: SizedBox(height: height / 15),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Class for interest items
// class InterestItem {
//   final String name;
//   final Color color;
  
//   InterestItem({required this.name, required this.color});
// }

// // Profile header section
// class ProfileHeader extends StatelessWidget {
//   final User user;
//   final Color darksColor;
//   final double height;
//   final double width;
//   final Animation<double> fadeAnimation;
//   final Animation<Offset> slideAnimation;

//   const ProfileHeader({
//     Key? key,
//     required this.user,
//     required this.darksColor,
//     required this.height,
//     required this.width,
//     required this.fadeAnimation,
//     required this.slideAnimation,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     String greeting = _getGreeting();
    
//     return Container(
//       height: height * 0.35,
//       width: width,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [Colors.blue.shade700, Colors.blue.shade500],
//         ),
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(40),
//           bottomRight: Radius.circular(40),
//         ),
//       ),
//       child: Stack(
//         children: [
//           // Background pattern
//           Positioned.fill(
//             child: ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(40),
//                 bottomRight: Radius.circular(40),
//               ),
//               child: Opacity(
//                 opacity: 0.2,
//                 child: Image.asset(
//                   "assets/image/pattern.png",
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
          
//           // Actual content
//           Column(
//             children: [
//               // Top bar with back button
//               Padding(
//                 padding: EdgeInsets.only(
//                   top: height / 16,
//                   left: width / 20,
//                   right: width / 20,
//                 ),
//                 child: Row(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.2),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: const Icon(
//                           Icons.arrow_back,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: width / 25),
//                     Text(
//                       "Profile",
//                       style: TextStyle(
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
              
//               // Profile avatar and user info
//               Expanded(
//                 child: FadeTransition(
//                   opacity: fadeAnimation,
//                   child: SlideTransition(
//                     position: slideAnimation,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Greeting
//                         Text(
//                           greeting,
//                           style: TextStyle(
//                             fontSize: 15.sp,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.white.withOpacity(0.9),
//                           ),
//                         ),
//                         SizedBox(height: height / 60),
                        
//                         // Avatar
//                         Hero(
//                           tag: 'profile_image',
//                           child: Container(
//                             height: width * 0.25,
//                             width: width * 0.25,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(color: Colors.white, width: 3),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.2),
//                                   spreadRadius: 2,
//                                   blurRadius: 8,
//                                   offset: const Offset(0, 4),
//                                 ),
//                               ],
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(100),
//                               child: Image.asset(
//                                 "assets/image/p2.png",
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: height / 60),
                        
//                         // User name
//                         Text(
//                           user.name,
//                           style: TextStyle(
//                             fontSize: 22.sp,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
                        
//                         // User email
//                         Text(
//                           user.email,
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.white.withOpacity(0.9),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   String _getGreeting() {
//     final hour = DateTime.now().hour;
//     if (hour < 12) {
//       return "Good Morning, ${user.name.split(' ').first}";
//     } else if (hour < 17) {
//       return "Good Afternoon, ${user.name.split(' ').first}";
//     } else {
//       return "Good Evening, ${user.name.split(' ').first}";
//     }
//   }
// }

// // Profile stats section
// class ProfileStats extends StatelessWidget {
//   final double height;
//   final double width;
//   final Color darksColor;

//   const ProfileStats({
//     Key? key,
//     required this.height,
//     required this.width,
//     required this.darksColor,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(
//         horizontal: width / 15,
//         vertical: height / 30,
//       ),
//       padding: EdgeInsets.symmetric(
//         horizontal: width / 25,
//         vertical: height / 50,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           _buildStatItem(context, "350", "Following"),
//           _buildDivider(),
//           _buildStatItem(context, "346", "Followers"),
//           _buildDivider(),
//           _buildStatItem(context, "42", "Events"),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatItem(BuildContext context, String count, String label) {
//     return Column(
//       children: [
//         Text(
//           count,
//           style: TextStyle(
//             fontSize: 18.sp,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Gilroy Medium',
//             color: darksColor,
//           ),
//         ),
//         SizedBox(height: 10),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 13.sp,
//             fontFamily: 'Gilroy Medium',
//             color: Colors.grey,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDivider() {
//     return Container(
//       height: 20,
//       width: 1,
//       color: Colors.grey.withOpacity(0.3),
//     );
//   }
// }

// // Profile edit button
// class ProfileEditButton extends StatelessWidget {
//   final double height;
//   final double width;
//   final Color buttonsColor;

//   const ProfileEditButton({
//     Key? key,
//     required this.height,
//     required this.width,
//     required this.buttonsColor,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             PageTransition(
//               type: PageTransitionType.fade,
//               child: const Edit(),
//             ),
//           );
//         },
//         child: Container(
//           height: height / 15,
//           width: width / 2.2,
//           decoration: BoxDecoration(
//             color: buttonsColor,
//             borderRadius: BorderRadius.circular(15),
//             boxShadow: [
//               BoxShadow(
//                 color: buttonsColor.withOpacity(0.3),
//                 blurRadius: 10,
//                 offset: const Offset(0, 5),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.edit_outlined,
//                 color: Colors.white,
//                 size: 18.sp,
//               ),
//               SizedBox(width: width / 40),
//               Text(
//                 "Edit Profile",
//                 style: TextStyle(
//                   fontSize: 15.sp,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Profile about section
// class ProfileAboutSection extends StatefulWidget {
//   final double height;
//   final Color textColor;

//   const ProfileAboutSection({
//     Key? key,
//     required this.height,
//     required this.textColor,
//   }) : super(key: key);

//   @override
//   State<ProfileAboutSection> createState() => _ProfileAboutSectionState();
// }

// class _ProfileAboutSectionState extends State<ProfileAboutSection> {
//   bool _expanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: 20,
//         vertical: widget.height / 30,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             CustomStrings.about,
//             style: TextStyle(
//               fontSize: 18.sp,
//               fontWeight: FontWeight.w700,
//               fontFamily: 'Gilroy Medium',
//               color: widget.textColor,
//             ),
//           ),
//           SizedBox(height: widget.height / 60),
//           AnimatedCrossFade(
//             firstChild: Text(
//               CustomStrings.readmore,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 fontSize: 15.sp,
//                 fontWeight: FontWeight.w500,
//                 height: 1.5,
//                 fontFamily: 'Gilroy Medium',
//                 color: widget.textColor.withOpacity(0.7),
//               ),
//             ),
//             secondChild: Text(
//               CustomStrings.readmore,
//               style: TextStyle(
//                 fontSize: 15.sp,
//                 fontWeight: FontWeight.w500,
//                 height: 1.5,
//                 fontFamily: 'Gilroy Medium',
//                 color: widget.textColor.withOpacity(0.7),
//               ),
//             ),
//             crossFadeState: _expanded 
//                 ? CrossFadeState.showSecond 
//                 : CrossFadeState.showFirst,
//             duration: const Duration(milliseconds: 300),
//           ),
//           SizedBox(height: widget.height / 80),
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 _expanded = !_expanded;
//               });
//             },
//             child: Text(
//               _expanded ? "Show Less" : "Read More",
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.blue,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Profile interest section
// class ProfileInterestSection extends StatelessWidget {
//   final double height;
//   final double width;
//   final Color textColor;
//   final Color buttonsColor;
//   final Color pinkColor;
//   final List<InterestItem> interests;

//   const ProfileInterestSection({
//     Key? key,
//     required this.height,
//     required this.width,
//     required this.textColor,
//     required this.buttonsColor,
//     required this.pinkColor,
//     required this.interests,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(
//                 CustomStrings.interest,
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.w700,
//                   fontFamily: 'Gilroy Medium',
//                   color: textColor,
//                 ),
//               ),
//               const Spacer(),
//               Container(
//                 height: height / 25,
//                 padding: EdgeInsets.symmetric(horizontal: width / 25),
//                 decoration: BoxDecoration(
//                   color: pinkColor,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.edit_outlined,
//                       color: buttonsColor,
//                       size: 16.sp,
//                     ),
//                     SizedBox(width: width / 60),
//                     Text(
//                       "CHANGE",
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.w700,
//                         fontFamily: 'Gilroy Medium',
//                         color: buttonsColor,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: height / 40),
          
//           // Interests chips
//           Wrap(
//             spacing: width / 25,
//             runSpacing: height / 60,
//             children: interests.map((interest) {
//               return _buildInterestChip(interest);
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInterestChip(InterestItem interest) {
//     return Container(
//       height: height * .05,
//       padding: EdgeInsets.symmetric(horizontal: width / 20),
//       decoration: BoxDecoration(
//         color: interest.color,
//         borderRadius: BorderRadius.circular(25),
//         boxShadow: [
//           BoxShadow(
//             color: interest.color.withOpacity(0.3),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             _getIconForInterest(interest.name),
//             color: Colors.white,
//             size: 18.sp,
//           ),
//           SizedBox(width: width / 60),
//           Text(
//             interest.name,
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w600,
//               color: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   IconData _getIconForInterest(String interest) {
//     switch (interest.toLowerCase()) {
//       case 'games online':
//         return Icons.games;
//       case 'concert':
//         return Icons.music_note;
//       case 'music':
//         return Icons.headphones;
//       case 'art':
//         return Icons.palette;
//       case 'movie':
//         return Icons.movie;
//       case 'sports':
//         return Icons.sports_basketball;
//       default:
//         return Icons.interests;
//     }
//   }
// }
