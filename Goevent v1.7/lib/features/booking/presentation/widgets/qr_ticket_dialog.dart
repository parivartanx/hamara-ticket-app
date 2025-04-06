import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import '../../../../extensions/media_query_ext.dart';
import '../../data/models/booking_model.dart';
import 'dart:math' as math;
import 'package:permission_handler/permission_handler.dart';

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
        // For Android 10 and above, we need to request MANAGE_EXTERNAL_STORAGE instead
        if (await _requestPermission()) {
          await _captureAndSave();
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Permission denied to save the ticket'),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        }
      } else {
        // For iOS or other platforms
        await _captureAndSave();
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

  Future<void> _captureAndSave() async {
    final Uint8List? image = await _screenshotController.capture(
      delay: const Duration(milliseconds: 10),
    );

    if (image == null || image.isEmpty) {
      throw Exception("Failed to capture screenshot");
    }

    // Save image with error handling
    final result = await ImageGallerySaver.saveImage(
      image,
      quality: 100,
      name:
          'ticket_${widget.booking.eventId}_${DateTime.now().millisecondsSinceEpoch}',
    );

    // Log the result for debugging
    print("Save result: $result");

    if (!mounted) return;

    // Check for success in result
    final bool isSuccess = result is Map &&
        (result['isSuccess'] == true || result.containsKey('filePath'));

    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ticket saved to gallery'),
          backgroundColor: context.colorScheme.primary,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      throw Exception("Failed to save image: $result");
    }
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
            'My ${widget.booking.category.displayName} ticket for ${widget.booking.eventName}',
      );

      print("Share result: $result");
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
        'TICKET:${widget.booking.eventId}:${widget.booking.ticketType}:${widget.booking.quantity}';

    // Determine color based on category
    Color getCategoryColor() {
      switch (widget.booking.category) {
        case BookingCategory.event:
          return colorScheme.primary;
        case BookingCategory.park:
          return Colors.green.shade700;
        case BookingCategory.waterPark:
          return Colors.blue.shade700;
      }
    }

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
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Top header section
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            getCategoryColor(),
                            getCategoryColor().withOpacity(0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 12.r, horizontal: 16.r),
                      child: Row(
                        children: [
                          // Status badge
                          if (widget.booking.isUsed)
                            Transform.rotate(
                              angle: -math.pi / 12,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 3.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(3.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
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
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ),

                          // Event details
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Event name
                                Text(
                                  widget.booking.eventName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 6.h),

                                // Category
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Text(
                                    widget.booking.category.displayName,
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      margin:
                          EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
                      child: Column(
                        children: [
                          QrImageView(
                            data: qrData,
                            version: QrVersions.auto,
                            size: 220.r,
                            backgroundColor: Colors.white,
                            errorCorrectionLevel: QrErrorCorrectLevel.H,
                            padding: EdgeInsets.zero,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Scan to Verify',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade600,
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
                                  color: Colors.grey.withOpacity(0.3),
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
                                color: context.colorScheme.background,
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
                                color: context.colorScheme.background,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Ticket details
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildDetailRow(
                                  'Date',
                                  dateFormat.format(widget.booking.eventDate),
                                  Icons.calendar_today_outlined,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: _buildDetailRow(
                                  'Time',
                                  timeFormat.format(widget.booking.eventDate),
                                  Icons.access_time_rounded,
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
                                  widget.booking.ticketType,
                                  Icons.confirmation_number_outlined,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: _buildDetailRow(
                                  'Quantity',
                                  '${widget.booking.quantity} tickets',
                                  Icons.person_outline,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          _buildDetailRow(
                            'Booking ID',
                            widget.booking.eventId,
                            Icons.qr_code_outlined,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom action buttons (not part of the screenshot)
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 16.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant.withOpacity(0.8),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
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
                    color: getCategoryColor(),
                    isLoading: _isSharing,
                    onPressed: _shareTicket,
                  ),
                  _buildActionButton(
                    label: 'Save to Gallery',
                    icon: Icons.save_alt_rounded,
                    color: Colors.amber.shade700,
                    isLoading: _isSaving,
                    onPressed: _saveTicketToGallery,
                  ),
                  _buildActionButton(
                    label: 'Close',
                    icon: Icons.close,
                    color: Colors.grey.shade600,
                    onPressed: () => Navigator.of(context).pop(),
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
    bool isLoading = false,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
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
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 16.sp,
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

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: Colors.grey.shade600,
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
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
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
