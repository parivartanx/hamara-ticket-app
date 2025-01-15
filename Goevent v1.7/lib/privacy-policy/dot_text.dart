import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';
import 'package:hamaraticket/providers/color_provider.dart';

class DotText extends ConsumerWidget {
  final String text;
  const DotText({super.key,required this.text});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(colorProvider);
    return Padding(
      padding:  EdgeInsets.only(bottom: context.height*.01),
      child: Row(children: [
                Icon(Icons.circle,size:context.width*.02,color: notifier.buttonColor ,),
                SizedBox(width: context.width*.02,),
                Expanded(child: Text(text,style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600),)),
      
              ],),
    );
  }
}