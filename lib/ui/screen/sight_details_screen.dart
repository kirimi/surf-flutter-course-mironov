import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/widgets/big_button.dart';

class SightDetailsScreen extends StatefulWidget {
  final Sight sight;

  const SightDetailsScreen({Key key, @required this.sight}) : super(key: key);

  @override
  _SightDetailsScreenState createState() => _SightDetailsScreenState();
}

class _SightDetailsScreenState extends State<SightDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.sight.url),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 36.0),
                  child: Container(
                    height: 32.0,
                    width: 32.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 16.0,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(widget.sight.name, style: _titleStyle),
                    SizedBox(height: 2.0),
                    Text(widget.sight.type, style: _typeStyle),
                    SizedBox(height: 24.0),
                    Text(widget.sight.details, style: _detailsStyle),
                    SizedBox(height: 24.0),
                    BigButton(
                      text: _routeToBtnText.toUpperCase(),
                      icon: Icons.repeat_outlined,
                      onPressed: () {},
                    ),
                    SizedBox(height: 32.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BigButton(
                          text: _planBtnText,
                          icon: Icons.calendar_today_outlined,
                          bgColor: Colors.transparent,
                          disabledBgColor: Colors.transparent,
                          color: Colors.black,
                          style: _btnStyle,
                          enabled: false,
                          onPressed: () {},
                        ),
                        BigButton(
                          text: _toFavoriteBtnText,
                          icon: Icons.favorite_outline,
                          bgColor: Colors.transparent,
                          disabledBgColor: Colors.transparent,
                          color: Colors.black,
                          style: _btnStyle,
                          enabled: true,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _routeToBtnText = 'Построить маршрут';
const String _planBtnText = 'Запланировать';
const String _toFavoriteBtnText = 'В избранное';

const _titleStyle = TextStyle(
  color: Color(0xFF3B3E5B),
  fontWeight: FontWeight.w700,
  fontSize: 24.0,
  height: 28.0 / 24.0,
);

const _detailsStyle = TextStyle(
  color: Color(0xFF3B3E5B),
  fontWeight: FontWeight.w400,
  fontSize: 14.0,
  height: 18.0 / 14.0,
);

const _typeStyle = TextStyle(
  color: Color(0xFF3B3E5B),
  fontWeight: FontWeight.w700,
  fontSize: 14.0,
  height: 18.0 / 14.0,
);

const _btnStyle = TextStyle(
  color: Color(0xFF3B3E5B),
  fontWeight: FontWeight.w400,
  fontSize: 14.0,
  letterSpacing: 0.3,
  height: 18.0 / 14.0,
);
