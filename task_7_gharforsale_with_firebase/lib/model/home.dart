import 'package:cloud_firestore/cloud_firestore.dart';

class Home {
  final String id;
  final String name;
  final String image;
  final double price;
  final String type;
  final String category;
  final double bathrooms;
  final double bedrooms; // Use double for consistency
  final double sqft;
  final String safetyRank;
  final String agentName;
  final String agentImage;
  final String agentRole;
  final String email;
  final String phone;
  final List<Amenity> amenities;
  final List<String> galleryImages;

  Home({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.type,
    required this.category,
    this.bathrooms = 0.0,
    this.bedrooms = 0.0,
    this.sqft = 0.0,
    this.safetyRank = "",
    required this.agentName,
    required this.agentImage,
    required this.agentRole,
    required this.email,
    required this.phone,
    required this.amenities,
    required this.galleryImages,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'type': type,
      'category': category,
      'bathrooms': bathrooms,
      'bedrooms': bedrooms,
      'sqft': sqft,
      'safetyRank': safetyRank,
      'amenities': amenities.map((amenity) => amenity.toMap()).toList(), // Convert Amenity objects to maps
      'agentName': agentName,
      'agentImage': agentImage,
      'agentRole': agentRole,
      'email': email,
      'phone': phone,
      'galleryImages': galleryImages,
    };
  }

  factory Home.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    print(data); // Check the entire data map

    return Home(
      id: doc.id,
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      type: data['type'] ?? '',
      category: data['category'] ?? '',
      bathrooms: (data['bathrooms'] ?? 0.0).toDouble(),
      bedrooms: double.tryParse(data['bedrooms']?.toString() ?? '0') ?? 0.0,
      sqft: (data['sqft'] ?? 0.0).toDouble(),
      safetyRank: data['safetyRank'] ?? '',

      agentName: data['agentName'] ?? '',
      agentImage: data['agent_image'] ?? '',
      agentRole: data['agent_role'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',

      amenities: List<Amenity>.from(
          (data['amenities'] as List<dynamic>? ?? [])
              .map((item) => Amenity.fromMap(item as Map<String, dynamic>)),
      ),
      galleryImages: List<String>.from(data['galleryImage'] ?? []),
    );
  }

}


class Amenity {
  final String name;
  final String image;

  Amenity({
    required this.name,
    required this.image,
  });

  // Convert the Amenity object to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
    };
  }

  // Factory method to create an Amenity instance from a map
  factory Amenity.fromMap(Map<String, dynamic> data) {
    return Amenity(
      name: data['name'] ?? '',
      image: data['image'] ?? '',
    );
  }
}
