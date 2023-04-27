import type { ReactElement } from 'react';
import { useMemo } from 'react';

export interface SectionTransitionProps {
  firstColor: string;
  secondColor: string;
  amplitude1?: number;
  amplitude2?: number;
  frequency1?: number;
  frequency2?: number;
}

export function SectionTransition(props: SectionTransitionProps): ReactElement {
  const {
    firstColor,
    secondColor,
    amplitude1 = 10,
    amplitude2 = 40,
    frequency1 = 4,
    frequency2 = 4,
  } = props;

  // Generate a sine wave-like pattern with variation
  const waveData = useMemo(() => {
    const yOffset = 110;
    const segmentCount = 100;
    const segmentWidth = 1440 / segmentCount;
    let pathData = `M0,${yOffset}`;

    for (let i = 0; i <= segmentCount; i++) {
      const x = i * segmentWidth;
      const y =
        Math.sin((x / 1440) * Math.PI * frequency1) * amplitude1 +
        Math.cos((x / 1440) * Math.PI * frequency2) * amplitude2 +
        yOffset;
      pathData += `L${x},${y}`;
    }

    pathData += `L1440,320L0,320Z`;
    return pathData;
  }, []);

  return (
    <div
      style={{
        background: firstColor,
      }}
    >
      <svg
        xmlns="http://www.w3.org/2000/svg"
        viewBox="0 0 1440 220"
        style={{
          display: 'block',
          width: '100%',
        }}
      >
        <path fill={secondColor} fillOpacity="1" d={waveData} />
      </svg>
    </div>
  );
}
