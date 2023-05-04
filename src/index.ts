import { registerPlugin } from '@capacitor/core';

import type { CapacitorOcrPlugin } from './definitions';

const Ocr = registerPlugin<CapacitorOcrPlugin>('CapacitorOcr', {});

export * from './definitions';
export { Ocr };
