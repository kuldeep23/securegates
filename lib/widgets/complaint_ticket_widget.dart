import 'package:flutter/material.dart';

class ComplaintTicket extends StatelessWidget {
  final String title;
  final String issue;
  final String ticketNumber;
  final String raisedBy;
  final String date;
  final String status;

  const ComplaintTicket({
    super.key,
    required this.title,
    required this.issue,
    required this.ticketNumber,
    required this.raisedBy,
    required this.date,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Stack(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child:
                      Icon(Icons.notification_important, color: Colors.white),
                ),
                title: Text(title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(issue),
                    Text('Ticket No.: $ticketNumber'),
                    Text('Raised by $raisedBy'),
                    Text('Raised on $date'),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: status == 'CLOSED' ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Text(
                status,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
