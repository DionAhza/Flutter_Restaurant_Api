class RestaurantDetail {

  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String address;
  final double rating;

  final List<MenuItem> foods;
  final List<MenuItem> drinks;

  final List<CustomerReview> customerReviews;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.address,
    required this.rating,
    required this.foods,
    required this.drinks,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(
      Map<String, dynamic> json) {

    return RestaurantDetail(

      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['pictureId'],
      city: json['city'],
      address: json['address'],
      rating: json['rating'].toDouble(),

      foods: List<MenuItem>.from(
        json['menus']['foods'].map(
          (x) => MenuItem.fromJson(x),
        ),
      ),

      drinks: List<MenuItem>.from(
        json['menus']['drinks'].map(
          (x) => MenuItem.fromJson(x),
        ),
      ),

      customerReviews:
          List<CustomerReview>.from(
        json['customerReviews'].map(
          (x) =>
              CustomerReview.fromJson(x),
        ),
      ),

    );

  }

}

class MenuItem {

  final String name;

  MenuItem({
    required this.name,
  });

  factory MenuItem.fromJson(
      Map<String, dynamic> json) {

    return MenuItem(
      name: json['name'],
    );

  }

}

class CustomerReview {

  final String name;
  final String review;
  final String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(
      Map<String, dynamic> json) {

    return CustomerReview(
      name: json['name'],
      review: json['review'],
      date: json['date'],
    );

  }

}