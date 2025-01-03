import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_gates_project/routes/app_routes_constants.dart';
import 'package:secure_gates_project/widgets/complaint_ticket_widget.dart';

class ComplaintsOuterPage extends HookWidget {
  const ComplaintsOuterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaint'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 4.0),
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: 'All',
                        isExpanded: true,
                        items: <String>['All', 'Open', 'Closed']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          // Handle dropdown change
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 4.0),
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () {
                        // Handle date selection
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: const [
                  ComplaintTicket(
                    title: 'Apartment',
                    issue: 'Fire',
                    ticketNumber: 'NA',
                    raisedBy: 'Kuldeep',
                    date: '28th December',
                    status: 'CLOSED',
                  ),
                  ComplaintTicket(
                    title: 'Apartment',
                    issue: 'Fire',
                    ticketNumber: 'NA',
                    raisedBy: 'Kuldeep',
                    date: '28th December',
                    status: 'CLOSED',
                  ),
                  ComplaintTicket(
                    title: 'Apartment',
                    issue: 'Fire',
                    ticketNumber: 'NA',
                    raisedBy: 'Kuldeep',
                    date: '28th December',
                    status: 'CLOSED',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            context.pushNamed(MyAppRoutes.complaints);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(60), // Increase height here
          ),
          child: const Text(
            'Raise a Complaint',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
