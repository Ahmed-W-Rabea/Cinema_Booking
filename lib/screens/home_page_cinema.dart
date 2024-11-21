import 'dart:math';

import 'package:cinema_booking/cosntants/constants.dart';
import 'package:cinema_booking/models/category_model.dart';
import 'package:cinema_booking/models/movie_model.dart';
import 'package:cinema_booking/screens/detail_page.dart';
import 'package:flutter/material.dart';

class HomePageCinema extends StatefulWidget {
  const HomePageCinema({super.key});

  @override
  State<HomePageCinema> createState() => _HomePageCinemaState();
}

class _HomePageCinemaState extends State<HomePageCinema> {
  late PageController controller;
  double pageoffset = 1;
  int currentIndex = 1;
  @override
  void initState() {
    controller = PageController(initialPage: 1, viewportFraction: 0.6)
      ..addListener(() {
        setState(() {
          pageoffset = controller.page!;
        });
      });
    super.initState();
  }

  void despose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: headerParts(),
      body: Column(
        children: [
          const SizedBox(
            height: 22,
          ),
          searchField(),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Category",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Text(
                          "see all",
                          style: TextStyle(
                              color: buttonColor,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: buttonColor,
                          size: 15,
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                categoryItems(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "showing this month",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: Stack(
                alignment: Alignment.center,
                children: [
                  PageView.builder(
                      controller: controller,
                      onPageChanged: (index) {
                        setState(() {
                          currentIndex = index % movies.length;
                        });
                      },
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        double scale =
                            max(0.6, (1 - (pageoffset - index).abs() + 0.6));
                        double angle = (controller.position.haveDimensions
                                ? index.toDouble() - (controller.page ?? 0)
                                : index.toDouble() - 1) *
                            5;
                        angle = angle.clamp(-5, 5);
                        final movie = movies[index % movies.length];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MovieDetailPage(movie: movie),
                              ),
                            );
                          },
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 100 - (scale / 1.6 * 100)),
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Transform.rotate(
                                  angle: angle * pi / 100,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Hero(
                                      tag: movie.poster,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: Image.network(
                                          movie.poster,
                                          height: 250,
                                          width: 180,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                  Positioned(
                      left: 115,
                      top: 275,
                      child: Row(
                        children: List.generate(
                          movies.length,
                          (index) => AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            margin: EdgeInsets.only(right: 15),
                            width: currentIndex == index ? 30 : 10,
                            height: 8,
                            decoration: BoxDecoration(
                                color: currentIndex == index
                                    ? buttonColor
                                    : Colors.white24,
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                      ))
                ],
              ))
            ],
          ))
        ],
      ),
    );
  }

  Row categoryItems() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
          categories.length,
          (index) => Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(
                      categories[index].emoji,
                      fit: BoxFit.cover,
                      height: 30,
                      width: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    categories[index].name,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  )
                ],
              )),
    );
  }

  Padding searchField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 16),
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.white54),
          prefixIcon: Icon(
            Icons.search,
            size: 34,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(27),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }

  AppBar headerParts() {
    return AppBar(
      backgroundColor: appBackgroundColor,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Welcome Ahmed",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                            color: Colors.white54),
                      ),
                      TextSpan(
                        text: "👋",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Let's relax and watch a movie!",
                  style: TextStyle(
                      height: 0.6,
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1),
                )
              ],
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      image: AssetImage("assets/images/ahmed.jpg"),
                      fit: BoxFit.cover)),
            )
          ],
        ),
      ),
    );
  }
}
