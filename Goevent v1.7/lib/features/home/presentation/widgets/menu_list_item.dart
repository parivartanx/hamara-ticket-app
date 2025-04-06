import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/extensions/media_query_ext.dart';

class MenuListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const MenuListItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        title: Row(
          children: [
            Icon(
              icon,
              size: context.height * .025,
            ),
            // Image.asset(
            //   icon,
            //   height: context.height / 30,
            // ),
            SizedBox(
              width: context.width * .02,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontFamily: 'Gilroy Medium',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
