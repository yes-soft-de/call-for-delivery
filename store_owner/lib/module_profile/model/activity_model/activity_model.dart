class ActivityModel {
  DateTime startDate;
  DateTime endDate;
  String activity;
  bool? isCreate;

  ActivityModel(
      {required this.startDate,
      required this.endDate,
      required this.activity,
       this.isCreate});
}
