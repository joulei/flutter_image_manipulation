import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Image Grid'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<String> imageList = const [
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
    'assets/images/image3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 32,
        ),
        itemCount: 2048, // 32 (columns) * 64 (rows)
        itemBuilder: (context, index) {
          if (index % 3 == 0) {
            return AnimatedBuilder(
              animation: _controller,
              child: Image.asset(imageList[0]),
              builder: (BuildContext context, Widget? _widget) {
                return new Transform.rotate(
                  angle: _controller.value * 2.0 * pi,
                  child: _widget!,
                );
              },
            );
          } else if (index % 3 == 1) {
            return AnimatedBuilder(
              animation: _controller,
              child: Image.asset(imageList[1]),
              builder: (BuildContext context, Widget? _widget) {
                return Opacity(
                  opacity: _controller.value,
                  child: _widget!,
                );
              },
            );
          } else {
            return AnimatedBuilder(
              animation: _controller,
              child: Image.asset(imageList[2]),
              builder: (BuildContext context, Widget? _widget) {
                return Transform.scale(
                  scale: _controller.value,
                  child: _widget!,
                );
              },
            );
          }
        },
      ),
    );
  }
}
