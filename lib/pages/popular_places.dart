import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:flutter_app/components/back_icon.dart';
import 'package:flutter_app/models/place_model.dart';
import 'package:flutter_app/services/places_service.dart';

class PopularPlacesPage extends StatefulWidget {
  const PopularPlacesPage({super.key});

  @override
  State<PopularPlacesPage> createState() => _PopularPlacesPageState();
}

class _PopularPlacesPageState extends State<PopularPlacesPage> {
  List<BestPlacesModel> _cachedBestPlaces = [];
  int itemsToShow = 2;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPlaces();
  }

  Future<void> fetchPlaces() async {
    try {
      final places = await PlaceService.getBestPlaces();
      setState(() {
        _cachedBestPlaces = places;
      });
    } catch (e) {
      debugPrint('Failed to load places: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomBar(
        isTransparent: false,
        leftWidget: BackIcon(),
        centerWidget1: Text(
          "Popular Places",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        rightWidget: Text("               "),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            const Text(
              "All Popular Places",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: itemsToShow < _cachedBestPlaces.length
                    ? itemsToShow
                    : _cachedBestPlaces.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 320,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  final place = _cachedBestPlaces[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.07),
                          spreadRadius: 5,
                          blurRadius: 9,
                          offset: const Offset(-4, 8),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    "lib/images/Detail_img4.jpg",
                                    width: double.infinity,
                                    height: 140,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 9,
                                right: 9,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1B1E28)
                                        .withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.favorite_outline_outlined,
                                      color: Colors.white,
                                    ),
                                    iconSize: 18,
                                    onPressed: () {},
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            place.name ?? '',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 20,
                              ),
                              Text(
                                '${place.address?.street}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF7D848D),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 18,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 18,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${place.averageRating ?? 0}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.cottage_outlined,
                                size: 18,
                              ),
                              Text(
                                '${place.category ?? 0}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF7D848D),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (itemsToShow < _cachedBestPlaces.length)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    itemsToShow += 2; // Tăng số lượng mục hiển thị thêm 8
                    if (itemsToShow > _cachedBestPlaces.length) {
                      itemsToShow = _cachedBestPlaces
                          .length; // Đảm bảo không vượt quá tổng số mục
                    }
                  });
                },
                child: const Text('Show more'),
              ),
          ],
        ),
      ),
    );
  }
}
