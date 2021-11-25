class EntryInfo {
  final String id;
  final String name;
  // i dont need the other details

  EntryInfo({
    this.id,
    this.name,
  });
  factory EntryInfo.fromJson(Map<String, dynamic> json) {
    return EntryInfo(
      id: json['id'],
      name: json['name'],
    );
  }
}
