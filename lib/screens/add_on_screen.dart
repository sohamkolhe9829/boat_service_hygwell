import 'package:boat_service_hygwell/providers/add_on_provider.dart';
import 'package:boat_service_hygwell/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../widgets/dash_divider.dart';

class AddOnScreen extends StatelessWidget {
  String docId;
  AddOnScreen({super.key, required this.docId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 5,
        shadowColor: Colors.grey,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Add-Ons",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<AddOnProvider>(
        builder: (context, provider, child) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('boats')
                    .doc(docId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.hasError) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Center(
                        child: PassengerDetailOverlayCard(
                          title: snapshot.data!.get('name'),
                          capacity: snapshot.data!.get('capacity'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Additional seervices",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 5),

                      ///Transportation Options
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Transportation Options",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          if (provider.selectedModel.isSelected)
                            GestureDetector(
                              onTap: () {
                                provider.onTransportationEdit();
                              },
                              child: const Text(
                                "Edit",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        "Cab service pickUp and dropOff at Station; driver details will be shared via WhatsApp.",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      provider.selectedModel.isSelected
                          ? ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 5),
                              title: Text(provider.selectedModel.title),
                              subtitle: Text(
                                  "₹ ${provider.selectedModel.fare.toInt()}"),
                              trailing: IconButton(
                                onPressed: () {
                                  // provider.onTransportationSelect(0);
                                },
                                icon: CircleAvatar(
                                  backgroundColor: HexColor("#1E79E1"),
                                  child: const Icon(
                                    Icons.done,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: provider.transportation.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 5),
                                  title: Text(
                                      provider.transportation[index].title),
                                  subtitle: Text(
                                      "₹ ${provider.transportation[index].fare.toInt()}"),
                                  trailing: IconButton(
                                    onPressed: () {
                                      provider.onTransportationSelect(index);
                                    },
                                    icon: Icon(
                                      Icons.add_circle_outlined,
                                      size: 40,
                                      color: HexColor("#1E79E1"),
                                    ),
                                  ),
                                );
                              }),

                      ///Transportation Options -------

                      const DashDivider(color: Colors.grey),
                      const SizedBox(height: 10),

                      ///Meal Selection --------
                      const Text(
                        "Meal Selection",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 2),
                      ListView.builder(
                          itemCount: provider.meals.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 5),
                              title: Text(provider.meals[index].title),
                              subtitle: Text(
                                  "₹ ${provider.meals[index].price.toInt()}"),
                              trailing: InkWell(
                                onTap: () {
                                  provider.addMeal(index);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: HexColor("#1E79E1"),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  width: 120,
                                  height: 40,
                                  child: provider.meals[index].count > 0
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  provider.addMeal(index);
                                                },
                                                icon: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                )),
                                            Text(
                                              provider.meals[index].count
                                                  .toInt()
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  provider.removeMeal(index);
                                                },
                                                icon: const Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                )),
                                          ],
                                        )
                                      : const Center(
                                          child: Text(
                                            "Add",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            );
                          }),

                      ///Meal Selection --------
                      const DashDivider(color: Colors.grey),
                      const SizedBox(height: 10),

                      ///Other Recommendations------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Other Recommendations",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          if (provider.tourGuide.isSelected)
                            GestureDetector(
                              onTap: () {
                                provider.onRecommendationEdit();
                              },
                              child: const Text(
                                "Edit",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 5),
                        title: const Text("Tour Guide"),
                        subtitle: const Text("₹ 1,500"),
                        trailing: provider.tourGuide.isSelected
                            ? IconButton(
                                onPressed: () {
                                  provider.onRecommendationEdit();
                                },
                                icon: CircleAvatar(
                                  backgroundColor: HexColor("#1E79E1"),
                                  child: const Icon(
                                    Icons.done,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  provider.onRecommendationSelect();
                                },
                                icon: Icon(
                                  Icons.add_circle_outlined,
                                  size: 40,
                                  color: HexColor("#1E79E1"),
                                ),
                              ),
                      ),

                      ///Other Recommendation
                      const DashDivider(color: Colors.grey),
                      const SizedBox(height: 10),

                      ///Insurance
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 5),
                        title: const Text(
                          "Insurance",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        subtitle: const Text("At just ₹50 per pessenger get:"),
                        trailing: provider.isInsuranceCollected
                            ? IconButton(
                                onPressed: () {
                                  provider.onTapInsurance();
                                },
                                icon: CircleAvatar(
                                  backgroundColor: HexColor("#1E79E1"),
                                  child: const Icon(
                                    Icons.done,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  provider.onTapInsurance();
                                },
                                icon: Icon(
                                  Icons.add_circle_outlined,
                                  size: 40,
                                  color: HexColor("#1E79E1"),
                                ),
                              ),
                      ),
                      const Text(
                        "Insurance Coverage",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const Text(
                        "Upto ₹70,000 on hospitalization & Upto ₹5,00,000 in case of Death/PTD",
                        style: TextStyle(fontSize: 16),
                      ),

                      ///Insurance
                      const SizedBox(height: 10),
                      const DashDivider(color: Colors.grey),
                      const SizedBox(height: 10),

                      const Text(
                        "Bill Breakdown",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: HexColor("#1E79E1"),
                          ),
                          const Text(
                            "  2 Passenger",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),

                      const Row(
                        children: [
                          SizedBox(width: 35),
                          Icon(
                            Icons.circle,
                            size: 5,
                          ),
                          Text(
                            "  Adult 1",
                            style: TextStyle(fontSize: 18),
                          ),
                          Spacer(),
                          Text(
                            "₹ 1,500",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          SizedBox(width: 35),
                          Icon(
                            Icons.circle,
                            size: 5,
                          ),
                          Text(
                            "  Child 1",
                            style: TextStyle(fontSize: 18),
                          ),
                          Spacer(),
                          Text(
                            "₹ 1,000",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (provider.selectedModel.isSelected)
                        const Text(
                          "Transportation",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      if (provider.selectedModel.isSelected)
                        Row(
                          children: [
                            Text(
                              provider.selectedModel.title,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "₹ ${provider.selectedModel.fare.toInt()}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 10),
                      if (provider.meals[0].count > 0 ||
                          provider.meals[1].count > 0 ||
                          provider.meals[2].count > 0)
                        const Text(
                          "Meal",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ListView.builder(
                        itemCount: provider.meals.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return provider.meals[index].count > 0
                              ? Row(
                                  children: [
                                    Text(
                                      provider.meals[index].title,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "₹ ${provider.meals[index].price.toInt() * provider.meals[index].count}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox();
                        },
                      ),
                      if (provider.tourGuide.isSelected)
                        Row(
                          children: [
                            Text(
                              provider.tourGuide.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "₹ ${provider.tourGuide.fare.toInt()}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      if (provider.isInsuranceCollected)
                        const Row(
                          children: [
                            Text(
                              "Insurance",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "₹ ${50 * 2}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                      const SizedBox(height: 10),
                      const DashDivider(
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const Text(
                            "(taxas included)",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "₹ ${provider.getTotal(1500 + 1000, provider.selectedModel.isSelected ? provider.selectedModel.fare : 0, provider.tourGuide.isSelected ? provider.tourGuide.fare : 0, provider.isInsuranceCollected ? 50 * 2 : 0)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CustomButton(title: "Continue", callBack: () {}),

                      const SizedBox(height: 40),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}

class PassengerDetailOverlayCard extends StatelessWidget {
  String title;
  String capacity;
  PassengerDetailOverlayCard(
      {super.key, required this.capacity, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          width: MediaQuery.of(context).size.width - 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "7:00 AM",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "From",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: DashDivider(
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SizedBox(
                      height: 20,
                      child: Image.asset('assets/icon/cruise_icon.png'),
                    ),
                  ),
                  const Expanded(
                    child: DashDivider(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "3:00 PM",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "To",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const DashDivider(),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 30,
                  ),
                  Text(
                    "\t\t$capacity seats",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
