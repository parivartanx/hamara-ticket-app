import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart'; // Comment out the problematic package
import 'package:permission_handler/permission_handler.dart';
import '../../../../extensions/media_query_ext.dart';
import '../../../../models/booking/booking_model.dart';
import 'dart:math' as math;

class QRTicketDialog extends StatefulWidget {
  final BookingModel booking;

  const QRTicketDialog({
    Key? key,
    required this.booking,
  }) : super(key: key);

  @override
  State<QRTicketDialog> createState() => _QRTicketDialogState();
}

class _QRTicketDialogState extends State<QRTicketDialog> {
  final ScreenshotController _screenshotController = ScreenshotController();
  bool _isSaving = false;
  bool _isSharing = false;

  Future<void> _saveTicketToGallery() async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    try {
      // Request storage permission first
      if (Platform.isAndroid) {
        if (await _requestPermission()) {
          await _saveImageAlternative();
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Permission denied to save the ticket'),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        }
      } else {
        // For iOS or other platforms
        await _saveImageAlternative();
      }
    } catch (e) {
      if (!mounted) return;
      // Show detailed error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 5),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Future<bool> _requestPermission() async {
    // For Android 11+ (API 30+)
    if (await Permission.manageExternalStorage.request().isGranted) {
      return true;
    }

    // For Android 10 and below
    if (await Permission.storage.request().isGranted) {
      return true;
    }

    // For photos access on all platforms
    if (await Permission.photos.request().isGranted) {
      return true;
    }

    return false;
  }

  Future<void> _saveImageAlternative() async {
    final Uint8List? image = await _screenshotController.capture(
      delay: const Duration(milliseconds: 10),
    );
    
    if (image == null || image.isEmpty) {
      throw Exception("Failed to capture screenshot");
    }
    
    // Get temporary directory
    final tempDir = await getTemporaryDirectory();
    final String fileName = 'ticket_${widget.booking.eventId}_${DateTime.now().millisecondsSinceEpoch}.png';
    final File imgFile = File('${tempDir.path}/$fileName');
    
    // Write bytes to file
    await imgFile.writeAsBytes(image);
    
    if (!mounted) return;
    
    // Show success message with share option
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Ticket image created successfully'),
        backgroundColor: context.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'SHARE',
          textColor: Colors.white,
          onPressed: () => _shareImage(imgFile),
        ),
      ),
    );
    
    // Automatically show share dialog
    await _shareImage(imgFile);
  }
  
  Future<void> _shareImage(File imgFile) async {
    await Share.shareXFiles(
      [XFile(imgFile.path)],
      text: 'My ${widget.booking.eventId==null ? widget.booking.park?.name : widget.booking.event?.name} ticket for ${widget.booking.eventId==null ? widget.booking.date : widget.booking.event?.startDate}',
      subject: 'My ${widget.booking.eventId==null ? widget.booking.park?.name : widget.booking.event?.name} Ticket',
    );
  }

  Future<void> _shareTicket() async {
    if (_isSharing) return;

    setState(() {
      _isSharing = true;
    });

    try {
      // Capture the screenshot
      final Uint8List? image = await _screenshotController.capture(
        delay: const Duration(milliseconds: 10),
      );

      if (image == null || image.isEmpty) {
        throw Exception("Failed to capture screenshot");
      }

      // Save to temp directory
      final tempDir = await getTemporaryDirectory();
      final String fileName =
          'ticket_${DateTime.now().millisecondsSinceEpoch}.png';
      final File file =
          await File('${tempDir.path}/$fileName').create(recursive: true);
      await file.writeAsBytes(image);

      if (!mounted) return;

      // Use direct file sharing
      final result = await Share.shareXFiles(
        [XFile(file.path)],
        text:
            'My ${widget.booking.eventId==null ? widget.booking.park?.name : widget.booking.event?.name} ticket for ${widget.booking.eventId==null ? widget.booking.date : widget.booking.event?.startDate}',
      );

    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error while sharing: ${e.toString()}'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 5),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSharing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('dd MMM yyyy');
    final DateFormat timeFormat = DateFormat('hh:mm a');
    final colorScheme = context.colorScheme;

    // Generate QR code data - typically this would be some unique identifier
    final String qrData =
        'TICKET:${widget.booking.id}:${widget.booking.ticketIdsWithQuantity.keys.first}:${widget.booking.ticketIdsWithQuantity.values.first}';

    // Determine color based on category
    // Color getCategoryColor() {
    //   switch (widget.booking.eventId==null ? widget.booking.park?.type : widget.booking.event?.tags.first) {
    //     case 'Event':
    //       return colorScheme.primary;
    //     case 'Park':
    //       return colorScheme.secondary;
    //     case 'Water Park':
    //       return colorScheme.tertiary;
    //   }
    // }

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Screenshot(
              controller: _screenshotController,
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withOpacity(0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Top header section with logo
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                        ),
                      ),
                      child: Column(
                        children: [
                          // Logo and Title Section with USED badge
                          Container(
                            padding: EdgeInsets.all(16.r),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: colorScheme.outlineVariant.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Stack(
                              children: [
                                // Logo and Title
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: Image.asset(
                                        'assets/image/hamara-ticket-logo.png',
                                        height: 28.h,
                                        width: 28.h,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'Hamara Ticket',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                        color: colorScheme.onSurface,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ],
                                ),
                                // USED badge in top right
                                if (widget.booking.status?.toLowerCase() == 'used')
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                        vertical: 4.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colorScheme.error.withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(6.r),
                                      ),
                                      child: Text(
                                        'USED',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: colorScheme.error,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          // Event Details
                          Container(
                            padding: EdgeInsets.all(16.r),
                            decoration: BoxDecoration(
                              color: colorScheme.primary.withOpacity(0.08),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (widget.booking.eventId == null ? widget.booking.park?.name : widget.booking.event?.name) ?? '',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: colorScheme.onSurface,
                                          height: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // QR code section
                    Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
                      child: Column(
                        children: [
                          QrImageView(
                            data: qrData,
                            version: QrVersions.auto,
                            size: 220.r,
                            backgroundColor: colorScheme.surface,
                            foregroundColor: colorScheme.onSurface,
                            errorCorrectionLevel: QrErrorCorrectLevel.H,
                            padding: EdgeInsets.zero,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Scan to Verify',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Divider with punched circles
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4.h),
                          child: Row(
                            children: List.generate(
                              30,
                              (index) => Expanded(
                                child: Container(
                                  height: 1,
                                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                                  color: colorScheme.outlineVariant,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: -8,
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: Container(
                              width: 12.w,
                              height: 12.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorScheme.surface,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: -8,
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: Container(
                              width: 12.w,
                              height: 12.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorScheme.surface,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Ticket details
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildDetailRow(
                                  'Date',
                                  dateFormat.format(widget.booking.eventId==null ? widget.booking.date : DateTime.parse(widget.booking.event?.startDate ?? '')),
                                  Icons.calendar_today_outlined,
                                  colorScheme,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: _buildDetailRow(
                                  'Time',
                                  widget.booking.eventId==null ? timeFormat.format(widget.booking.date) : widget.booking.event?.startDate ?? '',
                                  Icons.access_time_rounded,
                                  colorScheme,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Expanded(
                                child: _buildDetailRow(
                                  'Ticket Type',
                                  widget.booking.ticketIdsWithQuantity.keys.first,
                                  Icons.confirmation_number_outlined,
                                  colorScheme,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: _buildDetailRow(
                                  'Quantity',
                                  '${widget.booking.ticketIdsWithQuantity.values.first} tickets',
                                  Icons.person_outline,
                                  colorScheme,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          _buildDetailRow(
                            'Booking ID',
                            widget.booking.id,
                            Icons.qr_code_outlined,
                            colorScheme,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom action buttons
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 16.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    label: 'Share',
                    icon: Icons.share_outlined,
                    color: colorScheme.primary.withOpacity(0.08),
                    isLoading: _isSharing,
                    onPressed: _shareTicket,
                    colorScheme: colorScheme,
                  ),
                  _buildActionButton(
                    label: 'Save to Gallery',
                    icon: Icons.save_alt_rounded,
                    color: colorScheme.secondary,
                    isLoading: _isSaving,
                    onPressed: _saveTicketToGallery,
                    colorScheme: colorScheme,
                  ),
                  _buildActionButton(
                    label: 'Close',
                    icon: Icons.close,
                    color: colorScheme.surface,
                    onPressed: () => Navigator.of(context).pop(),
                    colorScheme: colorScheme,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    required ColorScheme colorScheme,
    bool isLoading = false,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: color == colorScheme.surface 
            ? colorScheme.onSurfaceVariant 
            : colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 8.h,
        ),
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? SizedBox(
              width: 16.sp,
              height: 16.sp,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(colorScheme.onPrimary),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 16.sp,
                  color: color == colorScheme.surface 
            ? colorScheme.primary 
            : colorScheme.onPrimary,
                ),
                SizedBox(width: 4.w),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon, ColorScheme colorScheme) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: colorScheme.onSurfaceVariant,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
