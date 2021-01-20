import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/sight.dart';
import 'package:places/filter_utils.dart';
import 'package:places/main.dart';
import 'package:places/mocks.dart';
import 'package:places/search_history_state.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_screen.dart';
import 'package:places/ui/screen/sight_search_screen/widget/history_list.dart';
import 'package:places/ui/screen/sight_search_screen/widget/search_result_item.dart';
import 'package:places/ui/widgets/center_message.dart';
import 'package:places/ui/widgets/search_bar.dart';

/// Экран поиска места
///
/// В конструкторе передается текущий фильтр
class SightSearchScreen extends StatefulWidget {
  static const String routeName = 'SightSearchScreen';

  final Filter filter;

  const SightSearchScreen({
    Key key,
    @required this.filter,
  })  : assert(filter != null),
        super(key: key);

  @override
  _SightSearchScreenState createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  List<Sight> _sights;
  final SearchHistoryState _searchHistoryState = searchHistoryState;

  // Стрим, в котором данные результата запроса
  StreamController<List<Sight>> _streamController;

  // Подписка для отмены текущего запроса
  StreamSubscription<List> _loadingDataSubscr;

  // Таймер для паузы между запросом и вводом пользователя.
  Timer _debounceTimer;

  // Флаг о том, что происходит загрузка новых данных
  bool _isLoading = false;

  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _sights = mocks;
    _streamController = StreamController();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.sightSearchAppBar),
        leading: IconButton(
          onPressed: _onBack,
          icon: SvgIcon(
            icon: SvgIcons.arrowLeft,
            color: Theme.of(context).primaryColor,
          ),
        ),
        bottom: SearchBar(
          controller: _textEditingController,
          onChanged: _onSearch,
          onClear: _onClear,
        ),
      ),
      body: Column(
        children: [
          if (_isLoading)
            const SizedBox(
              height: 40.0,
              width: 40.0,
              child: CircularProgressIndicator(),
            ),
          Expanded(
            child: StreamBuilder<List<Sight>>(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData && !snapshot.hasError) {
                  if (snapshot.data.isNotEmpty) {
                    return _buildResultList(snapshot.data);
                  } else {
                    return _buildEmpty();
                  }
                }
                if (snapshot.hasError) {
                  return _buildError();
                }
                return _buildHistory();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _streamController.close();
    _loadingDataSubscr?.cancel();
    _debounceTimer?.cancel();
    _textEditingController.dispose();
    super.dispose();
  }

  Widget _buildResultList(List<Sight> sights) {
    return ListView.builder(
      itemCount: sights.length,
      itemBuilder: (context, index) {
        return SearchResultItem(
          sight: sights[index],
          onTap: () => _onCardTap(sights[index]),
        );
      },
    );
  }

  Widget _buildHistory() {
    return HistoryList(
      searchHistoryState: _searchHistoryState,
      onSelect: (request) {
        _textEditingController.text = request;
        _onSearch(request, performNow: true);
      },
    );
  }

  Widget _buildError() {
    return const CenterMessage(
      icon: SvgIcons.error,
      title: AppStrings.sightSearchErrorTitle,
      subtitle: AppStrings.sightSearchErrorSubtitle,
    );
  }

  Widget _buildEmpty() {
    return const CenterMessage(
      icon: SvgIcons.search,
      title: AppStrings.sightSearchEmptyTitle,
      subtitle: AppStrings.sightSearchEmptySubtitle,
    );
  }

  // performNow - флаг, что запрос должен немедленно выполнится.
  // Например при книке на Историю
  Future<void> _onSearch(String value, {bool performNow = false}) async {
    _debounceTimer?.cancel();
    if (value != '') {
      // делаем запрос только через секунду после последнего ввода пользователя
      final int time = performNow ? 0 : 1000;
      _debounceTimer = Timer(Duration(milliseconds: time), () {
        _setLoading(true);
        // отменяем предыдущий запрос.
        _loadingDataSubscr?.cancel();
        _loadingDataSubscr = _doSearch(value).asStream().listen((searchResult) {
          _setLoading(false);
          _streamController.sink.add(searchResult);
          // добавляем в историю запросы, которые удачно закончились
          _searchHistoryState.add(value);
        }, onError: (error) {
          _setLoading(false);
          _streamController.addError(error);
        });
      });
    }
  }

  // Поиск с учетом фильтра
  Future<List<Sight>> _doSearch(String value) async {
    // имитируем, что запрос длится 1 сек.
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        // применяем фильтр
        final filteredSights =
            filteredSightList(_sights, widget.filter, currentPoint);

        // ищем подстроку в названии
        final result = filteredSights.where((sight) =>
            sight.name.toLowerCase().contains(value.trim().toLowerCase()));

        return result.toList();

        // Имитируем ошибку
        // return Future.error("loading error");
      },
    );
  }

  void _setLoading(bool isLoading) {
    setState(() => _isLoading = isLoading);
  }

  void _onCardTap(Sight sight) {
    Navigator.of(context).pushNamed(
      SightDetailsScreen.routeName,
      arguments: sight,
    );
  }

  // при очистке текстового поля
  void _onClear() {
    // посылаем null в стрим, чтобы показать историю
    _streamController.sink.add(null);
  }

  void _onBack() => Navigator.of(context).pop();
}
