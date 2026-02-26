class FavoriteRestaurant {
  final String id;
  final String name;
  final String city;
  final String pictureId;
  final double rating;

  FavoriteRestaurant({
    required this.id,
    required this.name,
    required this.city,
    required this.pictureId,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'pictureId': pictureId,
      'rating': rating,
    };
  }

  factory FavoriteRestaurant.fromMap(Map<String, dynamic> map) {
    return FavoriteRestaurant(
      id: map['id'],
      name: map['name'],
      city: map['city'],
      pictureId: map['pictureId'],
      rating: map['rating'],
    );
  }
}