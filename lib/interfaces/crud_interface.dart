abstract class CrudInterface<T> {
  Future<List<T>> fetchAll();
  Future<T> create(T item);
  Future<T> update(T item);
  Future<String> delete(int itemId);
  Future<T> find(int itemId);
  Future<List<T>> search(String itemName);
}
