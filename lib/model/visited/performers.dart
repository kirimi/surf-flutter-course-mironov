import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/sight.dart';
import 'package:places/model/repository/visited_repository.dart';
import 'package:places/model/visited/changes.dart';

/// Добавление в список посещенных мест
class AddToVisitedPerformer extends FuturePerformer<void, AddToVisited> {
  final VisitedRepository visitedRepository;

  AddToVisitedPerformer(this.visitedRepository);

  @override
  Future<void> perform(AddToVisited change) =>
      visitedRepository.add(change.sight);
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
  final VisitedRepository visitedRepository;

  GetVisitedSightsPerformer({
    @required this.visitedRepository,
  }) : assert(visitedRepository != null);

  @override
  Future<List<Sight>> perform(GetVisitedSights change) async =>
      _getVisitedSights();

  /// Получает список Visited мест
  Future<List<Sight>> _getVisitedSights() async {
    final List<Sight> visited = await visitedRepository.getList();
    return visited;
  }
}
