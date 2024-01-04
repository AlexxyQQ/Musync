import 'dart:io' as io;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/config/constants/colors/primitive_colors.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:flutter/material.dart';

Future<List<Color>> extractAlbumArtColor(String path) async {
  try {
    final Uint8List fileData = await io.File(path).readAsBytes();
    final ui.Codec codec = await ui.instantiateImageCodec(fileData);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();

    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImage(frameInfo.image);

    final bool text =
        paletteGenerator.dominantColor!.color.computeLuminance() > 0.5;

    return [
      paletteGenerator.dominantColor?.color ?? PrimitiveColors.grey900,

      // If dominant color is dark, use light text color
      text ? AppLightColor.onSurface : AppDarkColor.onSurface,
    ]; // Default color
  } catch (e) {
    return [
      PrimitiveColors.grey900,
      AppLightColor.onSurface,
    ]; // Return a default color in case of an error
  }
}
