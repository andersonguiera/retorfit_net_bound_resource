import 'package:domain/domain.dart';

enum StateCalls { idle, processing, finish, error }

class PackageOfCalls<T> {
  final int first;
  final int last;
  late final List<int> range;
  final Future<T> Function(int order) future;
  late List<Future<T> Function()> calls;
  StateCalls state = StateCalls.idle;

  PackageOfCalls(this.first, this.last, this.future) {
    var length = last - first + 1;
    range = List.generate(length, (index) => index + first);
    calls = List.generate(length, (index) => () => future(range[index]));
  }

  Future<List<T>> call() async {
    List<T> results = [];
    List<Future<T> Function()> successCalls = [];
    print('$first-$last');
    state = StateCalls.processing;
    await Future.wait(calls
        .map((e) => e.call().then((value) {
      print('Success: ${(value as Paginated).page}');
      results.add(value);
      successCalls.add(e);
    }))
        .toList())
        .then((value) {
      state = StateCalls.finish;
    }).onError((error, stackTrace) {
      state = StateCalls.error;
    });

    for (var success in successCalls) {
      calls.remove(success);
    }

    return results;
  }

  bool get isFinish => state == StateCalls.finish;

  bool get isError => state == StateCalls.error;

  int get totalFinish => last - first + 1 - totalErrors;

  int get totalErrors => calls.length;
}

class CallsManager<T> {
  int first;
  int last;
  int threshold;
  final Future<T> Function(int order) future;
  late final List<PackageOfCalls<T>> packages;

  CallsManager(this.first, this.last, this.future, [this.threshold = 10]);

  void prepare() {
    int totalCalls = last - first + 1;
    int totalPackages =
        totalCalls ~/ threshold + (totalCalls % threshold > 0 ? 1 : 0);
    List<int> firsts =
    List.generate(totalPackages, (index) => index * threshold + first);
    List<int> lasts =
    List.generate(totalPackages, (index) => firsts[index] + threshold - 1);
    lasts[lasts.length - 1] =
    lasts[lasts.length - 1] > last ? last : lasts[lasts.length - 1];

    packages = List.generate(
        totalPackages,
            (index) => PackageOfCalls<T>(
            firsts[index], lasts[index], (order) => future(order)));
  }

  Future<List<T>> calls() async {
    List<T> results = [];
    await _callList(packages).then((value) => results = value);
    print(
        'Errors: ${packages.map((e) => e.totalErrors).reduce((value, element) => value + element)}');
    return results;
  }

  Future<List<T>> _callList(List<PackageOfCalls<T>> list) async {
    List<T> resultCalls = [];
    for (var package in list) {
      resultCalls.addAll(await package.call());
    }
    return resultCalls;
  }

  bool get isFinish => packages
      .map((e) => e.isFinish)
      .reduce((value, element) => value && element);

  bool get isError => packages
      .map((e) => e.isError)
      .reduce((value, element) => value || element);

  int get countErrors => packages
      .map((e) => e.totalErrors)
      .reduce((value, element) => value + element);

  int get countSuccess => packages
      .map((e) => e.totalFinish)
      .reduce((value, element) => value + element);
}