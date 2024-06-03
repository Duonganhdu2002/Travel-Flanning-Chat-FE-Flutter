class BestPlacesModel {
  double? averageRating;
  String? placeId;
  String? name;
  String? category;
  AddressBestPlaceModel? address;
  String? description;
  List<String>? photos;

  BestPlacesModel(
      {this.averageRating,
      this.placeId,
      this.name,
      this.category,
      this.address,
      this.description,
      this.photos});

  BestPlacesModel.fromJson(Map<String, dynamic> json) {
    averageRating = json['averageRating'];
    placeId = json['place_id'];
    name = json['name'];
    category = json['category'];
    address = json['address'] != null
        ? AddressBestPlaceModel.fromJson(json['address'])
        : null;
    description = json['description'];
    photos = json['photos'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['averageRating'] = averageRating;
    data['place_id'] = placeId;
    data['name'] = name;
    data['category'] = category;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['description'] = description;
    data['photos'] = photos;
    return data;
  }
}

class AddressBestPlaceModel {
  String? street;
  String? ward;
  String? district;
  String? landmarkId;
  String? provinceId;
  String? countryId;

  AddressBestPlaceModel(
      {this.street,
      this.ward,
      this.district,
      this.landmarkId,
      this.provinceId,
      this.countryId});

  AddressBestPlaceModel.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    ward = json['ward'];
    district = json['district'];
    landmarkId = json['landmark_id'];
    provinceId = json['province_id'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['ward'] = ward;
    data['district'] = district;
    data['landmark_id'] = landmarkId;
    data['province_id'] = provinceId;
    data['country_id'] = countryId;
    return data;
  }
}
