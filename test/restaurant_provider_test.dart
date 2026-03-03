import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_dicoding/providers/restaurant_provider.dart';
import 'package:restaurant_dicoding/models/restaurant.dart';
import 'package:restaurant_dicoding/services/api_service.dart';

import 'helpers/test_helper.mocks.dart';

void main() {
  late RestaurantProvider provider;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    provider = RestaurantProvider(mockApiService);
  });

  final fakeRestaurant = Restaurant(
    id: '1',
    name: 'Test Restaurant',
    description: 'Test Description',
    pictureId: '1',
    city: 'Jakarta',
    rating: 4.5,
  );

  test('Should return list of restaurants when API call successful', () async {
    when(mockApiService.fetchRestaurants())
        .thenAnswer((_) async => [fakeRestaurant]);

    await provider.fetchRestaurants();

    expect(provider.state, ResultState.hasData);
    expect(provider.restaurants.length, 1);
    expect(provider.restaurants.first.name, 'Test Restaurant');
  });

  test('Should return error when API call fails', () async {
    when(mockApiService.fetchRestaurants())
        .thenThrow(Exception("Failed to load"));

    await provider.fetchRestaurants();

    expect(provider.state, ResultState.error);
    expect(provider.message.contains("Failed"), true);
  });
}