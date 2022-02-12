class PikaEntry {
  PikaEntry(this.title, {this.children = const []});

  String title;
  List<PikaEntry> children;

  bool state = false;
}
