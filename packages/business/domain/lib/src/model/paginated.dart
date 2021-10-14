class Paginated<T> {
  final int total;
  final int size;
  final int pages;
  final int page;
  final List<T> elements;

  const Paginated(
      {required this.total,
      required this.size,
      required this.pages,
      required this.page,
      required this.elements});
}
