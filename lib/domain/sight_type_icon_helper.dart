import 'package:flutter/material.dart';

/// Функция возвращает [IconData] по имени [iconName] иконки,
/// если нет такой, то иконку по-умолчанию
IconData getIconByName(String iconName) {
  IconData icon;
  switch (iconName) {
    case 'cinema':
      icon = Icons.video_call;
      break;
    case 'restaurant':
      icon = Icons.dinner_dining;
      break;
    case 'special':
      icon = Icons.star;
      break;
    case 'park':
      icon = Icons.park;
      break;
    case 'museum':
      icon = Icons.museum;
      break;
    case 'cafe':
      icon = Icons.local_cafe;
      break;
    default:
      icon = Icons.map;
  }
  return icon;
}
