import 'package:flutter/material.dart';

class AddOnProvider with ChangeNotifier {
  //Transportation model
  TransportationModel selectedModel =
      TransportationModel(title: "title", fare: 500, isSelected: false);

  List<TransportationModel> transportation = [
    TransportationModel(
        title: "Private Car (4 Seater)", fare: 500, isSelected: true),
    TransportationModel(
        title: "Private Car (7 Seater)", fare: 500, isSelected: true),
    TransportationModel(title: "Shared rides", fare: 500, isSelected: true),
  ];

  onTransportationSelect(int index) {
    selectedModel = transportation[index];
    notifyListeners();
  }

  onTransportationEdit() {
    selectedModel =
        TransportationModel(title: "title", fare: 500, isSelected: false);
    notifyListeners();
  }

  //Meal Selection
  List<MealsModel> meals = [
    MealsModel(title: "Breakfast & Snacks", price: 500, count: 0),
    MealsModel(title: "Pure Veg Lunch", price: 500, count: 0),
    MealsModel(title: "Non-Veg Lunch", price: 500, count: 0),
  ];

  addMeal(int index) {
    meals[index].count++;
    notifyListeners();
  }

  removeMeal(int index) {
    meals[index].count--;
    notifyListeners();
  }

  //Tour Guide
  RecommendationModel tourGuide =
      RecommendationModel(title: "Tour Guide", fare: 1500, isSelected: false);

  onRecommendationSelect() {
    tourGuide =
        RecommendationModel(title: "Tour Guide", fare: 1500, isSelected: true);
    notifyListeners();
  }

  onRecommendationEdit() {
    tourGuide =
        RecommendationModel(title: "Tour Guide", fare: 1500, isSelected: false);
    notifyListeners();
  }

  //Insurance
  bool isInsuranceCollected = false;

  onTapInsurance() {
    isInsuranceCollected = !isInsuranceCollected;
    notifyListeners();
  }

  //Bill Breakdown

  double getTotal(
    double ticketSubTotal,
    double transportationSubTotal,
    double recommendationSubTotal,
    double insuranceSubTotal,
  ) {
    double mealSubTotal = 0;
    for (var i = 0; i < meals.length; i++) {
      if (meals[i].count > 0) {
        mealSubTotal = mealSubTotal + (meals[i].price * meals[i].count);
      }
    }
    return ticketSubTotal +
        transportationSubTotal +
        mealSubTotal +
        recommendationSubTotal +
        insuranceSubTotal;
  }
}

class PassengerModel {
  String name;
  int age;
  String gender;
  PassengerModel({
    required this.name,
    required this.age,
    required this.gender,
  });
}

class TransportationModel {
  String title;
  double fare;
  bool isSelected;
  TransportationModel(
      {required this.title, required this.fare, required this.isSelected});
}

class RecommendationModel {
  String title;
  double fare;
  bool isSelected;
  RecommendationModel(
      {required this.title, required this.fare, required this.isSelected});
}

class MealsModel {
  String title;
  double price;
  int count;
  MealsModel({required this.title, required this.price, required this.count});
}
