import 'package:alwan/pika/pika_entry.dart';

abstract class PikaDomain {
  /// Returns the root [PikaEntry] for the domain.
  ///
  /// It is not safe to call this if [isLoaded] is false.
  PikaEntry get root;

  bool get isLoaded;

  /// Saves [root] in local storage.
  ///
  /// This is used to store the progress for each PikaEntry.
  /// Returns [bool] whether the save was successful or not.
  Future<bool> save();

  Future<bool> load();
}
