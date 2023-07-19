class CreatedAt {
  int? timestamp;

  CreatedAt({this.timestamp});

  factory CreatedAt.fromJson(Map<String, dynamic> json) => CreatedAt(
        timestamp: json['timestamp'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp,
      };
}
