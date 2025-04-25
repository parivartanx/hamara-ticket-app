import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '/features/buy_ticket/presentation/providers/tickets_provider.dart';
import '/features/buy_ticket/presentation/providers/ticket_state.dart';

class TicketSelectionStep extends ConsumerWidget {
  final String occasionId;
  final String occasionType;
  const TicketSelectionStep({Key? key,required this.occasionId,required this.occasionType}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(ticketBookingProvider);
    
    // Initialize occasion details
    ref.read(occasionIdProvider.notifier).state = occasionId;
    ref.read(occasionTypeProvider.notifier).state = occasionType;
    
    final date = DateFormat('yyyy-MM-dd').format(bookingState.selectedDate ?? DateTime.now());
    final params = (
      date: date,
      eventId: occasionType.toLowerCase() == "event" ? occasionId : null,
      parkId: occasionType.toLowerCase() == "park" || occasionType.toLowerCase() == "waterpark" ? occasionId : null,
    );

    // Watch the tickets provider
    final tickets = ref.watch(ticketsProvider(params));
    
    // Watch the prices provider to ensure it's initialized
    ref.watch(ticketPricesProvider);

    final subtotal = ref.watch(subtotalProvider);
    final convenienceFee = ref.watch(convenienceFeeProvider);
    final totalAmount = ref.watch(totalAmountProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TicketHeader(),
          const SizedBox(height: 16),
          ...tickets.when(
            data: (tickets) {
              if (tickets.isEmpty) {
                return [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 24),
                      child: TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 800),
                        tween: Tween<double>(begin: 0, end: 1),
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Opacity(
                              opacity: value,
                              child: Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.event_busy_outlined,
                                        size: 48,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    Text(
                                      'No Tickets Available',
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).colorScheme.onSurface,
                                          ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'There are currently no tickets available\nfor this date.',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                                            height: 1.5,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ];
              }
              return tickets.map((ticket) => TicketItem(
                ticketId: ticket.id,
                name: ticket.ticketType,
                price: ticket.price.toDouble(),
                quantity: bookingState.selectedTickets[ticket.id] ?? 0,
              ));
            },
            error: (error, stackTrace) => [
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 800),
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Opacity(
                          opacity: value,
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.errorContainer.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.error.withOpacity(0.2),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.error.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.error_outline_rounded,
                                    size: 48,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  'Oops! Something went wrong',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Unable to load tickets.\nPlease try again later.',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                                        height: 1.5,
                                      ),
                                ),
                                const SizedBox(height: 24),
                                TextButton.icon(
                                  onPressed: () {
                                    ref.refresh(ticketsProvider(params));
                                  },
                                  icon: const Icon(Icons.refresh_rounded),
                                  label: const Text('Try Again'),
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
            loading: () => [
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          const PromoCodeSection(),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          OrderSummary(
            subtotal: subtotal,
            convenienceFee: convenienceFee,
            totalAmount: totalAmount,
          ),
        ],
      ),
    );
  }
}

class TicketHeader extends StatelessWidget {
  const TicketHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.confirmation_number_outlined,
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          'Select Tickets',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}

class TicketItem extends ConsumerWidget {
  final String ticketId;
  final String name;
  final double price;
  final int quantity;

  const TicketItem({
    Key? key,
    required this.ticketId,
    required this.name,
    required this.price,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  '₹${price.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          QuantitySelector(
            ticketId: ticketId,
            quantity: quantity,
          ),
        ],
      ),
    );
  }
}

class QuantitySelector extends ConsumerWidget {
  final String ticketId;
  final int quantity;

  const QuantitySelector({
    Key? key,
    required this.ticketId,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _QuantityButton(
            icon: Icons.remove,
            onPressed: () {
              final newQuantity = quantity - 1;
              ref.read(ticketBookingProvider.notifier).updateTickets(
                ticketId,
                newQuantity >= 0 ? newQuantity : 0,
              );
            },
            isDisabled: quantity == 0,
          ),
          SizedBox(
            width: 28,
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          _QuantityButton(
            icon: Icons.add,
            onPressed: () {
              ref.read(ticketBookingProvider.notifier).updateTickets(
                ticketId,
                quantity + 1,
              );
            },
            isDisabled: false,
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isDisabled;

  const _QuantityButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.isDisabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isDisabled ? null : onPressed,
        borderRadius: BorderRadius.circular(4),
        child: SizedBox(
          width: 28,
          height: 28,
          child: Icon(
            icon,
            size: 14,
            color: isDisabled 
                ? colorScheme.onSurfaceVariant.withOpacity(0.4)
                : colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}

class PromoCodeSection extends ConsumerWidget {
  const PromoCodeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final promoController = TextEditingController();
    
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: promoController,
            decoration: InputDecoration(
              hintText: 'Enter promo code',
              hintStyle: TextStyle(
                color: colorScheme.onSurfaceVariant.withOpacity(0.6),
                fontSize: 13,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: colorScheme.outline),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: colorScheme.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: colorScheme.primary),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            if (promoController.text.isNotEmpty) {
              ref.read(ticketBookingProvider.notifier).applyPromoCode(promoController.text);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.surfaceContainerHighest,
            foregroundColor: colorScheme.onSurfaceVariant,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          child: const Text(
            'Apply',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}

class OrderSummary extends StatelessWidget {
  final double subtotal;
  final double convenienceFee;
  final double totalAmount;

  const OrderSummary({
    Key? key,
    required this.subtotal,
    required this.convenienceFee,
    required this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pricing Summary',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SummaryItem(
                label: 'Subtotal',
                value: '₹${subtotal.toStringAsFixed(2)}',
              ),
              const SizedBox(height: 12),
              ConvenienceFeeDetails(
                convenienceFee: convenienceFee,
                gstAmount: convenienceFee * 0.18, // Assuming 18% GST
                platformFee: convenienceFee * 0.82, // Remaining amount as platform fee
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),
              SummaryItem(
                label: 'Total',
                value: '₹${totalAmount.toStringAsFixed(2)}',
                isTotal: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ConvenienceFeeDetails extends StatefulWidget {
  final double convenienceFee;
  final double gstAmount;
  final double platformFee;

  const ConvenienceFeeDetails({
    Key? key,
    required this.convenienceFee,
    required this.gstAmount,
    required this.platformFee,
  }) : super(key: key);

  @override
  State<ConvenienceFeeDetails> createState() => _ConvenienceFeeDetailsState();
}

class _ConvenienceFeeDetailsState extends State<ConvenienceFeeDetails> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Convenience Fees',
                      style: TextStyle(
                        fontSize: 13,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      size: 16,
                      color: colorScheme.primary,
                    ),
                  ],
                ),
                Text(
                  '₹${widget.convenienceFee.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
        ClipRect(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: _isExpanded ? 80 : 0,
            curve: Curves.easeInOut,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: Column(
                  children: [
                    FeeDetailRow(
                      label: 'Platform Fee',
                      amount: widget.platformFee,
                    ),
                    const SizedBox(height: 8),
                    FeeDetailRow(
                      label: 'GST (18%)',
                      amount: widget.gstAmount,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FeeDetailRow extends StatelessWidget {
  final String label;
  final double amount;

  const FeeDetailRow({
    Key? key,
    required this.label,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          '₹${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const SummaryItem({
    Key? key,
    required this.label,
    required this.value,
    this.isTotal = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 14 : 13,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: colorScheme.onSurface,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 14 : 13,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? colorScheme.primary : colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
