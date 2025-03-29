import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamaraticket/extensions/media_query_ext.dart';
import '../widgets/event_card.dart';
import '/models/park/park_model.dart';
import '../../../../models/event/event_model.dart';
import '../widgets/park_card.dart';
import '/features/home/presentation/providers/nearby_events_provider.dart';
import '/features/home/presentation/widgets/category_chips.dart';

class NearBySeeAll extends ConsumerStatefulWidget {
  const NearBySeeAll({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NearBySeeAllState();
}

class _NearBySeeAllState extends ConsumerState<NearBySeeAll> {

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(nearbyEventsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("All", style: context.textTheme.bodyLarge,),
        backgroundColor: context.colorScheme.surface,
        foregroundColor: context.colorScheme.onSurface,
      ),
      body: Column(children: [
        const CategoryChips(),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
          itemCount:state.filteredItems.length ,
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,crossAxisSpacing:5.w,mainAxisSpacing: 10.h,mainAxisExtent: context.height*.25 ), 
          itemBuilder: (context,index) {
            if (state.selectedType == OccasionType.events) {
          return EventCard(event: state.filteredItems[index] as Event);
        } else if(state.selectedType == OccasionType.waterPark) {
          return ParkCard(park: state.filteredItems[index] as Park);
        }
        else {
          return ParkCard(park: state.filteredItems[index] as Park);
        }
          }))
      ],),
    );
  }
}
