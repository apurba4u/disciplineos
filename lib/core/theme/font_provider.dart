import 'package:flutter_riverpod/flutter_riverpod.dart';

enum FontFamily {
  inter,
  poppins,
  roboto,
  manrope,
  outfit,
  nunito,
  montserrat,
  openSans;

  String get label {
    switch (this) {
      case FontFamily.inter:
        return 'Inter';
      case FontFamily.poppins:
        return 'Poppins';
      case FontFamily.roboto:
        return 'Roboto';
      case FontFamily.manrope:
        return 'Manrope';
      case FontFamily.outfit:
        return 'Outfit';
      case FontFamily.nunito:
        return 'Nunito';
      case FontFamily.montserrat:
        return 'Montserrat';
      case FontFamily.openSans:
        return 'Open Sans';
    }
  }

  String get fontFamily {
    switch (this) {
      case FontFamily.inter:
        return 'Inter';
      case FontFamily.poppins:
        return 'Poppins';
      case FontFamily.roboto:
        return 'Roboto';
      case FontFamily.manrope:
        return 'Manrope';
      case FontFamily.outfit:
        return 'Outfit';
      case FontFamily.nunito:
        return 'Nunito';
      case FontFamily.montserrat:
        return 'Montserrat';
      case FontFamily.openSans:
        return 'Open Sans';
    }
  }
}

class FontState {
  final FontFamily fontFamily;
  final double fontSizeScale;

  const FontState({
    this.fontFamily = FontFamily.inter,
    this.fontSizeScale = 1.0,
  });

  FontState copyWith({
    FontFamily? fontFamily,
    double? fontSizeScale,
  }) {
    return FontState(
      fontFamily: fontFamily ?? this.fontFamily,
      fontSizeScale: fontSizeScale ?? this.fontSizeScale,
    );
  }
}

class FontNotifier extends StateNotifier<FontState> {
  FontNotifier() : super(const FontState());

  void setFontFamily(FontFamily fontFamily) {
    state = state.copyWith(fontFamily: fontFamily);
  }

  void setFontSizeScale(double scale) {
    state = state.copyWith(fontSizeScale: scale);
  }
}

final fontProvider = StateNotifierProvider<FontNotifier, FontState>((ref) {
  return FontNotifier();
});
