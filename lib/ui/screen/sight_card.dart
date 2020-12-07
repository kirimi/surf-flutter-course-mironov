import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard({Key key, this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(16.0)),
      child: Container(
        height: 188.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(sight.url),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(sight.type, style: _typeStyle),
                      Icon(
                        Icons.favorite_outline,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: _bottomBgrColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sight.name,
                        maxLines: 2,
                        style: _titleStyle,
                      ),
                      Text(
                        sight.details,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: _detailsStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _titleStyle = TextStyle(
  color: Color(0xFF3B3E5B),
  fontWeight: FontWeight.w500,
  fontSize: 16.0,
  height: 20.0 / 16.0,
);

const _detailsStyle = TextStyle(
  color: Color(0xFF7C7E92),
  fontWeight: FontWeight.w400,
  fontSize: 14.0,
  height: 18.0 / 14.0,
);

const _typeStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w700,
  fontSize: 14.0,
  height: 18.0 / 14.0,
);

const _bottomBgrColor = Color(0xfff5f5f5);
