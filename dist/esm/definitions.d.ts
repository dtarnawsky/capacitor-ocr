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
    bottomLeft: [number, number];
    bottomRight: [number, number];
    topLeft: [number, number];
    topRight: [number, number];
    text: string;
}
export declare enum ImageOrientation {
    Up = "UP",
    Down = "DOWN",
    Left = "LEFT",
    Right = "RIGHT"
}
