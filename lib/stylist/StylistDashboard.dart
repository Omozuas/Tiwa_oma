import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Tiwa_Oma/stylist/AllAppointment.dart';
import 'package:Tiwa_Oma/stylist/Clients.dart';
import 'package:Tiwa_Oma/stylist/stylistProfile.dart';
import 'package:Tiwa_Oma/stylist/widgets/LastestAppointmentInfo.dart';
import 'package:Tiwa_Oma/stylist/widgets/LatestAppointmentListAndCard.dart';
import 'package:Tiwa_Oma/utils/global.colors.dart';

class StylistDashboard extends StatefulWidget {
  const StylistDashboard({super.key});

  @override
  State<StylistDashboard> createState() => _StylistDashboardState();
}

List<String> popularHairSty = [
  "portrait-of-young-woman-smiling-isolated.png",
  "rectangle-1041.jpg",
  "portrait-of-young-woman-smiling-isolated.png",
  "rectangle-1041.jpg",
  "portrait-of-young-woman-smiling-isolated.png",
  "rectangle-1041.jpg",
];

List<String> popularBraids = [
  "Top Knot Braids",
  "Pulled-Back Cornrow Braids",
  "Top Knot Braids",
  "Pulled-Back Cornrow Braids",
  "Top Knot Braids",
  "Pulled-Back Cornrow Braids",
];
List<String> nameStylist = [
  "Tolu",
  "Tope",
  "Bolu",
  "Tobi",
  "Joshua",
  "Paul",
];

class _StylistDashboardState extends State<StylistDashboard> {
  void displayListIndices(List<String> listName) {
    for (int index = 0; index < listName.length; index++) {
      print("Index $index: ${listName[index]}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return MyProfile();
                          // }));
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/ellipse-117.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome Back',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Alex Samuel',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.notifications_outlined,
                          size: 35,
                        ),
                      ),
                      const SizedBox(width: 0.1),
                      Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 3),
                          color: const Color(0XFFFF2F08),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Card(
                    elevation: 2,
                    child: Container(
                      width: 372,
                      // height: 119,
                      padding: const EdgeInsets.all(
                          20.0), // Add padding to the container
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        // Use a Column to stack the text elements vertically
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: GlobalColors.green,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: FaIcon(FontAwesomeIcons.info,
                                      size: 20, color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ), // Add some spacing
                              Expanded(
                                // Expand to fill available space
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 35,
                                    ),
                                    Text(
                                      "Discover Amazing Braids",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: Text(
                                  "Complete your profile set up to have full access to the system",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .start, // Align button to the right
                            children: [
                              SizedBox(width: 29),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: GlobalColors.yellow,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 1,
                                  minimumSize: const Size(0, 30),
                                ),
                                child: const Text('Start Now'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: const Text(
                        'Frequent Clients',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: popularHairSty.length & nameStylist.length,
                    itemBuilder: (
                      context1,
                      index1,
                    ) {
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const stylistReview()));
                              },
                              child: Container(
                                width: 82,
                                height:
                                    82, // Adjust the size of the image container
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(82),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/${popularHairSty[index1]}"),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                                height:
                                    8), // Adjust the spacing between image and text
                            Text(
                              nameStylist[index1],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: const Text(
                        'Latest Appointment',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SingleChildScrollView(
              child: AppointmentList(
                appoimentReview: appointmentList,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        elevation: 0,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StylistDashboard()));
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.house,
                      size: 25,
                      color: GlobalColors.yellow,
                    ),
                  ),
                  Text(
                    'Home',
                    style: TextStyle(color: GlobalColors.yellow),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AllAppointment()));
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.book,
                      size: 25,
                    ),
                  ),
                  const Text('Appointment'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Clients()));
                    },
                    icon: const Icon(
                      Icons.people_outline_sharp,
                      size: 32,
                    ),
                  ),
                  const Text('client'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StylistProfile()));
                    },
                    icon: const Icon(
                      Icons.person_2_outlined,
                      size: 25,
                    ),
                  ),
                  const Text('Profile'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
