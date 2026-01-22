import '../models/pond.dart';
import '../models/fish_inventory.dart';
import '../models/feed.dart';
import '../models/health_monitoring.dart';

class ApiService {
  static const String baseUrl = 'https://mockapi.example.com'; // Replace with actual mock API

  Future<List<Pond>> fetchPonds() async {
    // Mock data for now
    await Future.delayed(const Duration(seconds: 1));
    return [
      Pond(
        id: '1',
        name: 'Kolam 1',
        length: 10.0,
        width: 5.0,
        depth: 2.0,
        status: 'healthy',
        imageUrl: 'assets/images/pond1.jpg',
      ),
      Pond(
        id: '2',
        name: 'Kolam 2',
        length: 8.0,
        width: 4.0,
        depth: 1.5,
        status: 'moderate',
        imageUrl: 'assets/images/pond2.jpg',
      ),
    ];
  }

  Future<void> addPond(Pond pond) async {
    // Mock add
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> updatePond(Pond pond) async {
    // Mock update
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> deletePond(String id) async {
    // Mock delete
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<List<FishInventory>> fetchFishInventories() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      FishInventory(
        id: '1',
        pondId: '1',
        quantity: 1000,
        averageWeight: 0.5,
        date: '2023-10-01',
      ),
      FishInventory(
        id: '2',
        pondId: '2',
        quantity: 800,
        averageWeight: 0.6,
        date: '2023-10-01',
      ),
    ];
  }

  Future<void> addFishInventory(FishInventory inventory) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> updateFishInventory(FishInventory inventory) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> deleteFishInventory(String id) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<List<Feed>> fetchFeeds() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Feed(
        id: '1',
        name: 'Pakan Pelet',
        type: 'Pelet',
        quantity: 50.0,
        unit: 'kg',
        price: 50000.0,
        date: '2023-10-01',
      ),
      Feed(
        id: '2',
        name: 'Pakan Cangkang',
        type: 'Cangkang',
        quantity: 30.0,
        unit: 'kg',
        price: 30000.0,
        date: '2023-10-01',
      ),
    ];
  }

  Future<void> addFeed(Feed feed) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> updateFeed(Feed feed) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> deleteFeed(String id) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<List<HealthMonitoring>> fetchHealthMonitorings() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      HealthMonitoring(
        id: '1',
        pondId: '1',
        parameter: 'pH',
        value: 7.2,
        status: 'Normal',
        date: '2023-10-01',
        notes: 'Air bersih',
      ),
      HealthMonitoring(
        id: '2',
        pondId: '2',
        parameter: 'Oksigen',
        value: 6.5,
        status: 'Baik',
        date: '2023-10-01',
        notes: 'Aerasi cukup',
      ),
    ];
  }

  Future<void> addHealthMonitoring(HealthMonitoring monitoring) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> updateHealthMonitoring(HealthMonitoring monitoring) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> deleteHealthMonitoring(String id) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}