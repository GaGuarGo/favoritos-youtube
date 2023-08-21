import 'package:favoritos_youtube/delegates/data_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: SizedBox(
          height: 25,
          child: SvgPicture.asset("images/youtube-logo.svg"),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.black87,
        actions: [
          const Align(
            alignment: Alignment.center,
            child: Text("0"),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.star)),
          IconButton(
              onPressed: () async {
                String? result =
                    await showSearch(context: context, delegate: DataSearch());
              },
              icon: const Icon(Icons.search)),
        ],
      ),
    );
  }
}
