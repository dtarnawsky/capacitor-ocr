export interface CapacitorOcrPlugin {
  /**
   * Detect text in an image
   * @param options Options for text detection
   */
  detectText(options: DetectTextOptions): Promise<TextDetections>;
}

export interface DetectTextOptions {
  filename: string;
  orientation?: ImageOrientation;
}

export interface TextDetections {
  textDetections: TextDetection[];
}

export interface TextDetection {
  bottomLeft: [number, number]; // [x-coordinate, y-coordinate]
  bottomRight: [number, number]; // [x-coordinate, y-coordinate]
  topLeft: [number, number]; // [x-coordinate, y-coordinate]
  topRight: [number, number]; // [x-coordinate, y-coordinate]
  text: string;
}

export enum ImageOrientation {
  Up = 'UP',
  Down = 'DOWN',
  Left = 'LEFT',
  Right = 'RIGHT',
}
