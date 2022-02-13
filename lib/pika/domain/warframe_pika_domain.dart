import 'dart:async';
import 'dart:convert';

import 'package:alwan/pika/pika_domain.dart';
import 'package:alwan/pika/pika_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WarframePikaDomain extends PikaDomain {
  PikaEntry? _root;

  static const String _storageKey = 'WarframePikaManager.domain';

  @override
  PikaEntry get root => _root!;

  @override
  bool get isLoaded => _root != null;

  @override
  Future<bool> save() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final String json = jsonEncode(root);
    return await storage.setString(_storageKey, json);
  }

  @override
  Future<bool> load() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final String? json = storage.getString(_storageKey);
    _root = json == null ? _def : PikaEntry.fromJson(jsonDecode(json));
    return true;
  }

  //#region Definition
  static final PikaEntry _def = PikaEntry('Warframe', children: [
    _defProjectOwnAllEquipment,
  ]);

  static final PikaEntry _defProjectOwnAllEquipment = PikaEntry(
    'Own All Equipment',
    children: [
      PikaEntry('Warframes', children: [
        PikaEntry('Ash'),
        PikaEntry('Ash Prime'),
        PikaEntry('Atlas'),
        PikaEntry('Atlas Prime'),
        PikaEntry('Banshee'),
        PikaEntry('Banshee Prime'),
        PikaEntry('Baruuk'),
        PikaEntry('Caliban'),
        PikaEntry('Chroma'),
        PikaEntry('Chroma Prime'),
        PikaEntry('Ember'),
        PikaEntry('Ember Prime'),
        PikaEntry('Equinox'),
        PikaEntry('Equinox Prime'),
        PikaEntry('Excalibur'),
        // PikaEntry('Excalibur Prime'),
        PikaEntry('Excalibur Umbra'),
        PikaEntry('Frost'),
        PikaEntry('Frost Prime'),
        PikaEntry('Gara'),
        PikaEntry('Gara Prime'),
        PikaEntry('Garuda'),
        PikaEntry('Gauss'),
        PikaEntry('Grendel'),
        PikaEntry('Harrow'),
        PikaEntry('Harrow Prime'),
        PikaEntry('Hildryn'),
        PikaEntry('Hydroid'),
        PikaEntry('Hydroid Prime'),
        PikaEntry('Inaros'),
        PikaEntry('Inaros Prime'),
        PikaEntry('Ivara'),
        PikaEntry('Ivara Prime'),
        PikaEntry('Khora'),
        PikaEntry('Lavos'),
        PikaEntry('Limbo'),
        PikaEntry('Limbo Prime'),
        PikaEntry('Loki'),
        PikaEntry('Loki Prime'),
        PikaEntry('Mag'),
        PikaEntry('Mag Prime'),
        PikaEntry('Mesa'),
        PikaEntry('Mesa Prime'),
        PikaEntry('Mirage'),
        PikaEntry('Mirage Prime'),
        PikaEntry('Nekros'),
        PikaEntry('Nekros Prime'),
        PikaEntry('Nezha'),
        PikaEntry('Nezha Prime'),
        PikaEntry('Nidus'),
        PikaEntry('Nidus Prime'),
        PikaEntry('Nova'),
        PikaEntry('Nova Prime'),
        PikaEntry('Nyx'),
        PikaEntry('Nyx Prime'),
        PikaEntry('Oberon'),
        PikaEntry('Oberon Prime'),
        PikaEntry('Octavia'),
        PikaEntry('Octavia Prime'),
        PikaEntry('Protea'),
        PikaEntry('Revenant'),
        PikaEntry('Rhino'),
        PikaEntry('Rhino Prime'),
        PikaEntry('Saryn'),
        PikaEntry('Saryn Prime'),
        PikaEntry('Sevagoth'),
        PikaEntry('Titania'),
        PikaEntry('TitaniaPrime'),
        PikaEntry('Trinity'),
        PikaEntry('Trinity Prime'),
        PikaEntry('Valkyr'),
        PikaEntry('Valkyr Prime'),
        PikaEntry('Vauban'),
        PikaEntry('Vauban Prime'),
        PikaEntry('Volt'),
        PikaEntry('Volt Prime'),
        PikaEntry('Wisp'),
        PikaEntry('Wukong'),
        PikaEntry('Wukong Prime'),
        PikaEntry('Xaku'),
        PikaEntry('Yareli'),
        PikaEntry('Zephyr'),
        PikaEntry('Zephyr Prime'),
      ]),
      PikaEntry('Primary Weapon', children: [
        PikaEntry('Acceltra'),
        PikaEntry('Ambassador'),
        PikaEntry('Amprex'),
        PikaEntry('Arca Plasmor'),
        PikaEntry('Argonak'),
        PikaEntry('Astilla Prime'),
        PikaEntry('Astilla'),
        PikaEntry('Attica'),
        PikaEntry('Basmu'),
        PikaEntry('Battacor'),
        PikaEntry('Baza Prime'),
        PikaEntry('Baza'),
        PikaEntry('Boar Prime'),
        PikaEntry('Boar'),
        PikaEntry('Boltor Prime'),
        PikaEntry('Boltor'),
        PikaEntry('Braton Prime'),
        PikaEntry('Braton Vandal'),
        PikaEntry('Braton'),
        PikaEntry('Bubonico'),
        PikaEntry('Burston Prime'),
        PikaEntry('Burston'),
        PikaEntry('Buzlok'),
        PikaEntry('Carmine Penta'),
        PikaEntry('Cedo'),
        PikaEntry('Cernos Prime'),
        PikaEntry('Cernos'),
        PikaEntry('Convectrix'),
        PikaEntry('Corinth Prime'),
        PikaEntry('Corinth'),
        PikaEntry('Daikyu'),
        PikaEntry('Dera Vandal'),
        PikaEntry('Dera'),
        PikaEntry('Dex Sybaris'),
        PikaEntry('Drakgoon'),
        PikaEntry('Dread'),
        PikaEntry('Exergis'),
        PikaEntry('Ferrox'),
        PikaEntry('Flux Rifle'),
        PikaEntry('Fulmin'),
        PikaEntry('Glaxion Vandal'),
        PikaEntry('Glaxion'),
        PikaEntry('Gorgon Wraith'),
        PikaEntry('Gorgon'),
        PikaEntry('Grakata'),
        PikaEntry('Grinlok'),
        PikaEntry('Harpak'),
        PikaEntry('Hek'),
        PikaEntry('Hema'),
        PikaEntry('Hind'),
        PikaEntry('Ignis Wraith'),
        PikaEntry('Ignis'),
        PikaEntry('Javlok'),
        PikaEntry('Karak Wraith'),
        PikaEntry('Karak'),
        PikaEntry('Kohm'),
        PikaEntry('Komorex'),
        PikaEntry('Kuva Bramma'),
        PikaEntry('Kuva Chakkhurr'),
        PikaEntry('Kuva Drakgoon'),
        PikaEntry('Kuva Hek'),
        PikaEntry('Kuva Hind'),
        PikaEntry('Kuva Karak'),
        PikaEntry('Kuva Kohm'),
        PikaEntry('Kuva Ogris'),
        PikaEntry('Kuva Quartakk'),
        PikaEntry('Kuva Tonkor'),
        PikaEntry('Kuva Zarr'),
        PikaEntry('Lanka'),
        PikaEntry('Latron Prime'),
        PikaEntry('Latron Wraith'),
        PikaEntry('Latron'),
        PikaEntry('Lenz'),
        PikaEntry('Miter'),
        PikaEntry('MK1-Braton'),
        PikaEntry('MK1-Paris'),
        PikaEntry('MK1-Strun'),
        PikaEntry('Mutalist Cernos'),
        PikaEntry('Mutalist Quanta'),
        PikaEntry('Nagantaka'),
        PikaEntry('Nataruk'),
        PikaEntry('Ogris'),
        PikaEntry('Opticor Vandal'),
        PikaEntry('Opticor'),
        PikaEntry('Panthera Prime'),
        PikaEntry('Panthera'),
        PikaEntry('Paracyst'),
        PikaEntry('Paris Prime'),
        PikaEntry('Paris'),
        PikaEntry('Penta'),
        PikaEntry('Phage'),
        PikaEntry('Phantasma'),
        PikaEntry('Prisma Gorgon'),
        PikaEntry('Prisma Grakata'),
        PikaEntry('Prisma Grinlok'),
        PikaEntry('Prisma Tetra'),
        PikaEntry('Proboscis Cernos'),
        PikaEntry('Quanta Vandal'),
        PikaEntry('Quanta'),
        PikaEntry('Quartakk'),
        PikaEntry('Quellor'),
        PikaEntry('Rakta Cernos'),
        PikaEntry('Rubico Prime'),
        PikaEntry('Rubico'),
        PikaEntry('Sancti Tigris'),
        PikaEntry('Scourge Prime'),
        PikaEntry('Scourge'),
        PikaEntry('Secura Penta'),
        PikaEntry('Shedu'),
        PikaEntry('Simulor'),
        PikaEntry('Snipetron Vandal'),
        PikaEntry('Snipetron'),
        PikaEntry('Sobek'),
        PikaEntry('Soma Prime'),
        PikaEntry('Soma'),
        PikaEntry('Sporothrix'),
        PikaEntry('Stahlta'),
        PikaEntry('Stradavar Prime'),
        PikaEntry('Stradavar'),
        PikaEntry('Strun Prime'),
        PikaEntry('Strun Wraith'),
        PikaEntry('Strun'),
        PikaEntry('Supra Vandal'),
        PikaEntry('Supra'),
        PikaEntry('Sybaris Prime'),
        PikaEntry('Sybaris'),
        PikaEntry('Sybaris'),
        PikaEntry('Synapse'),
        PikaEntry('Synoid Simulor'),
        PikaEntry('Telos Boltor'),
        PikaEntry('Tenet Arca Plasmor'),
        PikaEntry('Tenet Envoy'),
        PikaEntry('Tenet Flux Rifle'),
        PikaEntry('Tenet Tetra'),
        PikaEntry('Tenora Prime'),
        PikaEntry('Tenora'),
        PikaEntry('Tetra'),
        PikaEntry('Tiberon Prime'),
        PikaEntry('Tiberon'),
        PikaEntry('Tigris Prime'),
        PikaEntry('Tigris'),
        PikaEntry('Tonkor'),
        PikaEntry('Torid'),
        PikaEntry('Trumna'),
        PikaEntry('Vaykor Hek'),
        PikaEntry('Vectis Prime'),
        PikaEntry('Vectis'),
        PikaEntry('Veldt'),
        PikaEntry('Vulkar Wraith'),
        PikaEntry('Vulkar'),
        PikaEntry('Zarr'),
        PikaEntry('Zenith'),
        PikaEntry('Zhuge Prime'),
        PikaEntry('Zhuge'),
      ]),
      PikaEntry('Secondary Weapons', children: [
        PikaEntry('Acrid'),
        PikaEntry('Afuris'),
        PikaEntry('Akarius'),
        PikaEntry('Akbolto'),
        PikaEntry('Akbolto Prime'),
        PikaEntry('Akbronco'),
        PikaEntry('Akbronco Prime'),
        PikaEntry('Akjagara'),
        PikaEntry('Akjagara Prime'),
        PikaEntry('Aklato'),
        PikaEntry('Aklex'),
        PikaEntry('Aklex Prime'),
        PikaEntry('Akmagnus'),
        PikaEntry('Aksomati'),
        PikaEntry('Aksomati Prime'),
        PikaEntry('Akstiletto'),
        PikaEntry('Akstiletto Prime'),
        PikaEntry('Akvasto'),
        PikaEntry('Akvasto Prime'),
        PikaEntry('Akzani'),
        PikaEntry('Angstrum'),
        PikaEntry('Arca Scisco'),
        PikaEntry('Athodai'),
        PikaEntry('Atomos'),
        PikaEntry('Azima'),
        PikaEntry('Ballistica'),
        PikaEntry('Ballistica Prime'),
        PikaEntry('Bolto'),
        PikaEntry('Brakk'),
        PikaEntry('Bronco'),
        PikaEntry('Bronco Prime'),
        PikaEntry('Castanas'),
        PikaEntry('Catabolyst'),
        PikaEntry('Cestra'),
        PikaEntry('Cyanex'),
        PikaEntry('Cycron'),
        PikaEntry('Despair'),
        PikaEntry('Detron'),
        PikaEntry('Dex Furis'),
        PikaEntry('Dual Cestra'),
        PikaEntry('Dual Toxocyst'),
        PikaEntry('Embolist'),
        PikaEntry('Epitaph'),
        PikaEntry('Euphona Prime'),
        PikaEntry('Furis'),
        PikaEntry('Fusilai'),
        PikaEntry('Gammacor'),
        PikaEntry('Hikou'),
        PikaEntry('Hikou Prime'),
        PikaEntry('Hystrix'),
        PikaEntry('Knell'),
        PikaEntry('Knell Prime'),
        PikaEntry('Kohmak'),
        PikaEntry('Kompressa'),
        PikaEntry('Kraken'),
        PikaEntry('Kulstar'),
        PikaEntry('Kunai'),
        PikaEntry('Kuva Brakk'),
        PikaEntry('Kuva Kraken'),
        PikaEntry('Kuva Nukor'),
        PikaEntry('Kuva Seer'),
        PikaEntry('Kuva Twin Stubbas'),
        PikaEntry('Lato'),
        // PikaEntry('Lato Prime'),
        PikaEntry('Lato Vandal'),
        PikaEntry('Lex'),
        PikaEntry('Lex Prime'),
        PikaEntry('Magnus'),
        PikaEntry('Magnus Prime'),
        PikaEntry('Mara Detron'),
        PikaEntry('Marelok'),
        PikaEntry('MK1-Furis'),
        PikaEntry('MK1-Kunai'),
        PikaEntry('Nukor'),
        PikaEntry('Ocucor'),
        PikaEntry('Pandero'),
        PikaEntry('Pandero Prime'),
        PikaEntry('Plinx'),
        PikaEntry('Pox'),
        PikaEntry('Prisma Angstrum'),
        PikaEntry('Prisma Twin Gremlins'),
        PikaEntry('Pyrana'),
        PikaEntry('Pyrana Prime'),
        PikaEntry('Quatz'),
        PikaEntry('Rakta Ballistica'),
        PikaEntry('Sancti Castanas'),
        PikaEntry('Secura Dual Cestra'),
        PikaEntry('Seer'),
        PikaEntry('Sepulcrum'),
        PikaEntry('Sicarus'),
        PikaEntry('Sicarus Prime'),
        PikaEntry('Sonicor'),
        PikaEntry('Spectra'),
        PikaEntry('Spectra Vandal'),
        PikaEntry('Spira'),
        PikaEntry('Spira Prime'),
        PikaEntry('Staticor'),
        PikaEntry('Stubba'),
        PikaEntry('Stug'),
        PikaEntry('Synoid Gammacor'),
        PikaEntry('Talons'),
        PikaEntry('Telos Akbolto'),
        PikaEntry('Tenet Cycron'),
        PikaEntry('Tenet Detron'),
        PikaEntry('Tenet Diplos'),
        PikaEntry('Tenet Spirex'),
        PikaEntry('Twin Grakatas'),
        PikaEntry('Twin Gremlins  Viper,'),
        PikaEntry('Twin Kohmak'),
        PikaEntry('Twin Rogga'),
        PikaEntry('Twin Vipers'),
        PikaEntry('Twin Vipers Wraith'),
        PikaEntry('Tysis'),
        PikaEntry('Vasto'),
        PikaEntry('Vasto Prime'),
        PikaEntry('Vaykor Marelok'),
        PikaEntry('Velox'),
        PikaEntry('Viper'),
        PikaEntry('Viper Wraith'),
        PikaEntry('Zakti'),
        PikaEntry('Zakti Prime'),
        PikaEntry('Zylok'),
        PikaEntry('Zymos'),
      ]),
      PikaEntry('Melee Weapons', children: [
        PikaEntry('Bo'),
        PikaEntry('Ghoulsaw'),
        PikaEntry('Ack & Brunt'),
        PikaEntry('Amphis'),
        PikaEntry('Anku'),
        PikaEntry('Ankyros'),
        PikaEntry('Ankyros Prime'),
        PikaEntry('Arca Titron'),
        PikaEntry('Arum Spinosa'),
        PikaEntry('Atterax'),
        PikaEntry('Bo'),
        PikaEntry('Bo Prime'),
        PikaEntry('Boltace'),
        PikaEntry('Broken Scepter'),
        PikaEntry('Broken War'),
        PikaEntry('Cadus'),
        PikaEntry('Cassowar'),
        PikaEntry('Caustacyst'),
        PikaEntry('Ceramic Dagger'),
        PikaEntry('Cerata'),
        PikaEntry('Ceti Lacera'),
        PikaEntry('Cobra & Crane'),
        PikaEntry('Cronus'),
        PikaEntry('Dakra Prime'),
        PikaEntry('Dark Dagger'),
        PikaEntry('Dark Split-Sword (Dual Swords)'),
        PikaEntry('Dark Split-Sword (Heavy Blade)'),
        PikaEntry('Dark Sword'),
        PikaEntry('Destreza'),
        PikaEntry('Destreza Prime'),
        PikaEntry('Dex Dakra'),
        PikaEntry('Dragon Nikana'),
        PikaEntry('Dual Cleavers'),
        PikaEntry('Dual Ether'),
        PikaEntry('Dual Heat Swords'),
        PikaEntry('Dual Ichor'),
        PikaEntry('Dual Kamas'),
        PikaEntry('Dual Kamas Prime'),
        PikaEntry('Dual Keres'),
        PikaEntry('Dual Raza'),
        PikaEntry('Dual Skana'),
        PikaEntry('Dual Zoren'),
        PikaEntry('Endura'),
        PikaEntry('Ether Daggers'),
        PikaEntry('Ether Reaper'),
        PikaEntry('Ether Sword'),
        PikaEntry('Falcor'),
        PikaEntry('Fang'),
        PikaEntry('Fang Prime'),
        PikaEntry('Fragor'),
        PikaEntry('Fragor Prime'),
        PikaEntry('Furax'),
        PikaEntry('Furax Wraith'),
        PikaEntry('Galatine'),
        PikaEntry('Galatine Prime'),
        PikaEntry('Galvacord'),
        PikaEntry('Gazal Machete'),
        PikaEntry('Glaive'),
        PikaEntry('Glaive Prime'),
        PikaEntry('Gram'),
        PikaEntry('Gram Prime'),
        PikaEntry('Guandao'),
        PikaEntry('Guandao Prime'),
        PikaEntry('Gunsen'),
        PikaEntry('Halikar'),
        PikaEntry('Halikar Wraith'),
        PikaEntry('Hate'),
        PikaEntry('Heat Dagger'),
        PikaEntry('Heat Sword'),
        PikaEntry('Heliocor'),
        PikaEntry('Hirudo'),
        PikaEntry('Jat Kittag'),
        PikaEntry('Jat Kusar'),
        PikaEntry('Jaw Sword'),
        PikaEntry('Kama'),
        PikaEntry('Karyst'),
        PikaEntry('Karyst Prime'),
        PikaEntry('Keratinos'),
        PikaEntry('Kesheg'),
        PikaEntry('Kestrel'),
        PikaEntry('Kogake'),
        PikaEntry('Kogake Prime'),
        PikaEntry('Korrudo'),
        PikaEntry('Korumm'),
        PikaEntry('Kreska'),
        PikaEntry('Krohkur'),
        PikaEntry('Kronen'),
        PikaEntry('Kronen Prime'),
        PikaEntry('Kuva Shildeg'),
        PikaEntry('Lacera'),
        PikaEntry('Lecta'),
        PikaEntry('Lesion'),
        PikaEntry('Machete'),
        PikaEntry('Machete Wraith'),
        PikaEntry('Magistar'),
        PikaEntry('Masseter'),
        PikaEntry('Mios'),
        PikaEntry('Mire'),
        PikaEntry('MK1-Bo'),
        PikaEntry('MK1-Furax'),
        PikaEntry('Nami Skyla'),
        PikaEntry('Nami Skyla Prime'),
        PikaEntry('Nami Solo'),
        PikaEntry('Nepheri'),
        PikaEntry('Nikana'),
        PikaEntry('Nikana Prime'),
        PikaEntry('Ninkondi'),
        PikaEntry('Ninkondi Prime'),
        PikaEntry('Obex'),
        PikaEntry('Ohma'),
        PikaEntry('Okina'),
        PikaEntry('Orthos'),
        PikaEntry('Orthos Prime'),
        PikaEntry('Orvius'),
        PikaEntry('Pangolin Prime'),
        PikaEntry('Pangolin Sword'),
        PikaEntry('Paracesis'),
        PikaEntry('Pathocyst'),
        PikaEntry('Pennant'),
        PikaEntry('Plasma Sword'),
        PikaEntry('Prisma Dual Cleavers'),
        PikaEntry('Prisma Machete'),
        PikaEntry('Prisma Obex'),
        PikaEntry('Prisma Skana'),
        PikaEntry('Prova'),
        PikaEntry('Prova Vandal'),
        PikaEntry('Pulmonars'),
        PikaEntry('Pupacyst'),
        PikaEntry('Quassus'),
        PikaEntry('Rakta Dark Dagger'),
        PikaEntry('Reaper Prime'),
        PikaEntry('Redeemer'),
        PikaEntry('Redeemer Prime'),
        PikaEntry('Ripkas'),
        PikaEntry('Rumblejack'),
        PikaEntry('Sancti Magistar'),
        PikaEntry('Sarpa'),
        PikaEntry('Scindo'),
        PikaEntry('Scindo Prime'),
        PikaEntry('Scoliac'),
        PikaEntry('Secura Lecta'),
        PikaEntry('Serro'),
        PikaEntry('Shaku'),
        PikaEntry('Sheev'),
        PikaEntry('Sibear'),
        PikaEntry('Sigma & Octantis'),
        PikaEntry('Silva & Aegis'),
        PikaEntry('Silva & Aegis Prime'),
        PikaEntry('Skana'),
        // PikaEntry('Skana Prime'),
        PikaEntry('Skiajati'),
        PikaEntry('Stropha'),
        PikaEntry('Sydon'),
        PikaEntry('Synoid Heliocor'),
        PikaEntry('Tatsu'),
        PikaEntry('Tekko'),
        PikaEntry('Tekko Prime'),
        PikaEntry('Telos Boltace'),
        PikaEntry('Tenet Agendus'),
        PikaEntry('Tenet Exec'),
        PikaEntry('Tenet Grigori'),
        PikaEntry('Tenet Livia'),
        PikaEntry('Tipedo'),
        PikaEntry('Tipedo Prime'),
        PikaEntry('Tonbo'),
        PikaEntry('Twin Basolk'),
        PikaEntry('Twin Krohkur'),
        PikaEntry('Vastilok'),
        PikaEntry('Vaykor Sydon'),
        PikaEntry('Venato'),
        PikaEntry('Venka'),
        PikaEntry('Venka Prime'),
        PikaEntry('Verdilac'),
        PikaEntry('Vitrica'),
        PikaEntry('Volnus'),
        PikaEntry('Volnus Prime'),
        PikaEntry('War'),
        PikaEntry('Wolf Sledge'),
        PikaEntry('Xoris'),
        PikaEntry('Zenistar'),
      ]),
      PikaEntry('Arch Guns', children: [
        PikaEntry('Dual Decurion'),
        PikaEntry('Imperator'),
        PikaEntry('Kuva Ayanga'),
        PikaEntry('Kuva Grattler'),
        PikaEntry('Prisma Dual Decurions'),
        PikaEntry('Mausolon'),
        PikaEntry('Cyngas'),
        PikaEntry('Morgha'),
        PikaEntry('Grattler'),
        PikaEntry('Imperator Vandal'),
        PikaEntry('Phaedra'),
        PikaEntry('Corvas'),
        PikaEntry('Velocitus'),
        PikaEntry('Cortege'),
        PikaEntry('Larkspur'),
        PikaEntry('Fluctus'),
      ]),
      PikaEntry('Arch Melee', children: [
        PikaEntry('Agkuza'),
        PikaEntry('Centaur'),
        PikaEntry('Kaszas'),
        PikaEntry('Knux'),
        PikaEntry('Onorix'),
        PikaEntry('Prisma Veritux'),
        PikaEntry('Rathbone'),
        PikaEntry('Veritux'),
      ]),
      PikaEntry('Kitguns', children: [
        PikaEntry('Rattleguts'),
        PikaEntry('Gaze'),
        PikaEntry('Vermisplicer'),
        PikaEntry('Catchmoon'),
        PikaEntry('Sporelacer'),
        PikaEntry('Tombfinger'),
      ]),
      PikaEntry('Zaws', children: [
        PikaEntry('Balla'),
        PikaEntry('Rabvee'),
        PikaEntry('Cyath'),
        PikaEntry('Kronsh'),
        PikaEntry('Sepfahn'),
        PikaEntry('Dehtat'),
        PikaEntry('Plague Kripath'),
        PikaEntry('Dokrahm'),
        PikaEntry('Plague Keewar'),
        PikaEntry('Mewan'),
        PikaEntry('Ooltha'),
      ]),
      PikaEntry('Companions', children: [
        PikaEntry('Sentinels', children: [
          PikaEntry('Carrier'),
          PikaEntry('Carrier Prime'),
          PikaEntry('Dethcube'),
          PikaEntry('Dethcube Prime'),
          PikaEntry('Diriga'),
          PikaEntry('Djinn'),
          PikaEntry('Helios'),
          PikaEntry('Helios Prime'),
          PikaEntry('Nautilus'),
          PikaEntry('Oxylus'),
          PikaEntry('Shade'),
          PikaEntry('Shade Prisma'),
          PikaEntry('Taxon'),
          PikaEntry('Wyrm'),
          PikaEntry('Wyrm Prime'),
        ]),
        PikaEntry('MOAs', children: [
          PikaEntry('Lambeo'),
          PikaEntry('Oloro'),
          PikaEntry('Para'),
          PikaEntry('Nychus'),
        ]),
        PikaEntry('Hounds', children: [
          PikaEntry('Bhaira'),
          PikaEntry('Dorma'),
          PikaEntry('Hec'),
        ]),
        PikaEntry('Kubrow', children: [
          PikaEntry('Chesa'),
          PikaEntry('Helminth Charger '),
          PikaEntry('Huras'),
          PikaEntry('Raksa'),
          PikaEntry('Sahasa'),
          PikaEntry('Sunika'),
          PikaEntry('Vizier Predasite '),
          PikaEntry('Pharaoh Predasite '),
          PikaEntry('Medjay Predasite'),
        ]),
        PikaEntry('Kavat', children: [
          PikaEntry('Adarza '),
          PikaEntry('Smeeta '),
          PikaEntry('Vasca '),
          PikaEntry('Sly Vulpaphyla '),
          PikaEntry('Crescent Vulpaphyla '),
          PikaEntry('Panzer Vulpaphyla'),
        ]),
      ]),
      PikaEntry('Robotic Weapons', children: [
        PikaEntry('Deconstructor'),
        PikaEntry('Deconstructor Prime'),
        PikaEntry('Akaten'),
        PikaEntry('Batoten'),
        PikaEntry('Lacerten'),
        PikaEntry('Burst Laser'),
        PikaEntry('Prisma Burst Laser'),
        PikaEntry('Laser Rifle'),
        PikaEntry('Multron'),
        PikaEntry('Prime Laser Rifle'),
        PikaEntry('Tazicor'),
        PikaEntry('Deth Machine Rifle'),
        PikaEntry('Deth Machine Rifle Prime'),
        PikaEntry('Helstrum'),
        PikaEntry('Vulcax'),
        PikaEntry('Artax'),
        PikaEntry('Cryotra'),
        PikaEntry('Verglas'),
        PikaEntry('Stinger'),
        PikaEntry('Sweeper'),
        PikaEntry('Sweeper Prime'),
        PikaEntry('Vulklok'),
      ]),
      PikaEntry('Archwing', children: [
        PikaEntry('Amesha'),
        PikaEntry('Elytron'),
        PikaEntry('Itzal'),
        PikaEntry('Odonata'),
        PikaEntry('Odonata Prime'),
      ]),
    ],
  );
//#endregion
}
