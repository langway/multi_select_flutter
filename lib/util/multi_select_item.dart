/// A model class used to represent a selectable item.
class MultiSelectItem<T> {
  final T value;
  final String label;
  bool selected = false;
  String? imageUrl;

  MultiSelectItem(this.value, this.label,
      {this.selected = false, this.imageUrl});
}
