---
name: frontend-3d
description: Expert 3D web development with React Three Fiber, Three.js, GLSL shaders, GSAP animations, post-processing, and immersive Awwwards-quality experiences
metadata:
  languages: typescript,javascript,glsl
  frameworks: react-three-fiber,three.js,gsap,drei,postprocessing
---

## What I do

I build production-grade immersive 3D web experiences with modern visual effects:

- **React Three Fiber (R3F)**: Declarative 3D scenes in React with full Three.js power
- **Drei**: Helper components for R3F (controls, loaders, helpers, gizmos)
- **Three.js**: Core 3D engine - meshes, materials, lights, cameras, textures
- **GLSL Shaders**: Custom vertex/fragment shaders for liquid effects, distortions, gradients
- **GSAP + ScrollTrigger**: Scroll-driven animations, timeline sequencing, smooth transitions
- **Lenis**: Smooth scroll for premium feel
- **Post-Processing**: Bloom, DOF, chromatic aberration, film grain, vignette
- **Performance**: Draco/Meshopt compression, KTX2 textures, instancing, lazy loading
- **WebGPU**: Next-gen GPU API for complex simulations

## When to use me

- Creating Awwwards-quality immersive websites
- Building 3D product configurators and viewers
- Implementing scroll-driven 3D storytelling
- Creating particle systems and fluid simulations
- Building interactive 3D landing pages
- Loading and optimizing 3D models (GLB/GLTF)
- Implementing custom shader effects
- Adding post-processing cinematic effects
- Creating WebGL/WebGPU visualizations
- Building 3D data visualizations

## Core Stack

### React Three Fiber (R3F)

The dominant library for 3D in React. Declarative syntax wrapping Three.js.

```tsx
import { Canvas, useFrame, useThree } from "@react-three/fiber";
import { useRef } from "react";
import * as THREE from "three";

function RotatingBox() {
  const meshRef = useRef<THREE.Mesh>(null);

  useFrame((state, delta) => {
    if (meshRef.current) {
      meshRef.current.rotation.x += delta * 0.5;
      meshRef.current.rotation.y += delta * 0.3;
    }
  });

  return (
    <mesh ref={meshRef}>
      <boxGeometry args={[1, 1, 1]} />
      <meshStandardMaterial color="#00ff88" metalness={0.8} roughness={0.2} />
    </mesh>
  );
}

function Scene() {
  return (
    <Canvas
      camera={{ position: [0, 0, 5], fov: 75 }}
      gl={{ antialias: true, alpha: false }}
      dpr={[1, 2]}
    >
      <ambientLight intensity={0.5} />
      <pointLight position={[10, 10, 10]} intensity={1} />
      <RotatingBox />
    </Canvas>
  );
}
```

### Drei Helpers

Essential helpers for R3F development:

```tsx
import {
  // Controls
  OrbitControls,
  TrackballControls,
  MapControls,

  // Transform & Gizmos
  TransformControls,
  GizmoHelper,
  GizmoViewport,

  // Loading
  useGLTF,
  useTexture,
  useFBX,
  useProgress,
  Html,
  Loader,

  // Text
  Text,
  Text3D,
  Center,

  // Shapes
  RoundedBox,
  Capsule,
  TorusKnot,

  // Effects
  Float,
  Sparkles,
  Cloud,
  Stars,
  Trail,

  // Environment
  Environment,
  Lightformer,
  ContactShadows,

  // Misc
  PerspectiveCamera,
  OrthographicCamera,
  MeshTransmissionMaterial,
  MeshDistortMaterial,
  MeshWobbleMaterial,
  Outlines,
  Billboard,
  ScreenSpace,
  Preload,
  PerformanceMonitor,
} from "@react-three/drei";
```

### Meshes & Geometry

```tsx
// Primitive geometries
<mesh>
  <boxGeometry args={[width, height, depth]} />
  <sphereGeometry args={[radius, widthSegments, heightSegments]} />
  <cylinderGeometry args={[radiusTop, radiusBottom, height, radialSegments]} />
  <torusGeometry args={[radius, tube, radialSegments, tubularSegments]} />
  <icosahedronGeometry args={[radius, detail]} />
  <planeGeometry args={[width, height, widthSegments, heightSegments]} />
  <coneGeometry args={[radius, height, radialSegments]} />
  <knotGeometry args={[radius, tube, tubularSegments, radialSegments]} />
</mesh>

// Custom geometry from buffer attributes
const vertices = new Float32Array([...]);
const geometry = new THREE.BufferGeometry();
geometry.setAttribute('position', new THREE.BufferAttribute(vertices, 3));

<mesh geometry={geometry}>
  <meshBasicMaterial color="red" side={THREE.DoubleSide} />
</mesh>
```

### Materials (PBR)

```tsx
// Standard PBR material
<meshStandardMaterial
  color="#ffffff"
  metalness={0.5}
  roughness={0.5}
  map={colorTexture}
  normalMap={normalTexture}
  roughnessMap={roughnessTexture}
  metalnessMap={metalnessTexture}
  aoMap={aoTexture}
  envMapIntensity={1.0}
/>

// Physical material (more features)
<meshPhysicalMaterial
  color="#ffffff"
  metalness={1}
  roughness={0}
  transmission={0.9}      // Glass effect
  thickness={0.5}
  ior={1.5}               // Index of refraction
  clearcoat={1}
  clearcoatRoughness={0}
  sheen={1}
  sheenColor="#ff0000"
/>

// Drei special materials
<MeshTransmissionMaterial
  transmission={1}
  thickness={0.5}
  chromaticAberration={0.06}
  anisotropy={0.1}
  distortion={0.1}
  temporalDistortion={0.1}
/>

<MeshDistortMaterial
  color="#00ff88"
  distort={0.3}
  speed={2}
/>

// Custom shader material
<shaderMaterial
  vertexShader={vertexShader}
  fragmentShader={fragmentShader}
  uniforms={uniforms}
  transparent
  side={THREE.DoubleSide}
/>
```

### Lights & Shadows

```tsx
// Ambient light - uniform illumination
<ambientLight intensity={0.5} color="#ffffff" />

// Directional light - sun-like, supports shadows
<directionalLight
  position={[5, 5, 5]}
  intensity={1}
  castShadow
  shadow-mapSize-width={2048}
  shadow-mapSize-height={2048}
  shadow-camera-far={50}
  shadow-camera-left={-10}
  shadow-camera-right={10}
  shadow-camera-top={10}
  shadow-camera-bottom={-10}
/>

// Point light - light bulb
<pointLight position={[0, 5, 0]} intensity={1} distance={50} decay={2} />

// Spot light - flashlight
<spotLight
  position={[0, 10, 0]}
  angle={0.3}
  penumbra={1}
  intensity={1}
  castShadow
/>

// Rect area light - studio lighting
<rectAreaLight
  width={3}
  height={3}
  intensity={1}
  position={[-2, 0, 5]}
/>

// Shadow receiver
<mesh receiveShadow>
  <planeGeometry args={[100, 100]} />
  <shadowMaterial opacity={0.5} />
</mesh>

// Drei contact shadows (fake soft shadows)
<ContactShadows
  position={[0, -1.5, 0]}
  opacity={0.5}
  scale={10}
  blur={2}
  far={4}
/>
```

### Camera Controls

```tsx
import { OrbitControls, PerspectiveCamera } from "@react-three/drei";

// Orbit controls
<OrbitControls
  enablePan={true}
  enableZoom={true}
  enableRotate={true}
  autoRotate={true}
  autoRotateSpeed={1}
  minDistance={2}
  maxDistance={10}
  minPolarAngle={0}
  maxPolarAngle={Math.PI / 2}
  dampingFactor={0.05}
  enableDamping={true}
/>

// Custom camera
<PerspectiveCamera makeDefault position={[0, 0, 5]} fov={75} />

// Camera animation with useFrame
function CameraAnimation() {
  const { camera } = useThree();

  useFrame((state) => {
    camera.position.x = Math.sin(state.clock.elapsedTime * 0.5) * 5;
    camera.lookAt(0, 0, 0);
  });

  return null;
}
```

### Transformations

```tsx
// Position, rotation, scale
<mesh
  position={[x, y, z]}
  rotation={[rx, ry, rz]}  // Euler angles in radians
  scale={[sx, sy, sz]}
>
  <boxGeometry />
</mesh>

// Quaternion rotation
<mesh quaternion={new THREE.Quaternion().setFromEuler(new THREE.Euler(0, Math.PI/4, 0))}>

// Group transformations
<group position={[0, 0, 0]} rotation={[0, 0, 0]} scale={1}>
  <mesh>...</mesh>
  <mesh>...</mesh>
</group>

// TransformControls (interactive)
<TransformControls mode="translate" size={0.5}>
  <mesh>
    <boxGeometry />
    <meshStandardMaterial />
  </mesh>
</TransformControls>
```

### useFrame Hook (Animation Loop)

```tsx
import { useFrame } from "@react-three/fiber";

function AnimatedMesh() {
  const meshRef = useRef<THREE.Mesh>(null);

  useFrame((state, delta) => {
    // state.clock.elapsedTime - total time
    // state.clock.getDelta() - frame delta
    // state.mouse - normalized mouse position (-1 to 1)
    // state.camera - current camera
    // state.size - canvas size
    // delta - time since last frame

    if (meshRef.current) {
      meshRef.current.rotation.y += delta;
      meshRef.current.position.y = Math.sin(state.clock.elapsedTime) * 0.5;
    }
  });

  return (
    <mesh ref={meshRef}>
      <boxGeometry />
      <meshStandardMaterial />
    </mesh>
  );
}
```

### Textures

```tsx
import { useTexture, useCubeTexture, Environment } from "@react-three/drei";

// Single texture
function TexturedMesh() {
  const texture = useTexture("/textures/color.jpg");
  texture.wrapS = texture.wrapT = THREE.RepeatWrapping;
  texture.repeat.set(2, 2);

  return (
    <mesh>
      <boxGeometry />
      <meshStandardMaterial map={texture} />
    </mesh>
  );
}

// Multiple textures
function PBRSurface() {
  const [colorMap, normalMap, roughnessMap, metalnessMap, aoMap] = useTexture([
    "/textures/color.jpg",
    "/textures/normal.jpg",
    "/textures/roughness.jpg",
    "/textures/metalness.jpg",
    "/textures/ao.jpg",
  ]);

  return (
    <mesh>
      <sphereGeometry args={[1, 64, 64]} />
      <meshStandardMaterial
        map={colorMap}
        normalMap={normalMap}
        roughnessMap={roughnessMap}
        metalnessMap={metalnessMap}
        aoMap={aoMap}
      />
    </mesh>
  );
}

// Environment map (HDRi)
<Environment preset="city" background />
// presets: apartment, city, dawn, forest, lobby, night, park, studio, sunset, warehouse
```

### Loading Models

```tsx
import { useGLTF, useFBX, useOBJ, Html, useProgress } from "@react-three/drei";
import { Suspense } from "react";

// GLTF/GLB loading
function Model({ url }: { url: string }) {
  const { scene, animations } = useGLTF(url);
  return <primitive object={scene} dispose={null} />;
}

// With animations
function AnimatedModel({ url }: { url: string }) {
  const { scene, animations } = useGLTF(url);
  const { actions } = useAnimations(animations, scene);

  useEffect(() => {
    actions.idle?.play();
  }, [actions]);

  return <primitive object={scene} dispose={null} />;
}

// Loading progress
function Loader() {
  const { progress } = useProgress();
  return <Html center>{progress.toFixed(0)}% loaded</Html>;
}

// Suspense boundary
<Suspense fallback={<Loader />}>
  <Model url="/models/scene.glb" />
  <Environment preset="studio" />
</Suspense>

// Preload models
useGLTF.preload("/models/scene.glb");
```

### Raycasting & Interaction

```tsx
import { useFrame, useThree } from "@react-three/fiber";
import * as THREE from "react-three-fiber";

function InteractiveMesh() {
  const meshRef = useRef<THREE.Mesh>(null);
  const [hovered, setHovered] = useState(false);
  const [clicked, setClicked] = useState(false);

  return (
    <mesh
      ref={meshRef}
      onPointerOver={(e) => {
        e.stopPropagation();
        setHovered(true);
        document.body.style.cursor = "pointer";
      }}
      onPointerOut={() => {
        setHovered(false);
        document.body.style.cursor = "auto";
      }}
      onClick={(e) => {
        e.stopPropagation();
        setClicked(!clicked);
      }}
      onPointerMove={(e) => {
        // e.point - world position
        // e.uv - UV coordinates
        // e.face - face normal
      }}
    >
      <boxGeometry />
      <meshStandardMaterial color={clicked ? "red" : hovered ? "hotpink" : "blue"} />
    </mesh>
  );
}

// Raycaster with three.js
function RaycastExample() {
  const { camera, scene } = useThree();
  const raycaster = useRef(new THREE.Raycaster());

  useFrame((state) => {
    raycaster.current.setFromCamera(state.mouse, camera);
    const intersects = raycaster.current.intersectObjects(scene.children);
    // Handle intersects
  });

  return null;
}
```

### Audio & PositionalAudio

```tsx
import { useLoader, useThree } from "@react-three/fiber";
import { AudioListener, AudioLoader, PositionalAudio } from "three";

function Sound() {
  const soundRef = useRef<PositionalAudio>(null);
  const { camera } = useThree();
  const [listener] = useState(() => new AudioListener());
  const buffer = useLoader(AudioLoader, "/audio/sound.mp3");

  useEffect(() => {
    camera.add(listener);
    if (soundRef.current) {
      soundRef.current.setBuffer(buffer);
      soundRef.current.setRefDistance(1);
      soundRef.current.play();
    }
    return () => {
      camera.remove(listener);
    };
  }, [buffer, camera, listener]);

  return (
    <positionalAudio ref={soundRef} args={[listener]} />
  );
}
```

## GSAP Integration

### ScrollTrigger with R3F

```tsx
import { useGSAP } from "@gsap/react";
import gsap from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { useThree } from "@react-three/fiber";

gsap.registerPlugin(ScrollTrigger);

function ScrollAnimation() {
  const { camera } = useThree();
  const meshRef = useRef<THREE.Mesh>(null);

  useGSAP(() => {
    // Animate camera on scroll
    gsap.to(camera.position, {
      z: 5,
      scrollTrigger: {
        trigger: "#section-1",
        start: "top center",
        end: "bottom center",
        scrub: 1,
      },
    });

    // Animate mesh on scroll
    if (meshRef.current) {
      gsap.to(meshRef.current.rotation, {
        y: Math.PI * 2,
        scrollTrigger: {
          trigger: "#section-2",
          start: "top bottom",
          end: "bottom top",
          scrub: true,
        },
      });
    }
  });

  return (
    <mesh ref={meshRef}>
      <torusKnotGeometry />
      <meshStandardMaterial />
    </mesh>
  );
}
```

### Smooth Scroll with Lenis

```tsx
import { ReactLenis, useLenis } from "lenis/react";

function Layout({ children }: { children: React.ReactNode }) {
  return (
    <ReactLenis
      root
      options={{
        lerp: 0.1,
        duration: 1.2,
        smoothWheel: true,
        wheelMultiplier: 1,
      }}
    >
      {children}
    </ReactLenis>
  );
}

// Hook into scroll
function ScrollComponent() {
  const lenis = useLenis(({ scroll }) => {
    // scroll position
  });

  return <div>...</div>;
}
```

## GLSL Shaders

### Vertex Shader

```glsl
// vertex.glsl
uniform float uTime;
uniform float uFrequency;
uniform float uAmplitude;

varying vec2 vUv;
varying float vElevation;
varying vec3 vNormal;

void main() {
  vUv = uv;
  vNormal = normal;

  vec3 pos = position;

  // Wave effect
  float elevation = sin(pos.x * uFrequency + uTime) * uAmplitude;
  elevation += sin(pos.y * uFrequency * 0.5 + uTime * 0.8) * uAmplitude * 0.5;
  pos.z += elevation;
  vElevation = elevation;

  gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}
```

### Fragment Shader

```glsl
// fragment.glsl
uniform float uTime;
uniform vec3 uColor;
uniform sampler2D uTexture;

varying vec2 vUv;
varying float vElevation;
varying vec3 vNormal;

void main() {
  // Color based on elevation
  float mixStrength = (vElevation + 0.5) * 0.5;
  vec3 color = mix(uColor, vec3(1.0, 0.0, 0.0), mixStrength);

  // Or texture
  // vec4 texColor = texture2D(uTexture, vUv);
  // color = texColor.rgb;

  gl_FragColor = vec4(color, 1.0);
}
```

### Custom Shader Material in R3F

```tsx
import { shaderMaterial } from "@react-three/drei";
import { extend, useFrame } from "@react-three/fiber";
import * as THREE from "three";

// Create custom material
const WaveMaterial = shaderMaterial(
  {
    uTime: 0,
    uFrequency: 5.0,
    uAmplitude: 0.1,
    uColor: new THREE.Color("#00ff88"),
  },
  vertexShader,
  fragmentShader
);

extend({ WaveMaterial });

function WaveMesh() {
  const materialRef = useRef<any>(null);

  useFrame((state) => {
    if (materialRef.current) {
      materialRef.current.uTime = state.clock.elapsedTime;
    }
  });

  return (
    <mesh>
      <planeGeometry args={[2, 2, 128, 128]} />
      <waveMaterial ref={materialRef} side={THREE.DoubleSide} wireframe />
    </mesh>
  );
}
```

## Post-Processing

```tsx
import {
  EffectComposer,
  Bloom,
  ChromaticAberration,
  DepthOfField,
  Noise,
  Vignette,
  ToneMapping,
  HueSaturation,
  BrightnessContrast,
  GodRays,
  SSR,
  SSAO,
  Outline,
  Pixelation,
  Glitch,
  DotScreen,
} from "@react-three/postprocessing";
import { BlendFunction, KernelSize } from "postprocessing";

function PostProcessing() {
  return (
    <EffectComposer>
      <Bloom
        intensity={1.5}
        luminanceThreshold={0.9}
        luminanceSmoothing={0.025}
        kernelSize={KernelSize.LARGE}
      />
      <ChromaticAberration
        offset={[0.002, 0.002]}
        blendFunction={BlendFunction.NORMAL}
      />
      <DepthOfField
        focusDistance={0.01}
        focalLength={0.02}
        bokehScale={3}
      />
      <Noise opacity={0.05} />
      <Vignette eskil={false} offset={0.1} darkness={1.1} />
      <HueSaturation
        blendFunction={BlendFunction.NORMAL}
        hue={0}
        saturation={0.1}
      />
    </EffectComposer>
  );
}
```

## Performance Optimization

### Compression

```tsx
// Draco compression (geometry)
import { useGLTF } from "@react-three/drei";
import { DracoLoader } from "three/examples/jsm/loaders/DRACOLoader";

useGLTF("/models/scene.glb", true, (loader) => {
  const dracoLoader = new DracoLoader();
  dracoLoader.setDecoderPath("/draco/");
  loader.setDRACOLoader(dracoLoader);
});

// Meshopt compression (better for animated models)
import { MeshoptDecoder } from "three/examples/jsm/libs/meshopt_decoder.module";

useGLTF("/models/scene.glb", true, (loader) => {
  loader.setMeshoptDecoder(MeshoptDecoder);
});
```

### Instancing

```tsx
import { Instances, Instance } from "@react-three/drei";

function InstancedMeshes() {
  return (
    <Instances limit={1000} castShadow receiveShadow>
      <boxGeometry args={[0.1, 0.1, 0.1]} />
      <meshStandardMaterial />

      {Array.from({ length: 1000 }, (_, i) => (
        <Instance
          key={i}
          position={[
            Math.random() * 10 - 5,
            Math.random() * 10 - 5,
            Math.random() * 10 - 5,
          ]}
          rotation={[Math.random() * Math.PI, Math.random() * Math.PI, 0]}
          color={`hsl(${Math.random() * 360}, 70%, 50%)`}
        />
      ))}
    </Instances>
  );
}
```

### Performance Monitor

```tsx
import { PerformanceMonitor } from "@react-three/drei";

function AdaptiveScene() {
  return (
    <Canvas>
      <PerformanceMonitor
        onDecline={() => {
          // Reduce quality
        }}
        onIncline={() => {
          // Increase quality
        }}
      >
        <Scene />
      </PerformanceMonitor>
    </Canvas>
  );
}
```

### Lazy Loading

```tsx
import dynamic from "next/dynamic";

const Scene3D = dynamic(() => import("@/components/three/scene"), {
  ssr: false,
  loading: () => <div>Loading 3D...</div>,
});
```

## Audio Integration

```tsx
import { Audio, AudioListener, AudioLoader, PositionalAudio } from "three";

function BackgroundMusic() {
  const { camera } = useThree();
  const [listener] = useState(() => new AudioListener());
  const sound = useRef<Audio>(null);
  const buffer = useLoader(AudioLoader, "/audio/music.mp3");

  useEffect(() => {
    camera.add(listener);
    if (sound.current) {
      sound.current.setBuffer(buffer);
      sound.current.setLoop(true);
      sound.current.setVolume(0.5);
      sound.current.play();
    }
    return () => {
      camera.remove(listener);
    };
  }, [buffer, camera, listener]);

  return <audio ref={sound} args={[listener]} />;
}

// Positional audio (3D spatial sound)
function SpatialSound({ position }: { position: [number, number, number] }) {
  const soundRef = useRef<PositionalAudio>(null);
  const { camera } = useThree();
  const [listener] = useState(() => new AudioListener());
  const buffer = useLoader(AudioLoader, "/audio/ambient.mp3");

  useEffect(() => {
    camera.add(listener);
    if (soundRef.current) {
      soundRef.current.setBuffer(buffer);
      soundRef.current.setRefDistance(5);
      sound.current.setDistanceModel("exponential");
      soundRef.current.play();
    }
  }, [buffer, camera, listener]);

  return (
    <mesh position={position}>
      <sphereGeometry args={[0.5]} />
      <meshStandardMaterial color="red" />
      <positionalAudio ref={soundRef} args={[listener]} />
    </mesh>
  );
}
```

## Project Structure

```
src/
├── components/
│   ├── three/
│   │   ├── canvas.tsx          # R3F Canvas wrapper
│   │   ├── scene.tsx           # Main scene composition
│   │   ├── lights.tsx          # Lighting setup
│   │   ├── environment.tsx     # HDRi, environment
│   │   ├── effects.tsx         # Post-processing
│   │   ├── camera.tsx          # Camera setup & controls
│   │   ├── models/
│   │   │   ├── model-loader.tsx
│   │   │   └── animated-model.tsx
│   │   ├── meshes/
│   │   │   ├── custom-mesh.tsx
│   │   │   └── instanced-mesh.tsx
│   │   ├── shaders/
│   │   │   ├── vertex.glsl
│   │   │   ├── fragment.glsl
│   │   │   └── wave-material.tsx
│   │   ├── particles/
│   │   │   ├── particles.tsx
│   │   │   └── sparkles.tsx
│   │   ├── helpers/
│   │   │   ├── gizmos.tsx
│   │   │   └── debug.tsx
│   │   └── audio/
│   │       ├── background-music.tsx
│   │       └── spatial-audio.tsx
│   ├── ui/
│   │   ├── loading-screen.tsx
│   │   └── overlay.tsx
│   └── layout/
│       └── scroll-container.tsx
├── hooks/
│   ├── use-scroll-progress.ts
│   ├── use-mouse-position.ts
│   ├── use-device-performance.ts
│   └── use-intersection-observer.ts
├── shaders/
│   ├── vertex/
│   │   ├── wave.glsl
│   │   ├── noise.glsl
│   │   └── particles.glsl
│   └── fragment/
│       ├── hologram.glsl
│       ├── liquid.glsl
│       └── gradient.glsl
├── utils/
│   ├── texture-loader.ts
│   ├── model-optimizer.ts
│   └── shader-utils.ts
├── stores/
│   └── scene-store.ts          # Zustand for 3D state
├── types/
│   └── three.d.ts              # Three.js type extensions
└── public/
    ├── models/
    │   └── scene.glb
    ├── textures/
    │   ├── color.jpg
    │   ├── normal.jpg
    │   └── roughness.jpg
    └── audio/
        └── ambient.mp3
```

## Best Practices

### Performance Rules
- Always use `dpr={[1, 2]}` for responsive pixel ratio
- Compress models with Draco or Meshopt (90% size reduction)
- Use KTX2 for GPU-ready textures
- Implement instancing for repeated objects
- Use `<PerformanceMonitor>` for adaptive quality
- Lazy load 3D scenes with dynamic imports
- Set `dispose={null}` on `<primitive>` to prevent memory leaks
- Use `<Preload all />` to preload assets

### Model Optimization
- Export as GLB (binary GLTF) for smallest size
- Keep polygon count under 100k for mobile
- Use LOD (Level of Detail) for complex scenes
- Bake lighting into textures when possible
- Remove unused materials and textures from Blender

### Shader Guidelines
- Keep shaders simple on mobile (avoid complex loops)
- Use `varying` to pass data from vertex to fragment
- Normalize normals in fragment shader
- Use `precision mediump float` for mobile
- Test on multiple GPUs

### Interaction Patterns
- Use `onPointerOver/Out` for hover effects
- Use `onClick` for selection
- Use `e.stopPropagation()` to prevent event bubbling
- Change cursor with `document.body.style.cursor`
- Use raycasting for complex picking

### Memory Management
- Dispose geometries, materials, textures when unmounting
- Use `useGLTF.dispose()` when no longer needed
- Remove event listeners in cleanup
- Avoid creating objects in `useFrame`
- Reuse vectors and matrices with `useMemo`

## Environment & Background

```tsx
import { Environment, Stars, Sky } from "@react-three/drei";

// HDRi environment
<Environment
  preset="studio"
  background
  blur={0.8}
  resolution={256}
/>

// Custom HDRi
<Environment
  files="/hdris/studio.hdr"
  background
/>

// Stars
<Stars
  radius={100}
  depth={50}
  count={5000}
  factor={4}
  saturation={0}
  fade
  speed={1}
/>

// Sky
<Sky
  distance={450000}
  sunPosition={[0, 1, 0]}
  inclination={0}
  azimuth={0.25}
/>
```

## Tools & Libraries

- **React Three Fiber**: `@react-three/fiber`
- **Drei**: `@react-three/drei`
- **Post-Processing**: `@react-three/postprocessing`
- **GSAP**: `gsap` + `@gsap/react`
- **Lenis**: `lenis`
- **Three.js**: `three`
- **Spline**: `@splinetool/react-spline`
- **Leva**: `leva` (GUI controls)
- **R3F Helpers**: `@react-three/a11y`, `@react-three/test-utils`

## References

- [R3F Documentation](https://r3f.docs.pmnd.rs)
- [Drei Documentation](https://drei.docs.pmnd.rs)
- [Three.js Documentation](https://threejs.org/docs)
- [Three.js Journey](https://threejs-journey.com)
- [GLSL Sandbox](https://glslsandbox.com)
- [Shadertoy](https://www.shadertoy.com)
- [Awwwards 3D Sites](https://www.awwwards.com/3d/)
- [Codrops](https://tympanus.net/codrops/)
