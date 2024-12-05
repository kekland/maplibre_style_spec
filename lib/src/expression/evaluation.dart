import 'package:maplibre_style_spec/src/expression/expression.dart';
import 'package:maplibre_style_spec/src/types/locale.dart';

class EvaluationContext {
  EvaluationContext({
    this.id,
    required this.geometryType,
    required this.zoom,
    required this.scaledTileSizePixels,
    required this.locale,
    this.lineProgress,
    Map<String, Expression>? bindings,
    Map<String, dynamic>? properties,
    Map<String, dynamic>? featureState,
  })  : _bindings = bindings ?? {},
        _properties = properties ?? {},
        _featureState = featureState ?? {};

  static EvaluationContext empty() {
    return EvaluationContext(
      geometryType: 'Point',
      locale: Locale(languageCode: 'en'),
      zoom: 0,
      scaledTileSizePixels: 512,
    );
  }

  final String? id;
  final String geometryType;
  final double? lineProgress;
  final double zoom;
  final double scaledTileSizePixels;
  final Locale locale;
  final Map<String, Expression> _bindings;
  final Map<String, dynamic> _properties;
  final Map<String, dynamic> _featureState;

  Map<String, dynamic> get properties => _properties;

  EvaluationContext extendWith({
    Map<String, Expression>? bindings,
    Map<String, dynamic>? properties,
    Map<String, dynamic>? featureState,
  }) {
    return EvaluationContext(
      id: id,
      geometryType: geometryType,
      lineProgress: lineProgress,
      locale: locale,
      zoom: zoom,
      scaledTileSizePixels: scaledTileSizePixels,
      bindings: {..._bindings, ...?bindings},
      properties: {..._properties, ...?properties},
      featureState: {..._featureState, ...?featureState},
    );
  }

  EvaluationContext copyWith({
    String? id,
    String? geometryType,
    double? lineProgress,
    double? zoom,
    double? scaledTileSizePixels,
    Locale? locale,
    Map<String, Expression>? bindings,
    Map<String, dynamic>? properties,
    Map<String, dynamic>? featureState,
  }) {
    return EvaluationContext(
      id: id ?? this.id,
      geometryType: geometryType ?? this.geometryType,
      lineProgress: lineProgress ?? this.lineProgress,
      locale: locale ?? this.locale,
      zoom: zoom ?? this.zoom,
      scaledTileSizePixels: scaledTileSizePixels ?? this.scaledTileSizePixels,
      bindings: bindings ?? _bindings,
      properties: properties ?? _properties,
      featureState: featureState ?? _featureState,
    );
  }

  Expression? getBinding(String name) {
    return _bindings[name];
  }

  dynamic getProperty(String name) {
    return _properties[name];
  }

  dynamic getFeatureState(String name) {
    return _featureState[name];
  }

  bool hasProperty(String name) {
    return _properties.containsKey(name);
  }
}
