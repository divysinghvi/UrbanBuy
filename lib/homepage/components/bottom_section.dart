import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urbanbuy/cart/cart_model.dart';
import 'package:urbanbuy/homepage/components/Item_tile.dart';
import 'package:urbanbuy/homepage/components/product_item_tile.dart';

class BottomSection extends StatefulWidget {
  const BottomSection({Key? key});

  @override
  State<BottomSection> createState() => _BottomSectionState();
}

class _BottomSectionState extends State<BottomSection> {
  String selectedCategory = "All";

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FilterButton(
                  label: "All",
                  isSelected: selectedCategory == "All",
                  onTap: () => selectCategory("All"),
                ),
                FilterButton(
                  label: "Men",
                  isSelected: selectedCategory == "Men",
                  onTap: () => selectCategory("Men"),
                ),
                FilterButton(
                  label: "Women",
                  isSelected: selectedCategory == "Women",
                  onTap: () => selectCategory("Women"),
                ),
                FilterButton(
                  label: "Kids",
                  isSelected: selectedCategory == "Kids",
                  onTap: () => selectCategory("Kids"),
                ),
                FilterButton(
                  label: "Unisex",
                  isSelected: selectedCategory == "Unisex",
                  onTap: () => selectCategory("Unisex"),
                ),
                FilterButton(
                  label: "Home",
                  isSelected: selectedCategory == "Home",
                  onTap: () => selectCategory("Home"),
                ),
                FilterButton(
                  label: "Decor",
                  isSelected: selectedCategory == "Decor",
                  onTap: () => selectCategory("Decor"),
                ),
                FilterButton(
                  label: "Luggage",
                  isSelected: selectedCategory == "Luggage",
                  onTap: () => selectCategory("Luggage"),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          HomeProductCart(selectedCategory: selectedCategory),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterButton({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            backgroundColor: isSelected ? Colors.black : Colors.grey[200],
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: Text(
            label,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}

class HomeProductCart extends StatelessWidget {
  final String selectedCategory;

  const HomeProductCart({Key? key, required this.selectedCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartModel cartModel = Provider.of<CartModel>(context, listen: false);



    // Filter products based on the selected category and tag
    List<Map<String, dynamic>> filteredProducts = cartModel.products.where((product) {
      return (product['tag'] == selectedCategory || selectedCategory == "All");
    }).toList();

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: filteredProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
      ),
      itemBuilder: (context, index) {
        return ProductItemTile(
          itemName: filteredProducts[index]["name"],
          itemPrice: filteredProducts[index]["price"],
          imagePath: filteredProducts[index]["imagePath"],
          index: index,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ItemTile(
                  itemName: filteredProducts[index]["name"],
                  itemPrice: filteredProducts[index]["price"],
                  imagePath: filteredProducts[index]["imagePath"],
                  proDescription: filteredProducts[index]["description"],
                  index: index,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
