import 'package:flutter/material.dart';
import 'package:secure_gates_project/entities/staff.dart';

class DomesticStaffMemberDetailsPage extends StatelessWidget {
  const DomesticStaffMemberDetailsPage({super.key, required this.staffMember});

  final StaffMember staffMember;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${staffMember.staffType} Profile",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                height: 170,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xffef709b),
                      Color(0xfffa9372),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
              ),
              Positioned(
                bottom: -30,
                left: 30,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 5,
                    ),
                  ),
                  height: 86,
                  width: 85,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      staffMember.staffIcon,
                      fit: BoxFit.cover,
                      height: 85,
                      width: 85,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color(0xffffcccb),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.phone,
                    color: Colors.redAccent,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    color: Colors.white,
                    Icons.chat,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Text(
              staffMember.staffName,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.meeting_room_outlined,
                  color: Colors.grey,
                  size: 30,
                ),
                Text(
                  staffMember.staffRating,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.home_outlined,
                  color: Colors.grey,
                  size: 30,
                ),
                // Text(
                //   residentData.ownerTenant,
                //   style: const TextStyle(fontSize: 18),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
