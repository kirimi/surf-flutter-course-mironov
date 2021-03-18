import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/filter_request.dart';
import 'package:places/domain/sight.dart';
import 'package:places/model/repository/sight_repository.dart';
import 'package:places/model/repository/visited_repository.dart';
import 'package:places/model/visited/changes.dart';

/// Добавление в список посещенных мест
class AddToVisitedPerformer extends FuturePerformer<void, AddToVisited> {
  final VisitedRepository visitedRepository;

  AddToVisitedPerformer(this.visitedRepository);

  @override
  Future<void> perform(AddToVisited change) =>
      visitedRepository.add(change.sight.id);
}

/// Удаление из списка посещенных мест
class RemoveFromVisitedPerformer
    extends FuturePerformer<void, RemoveFromVisited> {
  final VisitedRepository visitedRepository;

  RemoveFromVisitedPerformer(this.visitedRepository);

  @override
  Future<void> perform(RemoveFromVisited change) =>
      visitedRepository.remove(change.sight.id);
}

/// Получение списка посещенных мест
class GetVisitedSightsPerformer
    extends FuturePerformer<List<Sight>, GetVisitedSights> {
  final SightRepository sightRepository;
  final VisitedRepository visitedRepository;

  GetVisitedSightsPerformer({
    @required this.sightRepository,
    @required this.visitedRepository,
  })  : assert(sightRepository != null),
        assert(visitedRepository != null);

  @override
  Future<List<Sight>> perform(GetVisitedSights change) async =>
      _getVisitedSights();

  /// Получает список Visited мест
  Future<List<Sight>> _getVisitedSights() async {
    // Получаем id мест добавленных в visited
    final Set<int> visitedIds = await visitedRepository.getList();

    // получаем все места
    final result = await sightRepository.getFilteredList(const FilterRequest());

    // остаются только уже посещенные
    final visitedPlaces = result.where((e) => visitedIds.contains(e.first.id));

    final sights = visitedPlaces.map((e) => e.first).toList();

    return sights;
  }
}
