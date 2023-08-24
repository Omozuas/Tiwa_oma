import 'package:flutter/material.dart';

class BackgroundImg extends StatelessWidget {
  const BackgroundImg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.black12, Colors.black45],
        begin: Alignment.bottomCenter,
        end: Alignment.center,
      ).createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
          // width: double.infinity,
          // height: double.infinity,
          decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
                'assets/images/portrait-of-young-woman-smiling-isolated.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken)),
      )),
    );
  }
}
