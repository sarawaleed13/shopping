import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShoppingPage(),
    );
  }
}

class ShoppingPage extends StatefulWidget {
  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  // Sample data for products and hot offers
  final List<Image> images = [
    Image.asset('assets/images/1.jpg', fit: BoxFit.cover),
    Image.asset('assets/images/2.jpg', fit: BoxFit.cover),
    Image.asset('assets/images/3.jpg', fit: BoxFit.cover),
  ];
  final List<Product> items = const [
    Product("item1", "assets/images/1.jpg"),
    Product("item2", "assets/images/2.jpg"),
    Product("item3", "assets/images/3.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    // MediaQuery for responsive design
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shopping App',
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05), // 5% padding from width
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProductCarousel(images: images, screenWidth: screenWidth),
              SizedBox(height: screenHeight * 0.02), // 2% space
              ProductList(products: items, screenWidth: screenWidth),
              HotOffers(products: items, screenWidth: screenWidth),
            ],
          ),
        ),
      ),
    );
  }
}

class HotOffers extends StatelessWidget {
  final List<Product> products;
  final double screenWidth;

  const HotOffers({super.key, required this.products, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.05), // 5% padding from width
          child: const Text('Hot Offers', style: TextStyle(fontSize: 20)),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Container(
                width: screenWidth * 0.35, // 35% of screen width for each item
                margin: EdgeInsets.only(right: screenWidth * 0.05), // 5% space between items
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(products[index].imag, fit: BoxFit.cover),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(products[index].name, textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ProductCarousel extends StatelessWidget {
  final List<Image> images;
  final double screenWidth;

  const ProductCarousel({super.key, required this.images, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Our Products', style: TextStyle(fontSize: 20)),
        SizedBox(
          height: 200,
          child: PageView(
            children: images.map((image) => SizedBox(width: screenWidth, child: image)).toList(),
          ),
        ),
      ],
    );
  }
}

class ProductList extends StatelessWidget {
  final List<Product> products;
  final double screenWidth;

  const ProductList({super.key, required this.products, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Product Grid', style: TextStyle(fontSize: 20)),
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: screenWidth > 600 ? 3 : 2, // 2 items on small screens, 3 on larger ones
            crossAxisSpacing: screenWidth * 0.03, // 3% space between columns
            mainAxisSpacing: screenWidth * 0.03, // 3% space between rows
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductItem(product: products[index], screenWidth: screenWidth);
          },
        ),
      ],
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final double screenWidth;

  const ProductItem({super.key, required this.product, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(product.imag, fit: BoxFit.cover),
          Text(product.name, style: TextStyle(fontSize: screenWidth * 0.04)), // responsive text size
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final String imag;

  const Product(this.name, this.imag);
}
