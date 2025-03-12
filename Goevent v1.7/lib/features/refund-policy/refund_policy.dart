import 'package:flutter/material.dart';

class RefundPolicyScreen extends StatelessWidget {
  const RefundPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Refund Policy'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Refund Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Last Updated: 27-02-2025',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              '1. Event Ticket Refunds',
              [
                'Tickets for events, concerts, and movies are non-refundable unless the event is canceled or rescheduled by the organizer.',
                'In case of event cancellation, refunds will be processed as per the organizer\'s policy and may take 5-10 business days.',
                'If an event is rescheduled, tickets will remain valid for the new date. Refunds will be issued only if permitted by the event organizer.',
              ],
            ),
            _buildSection(
              '2. Processing Time & Refund Method',
              [
                'Refunds will be processed to the original payment method used at the time of booking.',
                'Processing time may vary based on the organizer, typically ranging between 5-15 business days.',
                'Any applicable service fees, convenience charges, or cancellation charges will be deducted from the refund amount.',
              ],
            ),
            _buildSection(
              '3. No-Show & Last-Minute Cancellations',
              [
                'No refunds will be issued for a no-show or last-minute cancellations where the event organizer does not permit refunds.',
                'Customers are advised to check the cancellation terms before making a booking.',
              ],
            ),
            _buildSection(
              '4. Force Majeure & Exceptional Cases',
              [
                'In case of unforeseen circumstances such as natural disasters, pandemics, or government restrictions, refund policies may be altered at the event organizer\'s discretion.',
                'If a refund is not possible, HamaraTicket.com may offer rescheduling options where applicable.',
              ],
            ),
            _buildSection(
              '5. How to Request a Refund',
              [
                'Log in to your HamaraTicket.com account and navigate to the "My Bookings" section.',
                'Select the event booking you wish to cancel and follow the on-screen instructions.',
                'If eligible, the refund will be processed automatically within the specified timeframe.',
                'For any assistance, contact our customer support at parivartanx.info@gmail.com.',
              ],
            ),
            _buildSection(
              '6. Dispute Resolution',
              [
                'If you face any issues regarding refunds, you can reach out to our support team within 7 days of the refund denial.',
                'Disputes will be resolved based on the terms and conditions applicable at the time of booking.',
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'HamaraTicket.com reserves the right to update this refund policy at any time. Customers are advised to review the policy periodically for any changes.',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'For further inquiries:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SelectableText(
                    'Email: parivartanx.info@gmail.com',
                    style: TextStyle(color: Colors.blue[700]),
                  ),
                  const SizedBox(height: 4),
                  SelectableText(
                    'Visit: www.hamaraticket.com',
                    style: TextStyle(color: Colors.blue[700]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> points) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...points.map((point) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontSize: 16)),
                  Expanded(
                    child: Text(
                      point,
                      style: const TextStyle(fontSize: 14, height: 1.5),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
