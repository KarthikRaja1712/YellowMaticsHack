import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;

class CardWidget extends StatelessWidget {
  final bool gradient;
  final bool button;
  final Color? color;
  final double? width;
  final double? height;
  final Widget child;
  final int? duration;
  final Border? border;
  final VoidCallback? func;

  const CardWidget({
    required this.gradient,
    required this.button,
    this.color,
    this.width,
    this.height,
    required this.child,
    this.duration,
    this.func,
    this.border,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: material.BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0, 4),
            color: material.Colors.black26,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: material.BorderRadius.circular(10),
        child: material.AnimatedContainer(
          duration: Duration(milliseconds: duration ?? 500),
          width: width ?? MediaQuery.of(context).size.width * 0.9,
          height: height ?? MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
            border:
                border ?? Border.all(color: material.Colors.white, width: 0),
            color: color ?? material.Colors.green,
            gradient: gradient
                ? LinearGradient(
                    colors: [material.Colors.green, material.Colors.lightGreen])
                : null,
          ),
          child: button
              ? material.MaterialButton(
                  padding: material.EdgeInsets.zero,
                  elevation: 0,
                  child: child,
                  onPressed: func,
                )
              : child,
        ),
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final String thumbnail;
  final String title;
  final String channelName;
  final String views;
  final String duration;

  const VideoCard({
    required this.thumbnail,
    required this.title,
    required this.channelName,
    required this.views,
    required this.duration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return material.Padding(
      padding: const material.EdgeInsets.all(10.0),
      child: material.Column(
        crossAxisAlignment: material.CrossAxisAlignment.start,
        children: [
          material.Container(
            width: double.infinity,
            height: 200,
            decoration: material.BoxDecoration(
              borderRadius: material.BorderRadius.circular(10),
              image: material.DecorationImage(
                image: material.AssetImage(thumbnail),
                fit: material.BoxFit.cover,
              ),
            ),
            child: material.Align(
              alignment: Alignment.bottomRight,
              child: material.Container(
                padding: const material.EdgeInsets.all(5),
                margin: const material.EdgeInsets.all(8),
                decoration: material.BoxDecoration(
                  color: material.Colors.black54,
                  borderRadius: material.BorderRadius.circular(5),
                ),
                child: material.Text(
                  duration,
                  style: const material.TextStyle(
                    color: material.Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
          const material.SizedBox(height: 10),
          material.Row(
            crossAxisAlignment: material.CrossAxisAlignment.start,
            children: [
              material.CircleAvatar(
                backgroundColor: material.Colors.grey[300],
                radius: 20,
                child: const material.Icon(material.Icons.person,
                    color: material.Colors.white),
              ),
              const material.SizedBox(width: 10),
              material.Expanded(
                child: material.Column(
                  crossAxisAlignment: material.CrossAxisAlignment.start,
                  children: [
                    material.Text(
                      title,
                      maxLines: 2,
                      overflow: material.TextOverflow.ellipsis,
                      style: const material.TextStyle(
                        fontSize: 16,
                        fontWeight: material.FontWeight.bold,
                      ),
                    ),
                    material.Text(
                      "$channelName • $views views",
                      style: const material.TextStyle(
                        fontSize: 14,
                        color: material.Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
