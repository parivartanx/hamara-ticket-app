import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/ticket_providers.dart';
import '../widgets/date_selection_step.dart';
import '../widgets/details_step.dart';
import '../widgets/ticket_selection_step.dart';

class BuyTicketS extends ConsumerStatefulWidget {
  final String occasionType; // 'park' or 'event'
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
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  String? userName = "Vinita"; // This would come from user profile in a real app

  @override
  void initState() {
    super.initState();
    
    // Set the occasion type in the provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(occasionTypeProvider.notifier).state = widget.occasionType;
    });
    
    // Setup animations
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
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = ref.watch(currentStepProvider);
    final occasionType = ref.watch(occasionTypeProvider);
    final totalSteps = occasionType == 'park' ? 3 : 2;
    final subtotal = ref.watch(subtotalProvider);
    final colorScheme = Theme.of(context).colorScheme;
    
    // Determine if the continue button should be enabled
    bool canContinue = true;
    if (occasionType == 'park' && currentStep == 0) {
      // For park type, date selection is required
      canContinue = ref.watch(selectedDateProvider) != null;
    } else if (currentStep == (occasionType == 'park' ? 1 : 0)) {
      // Ticket selection step - at least one ticket must be selected
      canContinue = subtotal > 0;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.occasionName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.onPrimary,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: colorScheme.surface,
      ),
      body: Column(
        children: [
          // Stepper header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            color: colorScheme.surface,
            child: Row(
              children: List.generate(totalSteps, (index) {
                // For park type: Date Selection, Tickets, Details
                // For event type: Tickets, Details
                String stepTitle = '';
                
                if (occasionType == 'park') {
                  if (index == 0) {
                    stepTitle = 'Date';
                  } else if (index == 1) {
                    stepTitle = 'Tickets';
                  } else {
                    stepTitle = 'Details';
                  }
                } else {
                  if (index == 0) {
                    stepTitle = 'Tickets';
                  } else {
                    stepTitle = 'Details';
                  }
                }
                
                final isActive = index == currentStep;
                final isPast = index < currentStep;
                
                return Expanded(
                  child: Row(
                    children: [
                      // Step number or check icon
                      Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          color: isPast
                              ? colorScheme.primary
                              : isActive
                                  ? colorScheme.primary
                                  : colorScheme.surfaceVariant,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: isPast
                              ? Icon(
                                  Icons.check,
                                  color: colorScheme.onPrimary,
                                  size: 16.w,
                                )
                              : Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    color: isActive ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      
                      // Step text
                      SizedBox(width: 8.w),
                      Text(
                        stepTitle,
                        style: TextStyle(
                          color: isActive || isPast
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                          fontWeight: isActive || isPast
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      
                      // Connector line
                      if (index < totalSteps - 1)
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            height: 1,
                            color: isPast
                                ? colorScheme.primary
                                : colorScheme.outline,
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ),
          ),
          
          // Welcome message with personalization
          if (userName != null && currentStep == 0)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              color: colorScheme.primary.withOpacity(0.1),
              child: Text(
                'Good ${_getTimeOfDay()}, $userName!',
                style: TextStyle(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
          
          // Step content
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SingleChildScrollView(
                child: _buildStepContent(currentStep, occasionType),
              ),
            ),
          ),
          
          // Bottom navigation
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Row(
              children: [
                // Back button
                if (currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _animationController.reverse().then((_) {
                          ref.read(currentStepProvider.notifier).state--;
                          _animationController.forward();
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colorScheme.onSurface,
                        side: BorderSide(color: colorScheme.outline),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Back'),
                    ),
                  ),
                
                // Spacer
                if (currentStep > 0) const SizedBox(width: 16),
                
                // Continue/Submit button
                Expanded(
                  flex: currentStep > 0 ? 2 : 1,
                  child: ElevatedButton(
                    onPressed: canContinue
                        ? () {
                            if (currentStep < totalSteps - 1) {
                              _animationController.reverse().then((_) {
                                ref.read(currentStepProvider.notifier).state++;
                                _animationController.forward();
                              });
                            } else {
                              // Handle final submission
                              _handleSubmission();
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      disabledBackgroundColor: colorScheme.primary.withOpacity(0.3),
                      disabledForegroundColor: colorScheme.onPrimary.withOpacity(0.6),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      currentStep < totalSteps - 1 ? 'Continue' : 'Pay Now',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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

  Widget _buildStepContent(int step, String occasionType) {
    if (occasionType == 'park') {
      switch (step) {
        case 0:
          return const DateSelectionStep();
        case 1:
          return const TicketSelectionStep();
        case 2:
          return const DetailsStep();
        default:
          return const SizedBox.shrink();
      }
    } else {
      // Event flow skips date selection
      switch (step) {
        case 0:
          return const TicketSelectionStep();
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
    // Here you would implement the payment processing
    // For now, we'll just show a snackbar
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