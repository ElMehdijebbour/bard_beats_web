import 'package:bardbeatsdash/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SongWidget extends StatelessWidget {
  // Static data from constants
  final String title;
  final String artistName;
  final int year;
  final String imagePath; // Assuming you have a path to the image

  SongWidget({
    Key? key,
    required this.title,
    required this.artistName,
    required this.year,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100, // Set width to 80
      height: 100,
      child: Container(
        padding: const EdgeInsets.all(6),
        margin: const EdgeInsets.only(top: 100.0,left: 20.0,right: 100.0),
        decoration: BoxDecoration(
          color: const Color(0x5E33373B),
          borderRadius: BorderRadius.circular(15), // Circular borders of 15
        ),
        child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15), // Circular borders of 15
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            artistName,
            style: const TextStyle(fontSize: 14, color: Colors.white70),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
            year.toString(),
            style: const TextStyle(fontSize: 14, color: AppColors.primaryColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
