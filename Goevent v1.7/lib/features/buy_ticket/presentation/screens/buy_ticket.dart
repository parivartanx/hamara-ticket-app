import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/enums/occasion_type.dart';
import '../../../../extensions/media_query_ext.dart';
import '../providers/ticket_state.dart';
import '../widgets/date_selection_step.dart';
import '../widgets/details_step.dart';
import '../widgets/ticket_selection_step.dart';

class BuyTicketS extends ConsumerStatefulWidget {
  final String occasionType;
  final String occasionId;
  final String occasionName;

  const BuyTicketS({
    super.key,
    required this.occasionType,
    required this.occasionId,
    required this.occasionName,
  });

  @override
  ConsumerState<BuyTicketS> createState() => _BuyTicketSState();
}

class _BuyTicketSState extends ConsumerState<BuyTicketS> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final OccasionType _occasionType;
  String? userName = "Vinita";

  @override
  void initState() {
    super.initState();
    _occasionType = OccasionType.fromString(widget.occasionType);
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    
    Future.microtask(() {
      if (mounted) {
        ref.read(ticketBookingProvider.notifier).setOccasionType(widget.occasionType);
      }
    });
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.removeListener(() {});
    _fadeAnimation.removeListener((){});
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookingState = ref.watch(ticketBookingProvider);
    final colorScheme = context.colorScheme;
    final canContinue = ref.read(ticketBookingProvider.notifier).canProceedToNextStep();
    final totalSteps = _occasionType.requiresDateSelection ? 3 : 2;
    
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          widget.occasionName,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: colorScheme.surface,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSurface, size: 20),
          onPressed: () {
            ref.read(ticketBookingProvider.notifier).reset();
            Navigator.pop(context);
          },
        ),
      ),
      
    body: Column(
      children: [
        // Progress Steps
        Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border(
              bottom: BorderSide(
                color: colorScheme.outline.withOpacity(0.1),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(totalSteps, (index) {
              final isActive = index == bookingState.currentStep;
              final isPast = index < bookingState.currentStep;
              
              return Row(
                children: [
                  if (index > 0)
                    Container(
                      width: 32,
                      height: 1,
                      color: isPast
                          ? colorScheme.primary
                          : colorScheme.outline.withOpacity(0.2),
                    ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: isPast || isActive
                              ? colorScheme.primary
                              : colorScheme.surfaceContainerHighest,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: isPast
                              ? Icon(
                                  Icons.check_rounded,
                                  color: colorScheme.onPrimary,
                                  size: 16,
                                )
                              : Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    color: isActive
                                        ? colorScheme.onPrimary
                                        : colorScheme.onSurfaceVariant,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getStepLabel(index),
                        style: TextStyle(
                          fontSize: 12,
                          color: isActive || isPast
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                          fontWeight: isActive || isPast ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
        
        // Welcome Message
        if (userName != null && bookingState.currentStep == 0)
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.waving_hand_rounded,
                  color: colorScheme.primary,
                  size: 18,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Good ${_getTimeOfDay()}, $userName!',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        
        // Content
        Expanded(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: _buildStepContent(bookingState.currentStep,occasionId: widget.occasionId,occasionType: widget.occasionType),
            ),
          ),
        ),
        
        // Bottom Navigation
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border(
              top: BorderSide(
                color: colorScheme.outline.withOpacity(0.1),
              ),
            ),
          ),
          child: Row(
            children: [
              if (bookingState.currentStep > 0)
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _animationController.reverse().then((_) {
                        ref.read(ticketBookingProvider.notifier).previousStep();
                        _animationController.forward();
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.onSurface,
                      side: BorderSide(color: colorScheme.outline.withOpacity(0.3)),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Back',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              
              if (bookingState.currentStep > 0) SizedBox(width: 12.w),
              
              Expanded(
                flex: bookingState.currentStep > 0 ? 2 : 1,
                child: ElevatedButton(
                  onPressed: canContinue
                      ? () {
                          if (bookingState.currentStep < totalSteps - 1) {
                            _animationController.reverse().then((_) {
                              ref.read(ticketBookingProvider.notifier).nextStep();
                              _animationController.forward();
                            });
                          } else {
                            _handleSubmission();
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    disabledBackgroundColor: colorScheme.primary.withOpacity(0.3),
                    disabledForegroundColor: colorScheme.onPrimary.withOpacity(0.6),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                
                  child: Text(
                    bookingState.currentStep < totalSteps - 1 ? 'Continue' : 'Pay Now',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
        );
  }

  String _getStepLabel(int step) {
    if (_occasionType.requiresDateSelection) {
      switch (step) {
        case 0:
          return 'Date';
        case 1:
          return 'Tickets';
        case 2:
          return 'Details';
        default:
          return '';
      }
    } else {
      switch (step) {
        case 0:
          return 'Tickets';
        case 1:
          return 'Details';
        default:
          return '';
      }
    }
  }

  Widget _buildStepContent(int step,{required String occasionId,required String occasionType}) {
    if (_occasionType.requiresDateSelection) {
      switch (step) {
        case 0:
          return const DateSelectionStep();
        case 1:
          return TicketSelectionStep(occasionId: occasionId, occasionType: occasionType);
        case 2:
          return const DetailsStep();
        default:
          return const SizedBox.shrink();
      }
    } else {
      switch (step) {
        case 0:
          return TicketSelectionStep(occasionId: widget.occasionId, occasionType: widget.occasionType);
        case 1:
          return const DetailsStep();
        default:
          return const SizedBox.shrink();
      }
    }
  }

  String _getTimeOfDay() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    } else if (hour < 17) {
      return 'Afternoon';
    } else {
      return 'Evening';
    }
  }

  void _handleSubmission() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Processing your payment of ₹${ref.read(totalAmountProvider).toStringAsFixed(2)}',
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}