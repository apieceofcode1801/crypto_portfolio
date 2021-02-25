extension IterableExtension<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (map, element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}

extension StringExtension on String {
  String numberWithComma() {
    RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    Function mathFunc = (Match match) => '${match[1]},';
    return replaceAllMapped(reg, mathFunc);
  }
}
