class PikaEntry {
  PikaEntry(this.title, {this.children = const []});

  String title;
  List<PikaEntry> children;

  bool state = false;

  PikaEntry.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        children = List<PikaEntry>.from(json["children"].map((x) => PikaEntry.fromJson(x))),
        state = json['state'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'children': children,
        'state': state,
      };
}
