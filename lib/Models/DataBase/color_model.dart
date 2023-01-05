///02:
//to store our color values we also need to create a table
//this 'colors' is the name of our table which we want to create
const String tableColors = 'colors';
//final String tableColors = 'colors'; (try)

///03:
//then we want to create all the fields
//therefore we have crate this class 'ColorFields'
//and inside we will define all of our fields name
//basically these are column names of our table
class ColorsFields {
  //02:
  static final List<String> values = [
    ///Add all fields
    id, red, green, blue, opacity, shadow, colorValue
  ];

  //01: this 'color' (on RHS are later will be our column name
  //by default in sqlflitedb we have '_' for id and remaining are simple name
  static const String id =
      '_id'; //static final String id = '_id'; (try for all)
  static const String red = 'red';
  static const String green = 'green';
  static const String blue = 'blue';
  static const String opacity = 'opacity';
  static const String shadow = 'shadow';
  static const String colorValue = 'colorValue';
}

///01:
class ColorModel {
  final int? id;
  final int? red;
  final int? green;
  final int? blue;
  final int? opacity;
  final int? shadow;
  final int? colorValue;

  ColorModel({
    this.id,
    required this.red,
    required this.green,
    required this.blue,
    required this.opacity,
    required this.shadow,
    required this.colorValue,
  });

  ColorModel copy({
    int? id,
    int? red,
    int? green,
    int? blue,
    int? opacity,
    int? shadow,
    int? colorValue,
  }) =>
      ColorModel(
        id: id ?? this.id,
        red: red ?? this.red,
        green: green ?? this.green,
        blue: blue ?? this.blue,
        opacity: opacity ?? this.opacity,
        shadow: shadow ?? this.shadow,
        colorValue: colorValue ?? this.colorValue,
      );

  static ColorModel fromJson(Map<String, Object?> json) => ColorModel(
        id: json[ColorsFields.id] as int?,
        red: json[ColorsFields.red] as int,
        green: json[ColorsFields.green] as int,
        blue: json[ColorsFields.blue] as int,
        opacity: json[ColorsFields.opacity] as int,
        shadow: json[ColorsFields.shadow] as int,
        colorValue: json[ColorsFields.colorValue] as int,
      );

  Map<String, Object?> toJson() => {
        ColorsFields.id: id,
        ColorsFields.red: red,
        ColorsFields.green: green,
        ColorsFields.blue: blue,
        ColorsFields.opacity: opacity,
        ColorsFields.shadow: shadow,
        ColorsFields.colorValue: colorValue,
      };
}
