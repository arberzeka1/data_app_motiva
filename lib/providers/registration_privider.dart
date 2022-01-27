// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterComponent {
  final String? name;
  final String? surname;
  final int? age;

  RegisterComponent({
    this.name,
    this.surname,
    this.age,
  });
}

class Registrations with ChangeNotifier {
  List<RegisterComponent> _reservations = [];
  RegisterComponent? _reservation;

  List<RegisterComponent> get reservations {
    return [..._reservations];
  }

  RegisterComponent get reservation {
    return _reservation!;
  }

  Future<void> postReservation(RegisterComponent reservationComponent) async {
    const url =
        'https://motiva-app-da935-default-rtdb.europe-west1.firebasedatabase.app/data.json';
    final response = await http.post(
      Uri.parse(url),
      body: json.encode(
        {
          'name': reservationComponent.name,
          'surname': reservationComponent.surname,
          'age': reservationComponent.age,
        },
      ),
    );
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((userId, userData) {
      _reservation = RegisterComponent();
    });

    notifyListeners();
  }

  Future<void> sortProducts(int isAsc) async {
    var url =
        'https://motiva-app-da935-default-rtdb.europe-west1.firebasedatabase.app/data.json';
    try {
      final response = await http.get(
        Uri.parse(url),
      );
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      List<RegisterComponent> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          RegisterComponent(
            name: prodData['name'],
            surname: prodData['surname'],
            age: prodData['age'],
          ),
        );
      });
      switch (isAsc) {
        case 1:
          loadedProducts.sort((a, b) => a.age!.compareTo(b.age!));
          break;
        case 2:
          loadedProducts.sort((a, b) => b.age!.compareTo(a.age!));
          break;
        default:
          null;
          break;
      }
      _reservations = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
