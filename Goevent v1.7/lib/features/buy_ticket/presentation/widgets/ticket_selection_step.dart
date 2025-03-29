import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ticket_model.dart';
import '../providers/ticket_providers.dart';

class TicketSelectionStep extends ConsumerWidget {
  const TicketSelectionStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tickets = ref.watch(ticketsProvider);
    final subtotal = ref.watch(subtotalProvider);
    final convenienceFee = ref.watch(convenienceFeeProvider);
    final totalAmount = ref.watch(totalAmountProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ticket selection header
          Row(
            children: [
              Icon(
                Icons.confirmation_number_outlined,
                color: colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Select Tickets',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Ticket list
          ...tickets.map((ticket) => _buildTicketItem(context, ref, ticket)),
          
          const SizedBox(height: 24),
          
          // Promo code section
          _buildPromoCodeSection(context),
          
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          
          // Summary section
          _buildSummaryItem(
            context,
            'Subtotal',
            '₹${subtotal.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 12),
          _buildSummaryItemWithInfo(
            context,
            'Convenience Fees',
            '₹${convenienceFee.toStringAsFixed(2)}',
            'A small fee to keep the service running smoothly',
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          _buildSummaryItem(
            context,
            'Total',
            '₹${totalAmount.toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTicketItem(BuildContext context, WidgetRef ref, TicketModel ticket) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          ticket.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '₹${ticket.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              _buildQuantitySelector(context, ref, ticket),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(BuildContext context, WidgetRef ref, TicketModel ticket) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outline),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _buildQuantityButton(
            context,
            Icons.remove,
            () {
              ref.read(ticketsProvider.notifier).decrementTicket(ticket.id);
            },
            ticket.quantity == 0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '${ticket.quantity}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          _buildQuantityButton(
            context,
            Icons.add,
            () {
              ref.read(ticketsProvider.notifier).incrementTicket(ticket.id);
            },
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(
    BuildContext context,
    IconData icon,
    VoidCallback onPressed,
    bool isDisabled,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return InkWell(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isDisabled ? colorScheme.surfaceVariant : colorScheme.surface,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          icon,
          size: 18,
          color: isDisabled ? colorScheme.onSurfaceVariant.withOpacity(0.4) : colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildPromoCodeSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Enter promo code',
              hintStyle: TextStyle(color: colorScheme.onSurfaceVariant.withOpacity(0.6)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: colorScheme.outline),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: colorScheme.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: colorScheme.primary),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.surfaceVariant,
            foregroundColor: colorScheme.onSurfaceVariant,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
          child: const Text(
            'Apply',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    String label,
    String value, {
    bool isTotal = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: colorScheme.onSurface,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? colorScheme.primary : colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItemWithInfo(
    BuildContext context,
    String label,
    String value,
    String tooltip,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(width: 4),
            Tooltip(
              message: tooltip,
              child: Icon(
                Icons.info_outline,
                size: 16,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
