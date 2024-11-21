// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cinema_booking/screens/reservation_screen.dart';
import 'package:cinema_booking/widgets/movie_info.dart';
import 'package:flutter/material.dart';

import 'package:cinema_booking/cosntants/constants.dart';
import 'package:cinema_booking/models/movie_model.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;
  const MovieDetailPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        title: const Center(
          child: Text(
            "Movie Detail",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 270,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Hero(
                      tag: movie.poster,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                          movie.poster,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MovieInfo(
                            icon: Icons.videocam_rounded,
                            name: "General",
                            value: movie.genre),
                        MovieInfo(
                            icon: Icons.timer,
                            name: "Duration",
                            value:
                                formatTime(Duration(minutes: movie.duration))),
                        MovieInfo(
                            icon: Icons.star,
                            name: "Rating",
                            value: "${movie.rating}/10"),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  movie.title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                child: Divider(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              const Text(
                "Synopsis",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                movie.synopsis,
                style: const TextStyle(
                    fontSize: 12, color: Colors.white60, height: 2),
              ),
              const SizedBox(
                height: 140,
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Color(0xff1c1c27),
              blurRadius: 60,
              spreadRadius: 80,
            ),
          ]),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.transparent,
            onPressed: () {},
            label: MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ReservationScreen(),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              color: buttonColor,
              height: 60,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Center(
                  child: Text(
                    "Get Reservation",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
