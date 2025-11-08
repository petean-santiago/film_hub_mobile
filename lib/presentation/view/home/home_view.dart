import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FilmHub")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: 20, 
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,        
            crossAxisSpacing: 8,     
            mainAxisSpacing: 8,       
            childAspectRatio: 0.65,   
          ),
          itemBuilder: (context, index) {
            return Image.network('https://m.media-amazon.com/images/I/811lT7khIrL._AC_UF894,1000_QL80_.jpg');
          },
        ),
      ),
    );
  }
}


