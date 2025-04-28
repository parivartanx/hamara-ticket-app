import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamaraticket/features/profile/presentation/providers/profile_provider.dart';
import 'package:hamaraticket/models/ticket/order_ticket_model.dart';
import '../../../../core/enums/occasion_type.dart';
import '../../../../extensions/media_query_ext.dart';
import '../providers/ticket_state.dart';
import '../services/ticket_order_service.dart';
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

  // controllers for text fields
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController(); 

  String? userName = "Guest";
 
  // late final TicketsRepo _ticketsRepo;

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
        // _ticketsRepo = ref.read(ticketsRepoProvider);
      }
    });
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _animationController.removeListener(() {});
    _fadeAnimation.removeListener((){});
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookingState = ref.watch(ticketBookingProvider);
    final colorScheme = context.colorScheme;
    final totalSteps = _occasionType.requiresDateSelection ? 3 : 2;
    final canContinue = bookingState.currentStep < totalSteps - 1 
        ? ref.read(ticketBookingProvider.notifier).canProceedToNextStep()
        : bookingState.termsAccepted;

    /// get user from local 
    final asyncUser = ref.watch(profileProvider);
    asyncUser.when(
      data: (user) {
        if (user != null) {
          userName = user.name;
          _nameController.text = user.name;
          _emailController.text = user.email;
          _phoneController.text = user.phone ?? "";
        }
      },
      error: (error, stackTrace) {
        /// show scaffold message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error fetching user data: $error'),
            backgroundColor: colorScheme.error,
          ),
        );
      },
      loading: () {
        /// show loading indicator
        log("Loading user data...");
      },
    );
      
     
    
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
                            _handleSubmission(
                              name: _nameController.text,
                              email: _emailController.text,
                              phone: _phoneController.text,
                            );
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
          return DetailsStep(
            nameController: _nameController,
            emailController: _emailController,
            phoneController: _phoneController,
          );
        default:
          return const SizedBox.shrink();
      }
    } else {
      switch (step) {
        case 0:
          return TicketSelectionStep(occasionId: widget.occasionId, occasionType: widget.occasionType);
        case 1:
          return DetailsStep(
            nameController: _nameController,
            emailController: _emailController,
            phoneController: _phoneController,
          );
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

  void _handleSubmission({required String email, required String name, required String phone, String? description = "Ticket Booking"}) {
    final bookingState = ref.read(ticketBookingProvider);
    
    if (!bookingState.termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please accept the terms and conditions first'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    final selectedTickets = bookingState.selectedTickets.entries
        .map((e) => BookingTicket(
              ticketId: e.key,
              quantity: e.value,
            ))
        .toList();
    
    // log("Creating order for ${_occasionType.toString()}");
    final order = OrderTicket(
      couponCodes: [], 
      eventId: _occasionType == OccasionType.event ? widget.occasionId : null,
      parkId: (_occasionType == OccasionType.park || _occasionType == OccasionType.waterpark) ? widget.occasionId : null,
      email: email, 
      name: name, 
      phone: phone, 
      ticketIds: selectedTickets,
      date: bookingState.selectedDate,
    );
    
    // Use the new TicketOrderService to handle the ordering process with elegant UI
    TicketOrderService.processOrder(
      context: context,
      ref: ref,
      order: order,
      customerName: name,
      customerEmail: email,
      customerPhone: phone,
      description: description ?? "Ticket Booking",
    );
  }
}