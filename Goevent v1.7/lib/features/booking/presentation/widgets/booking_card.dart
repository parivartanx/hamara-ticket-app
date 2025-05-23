import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../extensions/media_query_ext.dart';
import '../../../../models/booking/booking_model.dart';
import 'qr_ticket_dialog.dart';
import 'ticket_type_list_item.dart';

class BookingCard extends StatefulWidget {
  final BookingModel booking;
  final double animationDelay;

  const BookingCard({
    Key? key,
    required this.booking,
    required this.animationDelay,
  }) : super(key: key);

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    Future.delayed(
        Duration(milliseconds: (widget.animationDelay * 1000).toInt()), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('dd MMM yyyy');
    final DateFormat dayFormat = DateFormat('E');
    final DateFormat timeFormat = DateFormat('hh:mm a');
    final colorScheme = context.colorScheme;

    // Determine badge color based on category
    Color getCategoryColor() {
      if (widget.booking.eventId != null) {
        return colorScheme.primary;
      } else {
        return Colors.green;
      }
    }

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Material(
              elevation: 0,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: context.colorScheme.outlineVariant.withAlpha(80),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top section with ticket-like effect
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                      ),
                      child: Stack(
                        children: [
                          // Gradient background
                          Container(
                            height: 80.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  getCategoryColor().withAlpha(30),
                                  getCategoryColor().withAlpha(30),
                                ],
                              ),
                            ),
                          ),

                          // Decorative circles for ticket appearance
                          
                         
                          // Ticket content
                          Padding(
                            padding: EdgeInsets.all(16.r),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Date circle
                                Container(
                                  width: 48.w,
                                  height: 48.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: context.colorScheme.surfaceContainerLowest,
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.black.withOpacity(0.1),
                                    //     blurRadius: 4,
                                    //     offset: const Offset(0, 2),
                                    //   },
                                    // ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget.booking.date.day.toString(),
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        dayFormat
                                            .format(widget.booking.date)
                                            .substring(0, 3),
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500,
                                          // color: getCategoryColor(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 12.w),

                                // Event details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${widget.booking.eventId==null ? widget.booking.park?.name : widget.booking.event?.name}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time_rounded,
                                            size: 14.sp,
                                            ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            timeFormat.format(
                                                widget.booking.date),
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                                 ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // Status badge
                                if (widget.booking.status.toLowerCase() == 'used')
                                  Transform.rotate(
                                    angle: 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 4.h),
                                      decoration: BoxDecoration(
                                        color: context.colorScheme.surfaceContainerLowest,
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                context.colorScheme.outlineVariant,
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        'USED',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                          color: context.colorScheme.outline,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    
                    // Dashed line and punched circles for ticket effect
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.h),
                          child: Row(
                            children: List.generate(
                              30,
                              (index) => Expanded(
                                child: Container(
                                  height: 1,
                                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                                  color: context.colorScheme.outlineVariant.withAlpha(120),
                                ),
                              ),
                            ),
                          ),
                        ),
                        
                      ],
                    ),

                    // Bottom section with more details
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Ticket Type',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: context.colorScheme.outline,
                                          ),
                                        ),
                                        
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Quantity',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: context.colorScheme.outline,
                                          ),
                                        ),
                                        
                                      ],
                                    ),
                                  ],
                                ),
                                ...widget.booking.getTicketTypeWithQuantity().map((ticketInfo) => 
                                    TicketTypeListItem(
                                      ticketType: ticketInfo.ticketType,
                                      quantity: ticketInfo.quantity,
                                      getCategoryColor: () => getCategoryColor(),
                                    ),
                                  ).toList(),
                                  
                                
                              ],
                            ),
                          ),

                          // Expandable section
                          if (_isExpanded) ...[
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.all(16.r),
                              padding: EdgeInsets.all(12.r),
                              decoration: BoxDecoration(
                                color:
                                    colorScheme.secondaryContainer.withAlpha(50),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.confirmation_number_outlined,
                                        size: 16.sp,
                                        color:context.colorScheme.outline,
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: Text(
                                          'Booking ID: ${widget.booking.id}',
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: context.colorScheme.outline,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.h),
                                  
                                  // All Ticket Types and Quantities - New Section
                                  Text(
                                    'Tickets Information:',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: context.colorScheme.onSurface,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  
                                  // Display all ticket types with quantities using the updated function
                                  ...widget.booking.getTicketTypeWithQuantity().map((ticketInfo) => 
                                    TicketTypeListItem(
                                      ticketType: ticketInfo.ticketType,
                                      quantity: ticketInfo.quantity,
                                      getCategoryColor: () => getCategoryColor(),
                                    ),
                                  ).toList(),
                                  
                                  SizedBox(height: 8.h),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today_outlined,
                                        size: 16.sp,
                                        color: context.colorScheme.outline,
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: Text(
                                          'Date: ${dateFormat.format(widget.booking.eventId==null ? widget.booking.date : DateTime.parse((widget.booking.event?.startDate ?? '').toString()))}',
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: context.colorScheme.outline,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.h),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.category_outlined,
                                        size: 16.sp,
                                        color:context.colorScheme.outline,
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: Text(
                                          'Category: ${widget.booking.eventId==null ? widget.booking.park?.type : "Event"}',
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: context.colorScheme.outline,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Action buttons
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 16.w, right: 16.w, bottom: 16.h),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: getCategoryColor(),
                                        side: BorderSide(
                                          color: getCategoryColor()
                                              .withOpacity(0.5),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                      ),
                                      icon: Icon(
                                        Icons.qr_code_scanner,
                                        size: 18.sp,
                                        color: context.colorScheme.secondary,
                                      ),
                                      label: Text(
                                        'Show QR',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      onPressed: () {
                                        // Show QR code
                                        showDialog(
                                          context: context,
                                          builder: (context) => QRTicketDialog(
                                            booking: widget.booking,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: getCategoryColor(),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                      ),
                                      icon: Icon(
                                        Icons.share_outlined,
                                        size: 18.sp,
                                        color: colorScheme.surface,
                                      ),
                                      label: Text(
                                        'Share',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      onPressed: () {
                                        // Share ticket details with a more informative message
                                        final eventName = widget.booking.eventId == null 
                                            ? widget.booking.park?.name 
                                            : widget.booking.event?.name;
                                        final eventDate = dateFormat.format(
                                            widget.booking.eventId == null 
                                                ? widget.booking.date 
                                                : widget.booking.eventId != null 
                                                  ? DateTime.parse(widget.booking.event!.startDate.toString())
                                                  : widget.booking.date
                                        );
                                        final ticketType = widget.booking.ticketIdsWithQuantity[0].ticketId;
                                        final quantity = widget.booking.ticketIdsWithQuantity[0].quantity;
                                        
                                        Share.share(
                                          'My ticket details:\n'
                                          '$eventName\n'
                                          'Date: $eventDate\n'
                                          'Ticket Type: $ticketType\n'
                                          'Quantity: $quantity tickets\n'
                                          'Booking ID: ${widget.booking.id}'
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ] else ...[
                            // Show expand hint
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 16.sp,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      'Tap for details',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
