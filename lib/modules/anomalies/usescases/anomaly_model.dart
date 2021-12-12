import 'package:intl/intl.dart';

class AnomalyList{
  List<Anomaly>? anomalyList = [];
  AnomalyList({this.anomalyList});
  AnomalyList.fromJsonDbList(List<dynamic> jsonList) {
    for (var item in jsonList) {
      final anomaly = Anomaly.fromDBMap(item);
      anomalyList!.add(anomaly);
    }
  }
}
class Anomaly {
  int? id;
  int status = 0;
  int isBradyCardia = 0;
  int isTachyCardia = 0;
  String? createAt;

  Anomaly(
      {required this.status,
      required this.isBradyCardia,
      required this.isTachyCardia,
      this.createAt,
      this.id});

  factory Anomaly.fromDBMap(Map<String, dynamic> json) => Anomaly(
      status: json['status'],
      isBradyCardia: json['is_bradycardia'],
      isTachyCardia: json['is_tachycardia'],
      createAt: json['create_at'],
      id: json['id']);

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['status'] = this.status;
    map['is_bradycardia'] = this.isBradyCardia;
    map['is_tachycardia'] = this.isTachyCardia;
    map['create_at'] = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return map;
  }
  @override
  String toString() {
    return "Anomalia ${this.createAt}";
  }
}

class AnomalyDetail {
  int? anomalyId;
  // preguntas de BradyCardia
  int? tieneMarcaPasos = 0;
  int? hormonaTirodeaBaja = 0;
  int? tieneFatiga = 0;
  int? tieneMareoOAturdimiento = 0;
  int? tuvoDesmayos = 0;

  // Preguntas de TachyCardia Sinusual
  int? tieneAnsiedad = 0;
  int? tuvoAngustia = 0;
  // Preguntas de TachyCardia Ouricular o Supraventicular
  int? bebeCafeina = 0;
  int? bebeAlcohol = 0;
  int? fuma = 0;
  int? dolorPecho = 0;
  int? dificultadRespirar = 0;
  int? haceEjercicio = 0;

  String? createAt;
  AnomalyDetail(
      {this.anomalyId,
       this.tieneMarcaPasos,
       this.hormonaTirodeaBaja,
       this.tieneFatiga,
       this.tieneMareoOAturdimiento,
       this.tuvoDesmayos,
       this.tieneAnsiedad,
       this.tuvoAngustia,
       this.bebeCafeina,
       this.bebeAlcohol,
       this.fuma,
       this.dolorPecho,
       this.dificultadRespirar,
       this.haceEjercicio,
      this.createAt});
  factory AnomalyDetail.fromDBMap(Map<String, dynamic> json) => AnomalyDetail(
        tieneMarcaPasos: json['tiene_marcapaso'],
        hormonaTirodeaBaja: json['hormona_tirodea'],
        tieneFatiga: json['tiene_fatiga'],
        tieneMareoOAturdimiento: json['tiene_mareo'],
        tuvoDesmayos: json['tuvo_desmayo'],
        tieneAnsiedad: json['tiene_ansiedad'],
        tuvoAngustia: json['tuvo_angustia'],
        bebeCafeina: json['bebe_cafina'],
        bebeAlcohol: json['bebe_alcohol'],
        fuma: json['fuma'],
        dolorPecho: json['dolor_pecho'],
        dificultadRespirar: json['dificultad_respirar'],
        haceEjercicio: json['hace_ejericio'],
        createAt: json['create_at'],
        anomalyId: json['anomalyid'],
      );

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['tiene_marcapaso'] = this.tieneMarcaPasos;
    map['hormona_tirodea'] = this.hormonaTirodeaBaja;
    map['tiene_fatiga'] = this.tieneFatiga;
    map['tiene_mareo'] = this.tieneMareoOAturdimiento;
    map['tuvo_desmayo'] = this.tuvoDesmayos;
    map['tiene_ansiedad'] = this.tieneAnsiedad;
    map['tuvo_angustia'] = this.tuvoAngustia;
    map['bebe_cafina'] = this.bebeCafeina;
    map['bebe_alcohol'] = this.bebeAlcohol;
    map['fuma'] = this.fuma;
    map['dolor_pecho'] = this.dolorPecho;
    map['dificultad_respirar'] = this.dificultadRespirar;
    map['hace_ejericio'] = this.haceEjercicio;
    map['create_at'] = DateFormat('yyyy-MM-dd').format(DateTime.now());
    map['anomalyid'] = this.anomalyId;
    return map;
  }
}
