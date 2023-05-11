const List<int> C4DStoresIDS = [
  1, // c4d prod id
  // 34, // Mohsen dev id  (test)
];

bool isC4D(int id) {
  return C4DStoresIDS.contains(id);
}
