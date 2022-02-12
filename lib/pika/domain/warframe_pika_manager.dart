import 'package:alwan/pika/pika_entry.dart';
import 'package:alwan/pika/pika_manager.dart';

class WarframePikaManager extends PikaManager {
  @override
  PikaEntry get domain => PikaEntry('Warframe', children: [
        PikaEntry(
          'Max MR',
          children: [
            PikaEntry(
              'Warframes',
              children: [
                PikaEntry('Ember'),
                PikaEntry('EmberPrime'),
                PikaEntry('Excalibre'),
              ],
            ),
            PikaEntry(
              'Melee Weapons',
              children: [
                PikaEntry('Bo'),
                PikaEntry('Bo Prime'),
              ],
            )
          ],
        ),
        PikaEntry(
          'Own All Equipment',
          children: [
            PikaEntry(
              'Warframes',
              children: [
                PikaEntry('Equinox'),
                PikaEntry('Equinox Prime'),
                PikaEntry('Excalibre Umbra'),
              ],
            ),
            PikaEntry(
              'Primary Weapons',
              children: [
                PikaEntry('Braton'),
                PikaEntry('Braton Prime'),
              ],
            )
          ],
        ),
      ]);
}
