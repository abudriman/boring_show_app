import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomExplicit extends StatefulWidget {
  const CustomExplicit({Key? key}) : super(key: key);

  @override
  _CustomExplicitState createState() => _CustomExplicitState();
}

class _CustomExplicitState extends State<CustomExplicit>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Custom explicit animation'),
        ),
        body: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            BeamAnimation(animation: animationController!),
            CachedNetworkImage(
                imageUrl:
                    'https://cdn.pixabay.com/photo/2020/01/19/15/02/ufo-4778062_960_720.png'),
          ],
        ));
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
}

class BeamAnimation extends AnimatedWidget {
  const BeamAnimation({
    Key? key,
    required Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    Animation<double> animation = listenable as Animation<double>;
    return ClipPath(
      clipper: const BeamClipper(),
      child: Container(
        height: 1000,
        decoration: BoxDecoration(
            gradient: RadialGradient(
                colors: const [Colors.yellow, Colors.transparent],
                stops: [0, animation.value],
                radius: 1.5)),
      ),
    );
  }
}

class BeamClipper extends CustomClipper<Path> {
  const BeamClipper();

  @override
  getClip(Size size) {
    return Path()
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(size.width / 2, size.height / 2)
      ..close();
  }

  /// Return false always because we always clip the same area.
  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}
