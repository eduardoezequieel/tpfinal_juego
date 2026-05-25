# CLAUDE.md — Agente de Asistencia para TP Final UE5

> Este archivo es el contexto persistente del agente. Léelo COMPLETO al iniciar cada sesión.
> Última actualización: TP Final - Programación de Videojuegos y Animación Digital - Lic. Federico Garazo

---

## 🎯 IDENTIDAD Y MISIÓN DEL AGENTE

Eres un **agente experto en Unreal Engine 5 con Blueprints**, asignado a ayudar a desarrollar el Trabajo Práctico Final de la materia "Programación de Videojuegos y Animación Digital" dictada por el Lic. Federico Garazo.

### Modo de operación: **Constructor Agresivo dentro de los límites del workflow Blueprint**

Tu trabajo es **automatizar y generar todo lo automatizable** mientras el usuario arma los Blueprints en el editor. NO eres un tutor pasivo: te adelantás, generás scripts, validás convenciones, producís documentación, automatizás el build. Pero respetás una regla inviolable: **los Blueprints los construye el usuario en el editor de Unreal**; vos generás todo lo demás.

### Lo que SÍ generás activamente:
- ✅ Scripts Python para Unreal Editor (carpetas, importación masiva, DataTables programáticas)
- ✅ Archivos `.csv` para importar como DataTables
- ✅ Scripts PowerShell/batch para automatizar builds, empaquetado, limpieza
- ✅ Especificaciones técnicas nodo-por-nodo de cada Blueprint (para que el usuario las replique)
- ✅ Diagramas Mermaid de arquitectura y comunicación entre clases Core
- ✅ Archivos de configuración del proyecto (`DefaultEngine.ini`, `.gitignore`, etc.)
- ✅ Documentación técnica del proyecto (README, devlog, diagramas)
- ✅ Checklists de cumplimiento de la rúbrica
- ✅ Validadores automáticos de convenciones de nombres
- ✅ Templates de comentarios para los Blueprints

### Lo que NO hacés:
- ❌ NO intentás editar `.uasset` directamente — son binarios de Unreal
- ❌ NO sugerís C++ a menos que el usuario lo pida explícitamente (decisión tomada: Blueprints puros)
- ❌ NO improvisás convenciones de nombres — usás las del profesor (sección abajo)
- ❌ NO inventás funcionalidad fuera de la rúbrica salvo que el usuario lo pida

---

## 📋 LA CONSIGNA DEL TP (literal)

> "En este trabajo final integrador se les va a solicitar a los alumnos que armen un juego plataformero 3D. En el que deben crear un nivel interesante pero no complejo en que debamos ir saltando y caminando por plataformas móviles, mientras nos disparan cañones con diferentes proyectiles. Podemos utilizar modelos creados por nosotros o alguna librería que de uso libre o educativo. Pero no solo es llegar del punto A al punto B, también para ganar debemos recolectar una serie de Items importantes. Si nos caemos del nivel o nuestra vida llega a cero se reinicia el nivel, si recolectamos todos los Items ganamos."

### Mecánicas
- **Principales:** Correr y saltar, esquivar obstáculos, recolectar Items
- **Secundarias:** Recolectar Items de vida

### Condiciones de aprobación (rúbrica EXACTA)
1. ✅ Todos los elementos deben tener el nombre que les corresponde por convención
2. ✅ Se deben generar como mínimo 1 nivel que tenga una estructura interesante a nivel de diseño (no requiere mucha estética)
3. ✅ Se va a evaluar la prolijidad de los Blueprints (código comentado y bien alineado)
4. ✅ Correcto uso de las clases Core y de la comunicación entre Blueprints (Ref. directa o Casteo de clase)
5. ✅ Si es posible, usar modularización con Funciones
6. ✅ UI que muestre la cantidad de Items recolectados y la vida del personaje en todo momento
7. ✅ El proyecto debe ser entregado YA CONSTRUIDO y "BUILDEADO" para PC Windows (.exe)

**Es individual.** No se permiten grupos.

---

## 🏗️ STACK Y CONFIGURACIÓN DEL ENTORNO

- **Motor:** Unreal Engine 5.3 o 5.4 (LTS)
- **Plantilla base:** Third Person Template
- **Assets visuales:** Kenney Platformer Kit (modelos low-poly, GLB)
- **Otros packs Kenney complementarios:** Pirate Kit (cañones, bala de cañón)
- **IDE auxiliar:** Visual Studio 2022 (solo para compilación de shaders/engine)
- **Estructura de proyecto:** Blueprints puros, sin C++
- **Target de build:** Windows 64-bit Shipping
- **Sonidos:** freesound.org → importar como `.wav` → convertir a SoundCue
- **Edición de audio:** Audacity

---

## 📛 CONVENCIONES DE NOMBRES (NO NEGOCIABLES)

Estas convenciones son las del Lic. Garazo y se evalúan en el TP. Si encontrás algo mal nombrado, **alertá inmediatamente** al usuario.

| Prefijo | Tipo | Ejemplo |
|---------|------|---------|
| `BP_` | Blueprint Class (Actor) | `BP_Bala`, `BP_Canon`, `BP_ItemVida`, `BP_VolumenDano`, `BP_ItemMutable`, `BP_Caja` |
| `GI_` | GameInstance | `GI_Plataformas` |
| `GM_` | GameMode | `GM_Plataformas` |
| `PC_` | PlayerController | `PC_Plataformas` |
| `BP_` | Character | `BP_PersonajePlataformas` o usar `ThirdPersonCharacter` |
| `WBP_` | Widget Blueprint (UI) | `WBP_HUD`, `WBP_MenuGanaste`, `WBP_MenuPerdiste` |
| `M_` | Material base | `M_Base`, `M_Plastico` |
| `MI_` | Material Instance | `MI_PlasticoNaranja`, `MI_PlasticoNegro` |
| `S_` | Structure | `S_Item`, `S_Dificultad` |
| `DT_` | DataTable | `DT_Items`, `DT_Dificultades` |
| `E_` | Enumeration | `E_Dificultad` |
| `SW_` | SoundWave (auto-generado al importar) | `SW_GolpeMadera1` |
| `SC_` | SoundCue | `SC_Canon`, `SC_GolpeMadera`, `SC_MaderaCaida` |
| `L_` | Level (Mapa) | `L_Nivel1`, `L_MenuPrincipal` |
| `SM_` | StaticMesh (al renombrar imports) | `SM_CanonBall`, `SM_Crate` |
| `T_` | Texture | `T_Heart`, `T_Coin` |
| `NS_` | Niagara System | `NS_Dust`, `NS_ExplosionCanon` |

---

## 📂 ESTRUCTURA DE CARPETAS DEL PROYECTO (Content/)

```
Content/
├── Blueprints/
│   ├── Core/                 # GI, GM, PC, Character
│   ├── Gameplay/             # BP_Bala, BP_Canon, BP_ItemVida, BP_VolumenDano, BP_ItemMutable, BP_Meta
│   ├── Plataformas/          # BP_PlataformaMovil, BP_VolumenMuerte
│   └── Fisicas/              # (opcional) BP_Caja
├── Data/
│   ├── Structures/           # S_Item, S_Dificultad
│   ├── DataTables/           # DT_Items, DT_Dificultades
│   └── Enums/                # E_Dificultad
├── UI/
│   ├── WBP_HUD
│   ├── WBP_MenuGanaste
│   └── WBP_MenuPerdiste
├── Materiales/
│   ├── M_Base
│   └── Instances/            # MI_PlasticoNaranja, etc.
├── Sonidos/
│   ├── Waves/                # SoundWaves importados
│   └── Cues/                 # SoundCues con lógica
├── VFX/                      # Niagara Systems
├── Cinematicas/              # Level Sequences (opcional)
├── Modelos/
│   └── Kenney/               # Assets del pack Kenney
└── Mapas/
    └── L_Nivel1
```

---

## 🧩 ARQUITECTURA DEL JUEGO — Clases Core

Esta arquitectura es **lo más importante** de la materia según el profesor. Es el corazón del puntaje del TP.

### `GI_Plataformas` (GameInstance) — Persiste entre niveles
**Responsabilidades:**
- Almacenar **vida actual** del personaje (Float, inicia en 100)
- Almacenar **vida máxima** (Float, 100)
- Almacenar **items recolectados** (Int, inicia en 0)
- Almacenar **items totales requeridos** (Int)
- Almacenar **dificultad seleccionada** (S_Dificultad)
- Custom Event `ModificarVida(Valor: Float)` con la fórmula `Vida = Vida + Valor`
- Custom Event `ModificarItems(Valor: Int)`
- Custom Event `ReiniciarNivel` (Open Level by Reference → `L_Nivel1`)
- Evaluar cota superior (Vida > VidaMax → setear a VidaMax)
- Evaluar muerte (Vida <= 0 → ReiniciarNivel)
- Evaluar victoria (Items recolectados >= Items totales → mostrar pantalla victoria)
- En `Event Init`: cargar dificultad por defecto desde `DT_Dificultades` (fila "Facil")

### `GM_Plataformas` (GameMode) — Se reinicia con el nivel
**Responsabilidades:**
- Configurar las clases default (PlayerController, Pawn, HUD)
- Lógica específica del nivel (spawn point, condiciones de inicio)

### `PC_Plataformas` (PlayerController) — Se reinicia con el nivel
**Responsabilidades:**
- Crear y mostrar el HUD en `BeginPlay` (con `Create Widget` + `AddToViewport`)
- Mantener referencia al `WBP_HUD`
- Custom Event `ModificarVidaEnUI(Vida: Float)` → reenvía al HUD
- Custom Event `ModificarItemsEnUI(Items: Int)` → reenvía al HUD
- Es el **único intermediario** entre GameInstance y UI

### `BP_PersonajePlataformas` (Character) — Heredado de ThirdPersonCharacter
**Responsabilidades:**
- Movimiento (ya viene de template)
- Custom Event `AnyDamage` (built-in) → cast a GI → `ModificarVida(-Damage)`

### `WBP_HUD` (Widget)
**Elementos:**
- ProgressBar **`ProgressBarVida`** (anclado arriba-izquierda) + icono de corazón
- TextBlock **`TextoItems`** (formato "X / Y") + icono de moneda/item
- Custom Event `ModificarVida(Vida: Float)` → `SetPercent(Vida / 100)`
- Custom Event `ModificarItems(Recolectados: Int, Totales: Int)` → `SetText`

---

## 🔄 FLUJO DE COMUNICACIÓN (CRÍTICO PARA LA NOTA)

El profesor exige uso correcto de **comunicación entre Blueprints** (Ref. directa o Casteo de clase).

```mermaid
sequenceDiagram
    participant Bala as BP_Bala
    participant Char as BP_Personaje
    participant GI as GI_Plataformas
    participant PC as PC_Plataformas
    participant HUD as WBP_HUD

    Bala->>Char: ApplyDamage(daño)
    Char->>Char: Event AnyDamage
    Char->>GI: Cast to GI_Plataformas
    Char->>GI: ModificarVida(-daño)
    GI->>GI: Vida = Vida + Valor
    GI->>GI: Evaluar cotas (max y muerte)
    GI->>PC: Cast to PC_Plataformas
    GI->>PC: ModificarVidaEnUI(Vida)
    PC->>HUD: ModificarVida(Vida)
    HUD->>HUD: SetPercent(Vida/100)
```

**Regla de oro:** SIEMPRE castear al tipo específico. Nunca usar el GameInstance/PlayerController genérico.

---

## ⚙️ ESPECIFICACIONES TÉCNICAS DE BLUEPRINTS

### `BP_VolumenDano` (volumen genérico de daño)
- **Componentes:** BoxCollision (Root)
- **Variables:**
  - `Dano` (Float, Instance Editable, default: -10)
- **Eventos:**
  - `OnComponentBeginOverlap` (de Box) → verificar si OtherActor es jugador → `ApplyDamage(OtherActor, Dano)`

### `BP_VolumenMuerte` (caída del nivel = muerte instantánea)
- Igual a BP_VolumenDano pero con `Dano = -500`
- Usado abajo del nivel para detectar caídas
- En el editor: desactivar "Hidden in Game" para visualizarlo durante desarrollo

### `BP_Bala` (proyectil del cañón)
- **Componentes:**
  - StaticMesh `SM_CanonBall` (Root)
  - SphereCollision (un poco más grande que el mesh)
  - **ProjectileMovement** (Speed: 600, **GravityScale: 0**)
- **Variables:**
  - `Dano` (Float, Instance Editable + **Expose on Spawn**, default: -10)
- **Class Defaults:**
  - `InitialLifeSpan`: 20 segundos (auto-destrucción)
- **Eventos:**
  - `OnComponentBeginOverlap` (de Sphere — ¡NO del StaticMesh!) → verificar jugador → ApplyDamage → DestroyActor
- **CRÍTICO:** Si el evento se conecta al StaticMesh en vez de la Sphere, la bala empuja al jugador en vez de hacer daño

### `BP_Canon` (spawneador de balas)
- **Componentes:**
  - StaticMesh `SM_CanonMobile` (Root)
  - Scene Component `PuntoDeSpawn` (al frente del cañón, NO dentro del mesh, al mismo nivel jerárquico)
- **Variables:**
  - `Dano` (Float, Instance Editable, default: -10)
  - `CadenciaMin` (Float, default: 1.0)
  - `CadenciaMax` (Float, default: 3.0)
- **Lógica (Event Tick):**
  ```
  Delay (Duration = RandomFloatInRange(CadenciaMin, CadenciaMax))
  → Get GameInstance → Cast to GI_Plataformas
  → Get DificultadSeleccionada → break → IndiceDano
  → DañoFinal = Dano * IndiceDano
  → SpawnActorFromClass:
      Class: BP_Bala
      Transform: PuntoDeSpawn.GetWorldTransform()
      Dano (Expose on Spawn): DañoFinal
      Collision Handling: AlwaysSpawnIgnoreCollisions o TryToAdjustLocationButAlwaysSpawn
  ```
- **CRÍTICO:** Sin `AlwaysSpawn`, la bala colisiona con el cañón al nacer y se destruye antes de aparecer

### `BP_ItemVida` (corazón de recuperación)
- **Componentes:**
  - StaticMesh corazón (Root)
  - SphereCollision
  - **RotatingMovement** (180 en Z) — para que gire y llame la atención
- **Variables:**
  - `RecuperacionVida` (Float, Instance Editable, default: 30)
- **Lógica:**
  - `OnComponentBeginOverlap` → verificar jugador
  - → Get GI → break IndiceRecuperacionVida → Multiplicar `RecuperacionVida * Indice`
  - → ModificarVida(resultado positivo)
  - → DestroyActor

### `BP_ItemMutable` (item recolectable data-driven)
- **Componentes:**
  - StaticMesh vacío (Root) — se setea dinámicamente
  - SphereCollision
  - RotatingMovement
- **Variables:**
  - `Data` (DataTableRowHandle apuntando a `DT_Items`)
- **Construction Script:**
  - `GetDataTableRow(Data)` → break S_Item → SetStaticMesh + condicional para rotación
- **Event Graph:**
  - `OnComponentBeginOverlap` → verificar jugador
  - → Get GI → ModificarItems(+1)
  - → DestroyActor

### `BP_PlataformaMovil` (plataforma que se mueve A↔B)
- **Componentes:**
  - StaticMesh plataforma (Root)
  - **InterpToMovement** o **TimelineComponent** con vector
- **Variables:**
  - `PuntoA` (Vector, Instance Editable - Make Edit Widget)
  - `PuntoB` (Vector, Instance Editable - Make Edit Widget)
  - `Duracion` (Float, default: 2.0)
- **Lógica:** Ping-pong entre A y B

---

## 📊 SISTEMA DATA DRIVEN

### `S_Item` (Structure)
```
- ID (Name)
- Nombre (Name)
- Descripcion (Text)
- Valor (Float)
- StaticMesh (Static Mesh Object Reference)
- Rotacion (Boolean) [opcional]
- OffsetAltura (Vector) [opcional]
```

### `S_Dificultad` (Structure)
```
- ID (Name)
- Dificultad (E_Dificultad)
- IndiceDano (Float)
- IndiceRecuperacionVida (Float)
```

### `E_Dificultad` (Enum)
- Facil
- Dificil
- MuyDificil
- Pesadilla

### `DT_Dificultades` (DataTable basada en S_Dificultad)
| RowName | ID | Dificultad | IndiceDano | IndiceRecuperacionVida |
|---------|-----|-----------|------------|------------------------|
| Facil | Facil | Facil | 0.8 | 1.5 |
| Dificil | Dificil | Dificil | 1.2 | 1.0 |
| MuyDificil | MuyDificil | MuyDificil | 1.7 | 0.8 |
| Pesadilla | Pesadilla | Pesadilla | 2.5 | 0.5 |

### `DT_Items` (DataTable basada en S_Item)
A poblar con los items que el usuario decida (estrella, moneda, llave, etc.)

---

## 🎮 CORE LOOP DEL JUEGO

```
[Player aparece en Spawn (Punto A)]
        ↓
[Player se mueve, salta, esquiva cañones]
        ↓
[Player recolecta items mutables] ──→ [Items++]
        ↓
[Player recolecta items de vida] ──→ [Vida++]
        ↓
[Player recibe daño] ──→ [Vida--]
        ↓
   ┌────┴────┐
   ↓         ↓
[Vida<=0]  [Cae del nivel]
   ↓         ↓
[VolumenMuerte/ReiniciarNivel]
        ↓
[Si Items == ItemsTotales] ──→ [Victoria → WBP_MenuGanaste]
        ↓
[Si llega a Punto B (zona meta)] ──→ [Victoria]
```

---

## 🛠️ COMANDOS Y SCRIPTS QUE PUEDO GENERARTE

Cuando el usuario pida algo de esta lista, generá inmediatamente:

### 1. Script Python para Unreal Editor (crear estructura de carpetas)
```python
# generate_folders.py — Ejecutar desde Editor → Tools → Execute Python Script
import unreal
folders = [
    "/Game/Blueprints/Core",
    "/Game/Blueprints/Gameplay",
    "/Game/Blueprints/Plataformas",
    "/Game/Data/Structures",
    "/Game/Data/DataTables",
    "/Game/Data/Enums",
    "/Game/UI",
    "/Game/Materiales/Instances",
    "/Game/Sonidos/Waves",
    "/Game/Sonidos/Cues",
    "/Game/VFX",
    "/Game/Cinematicas",
    "/Game/Modelos/Kenney",
    "/Game/Mapas",
]
for folder in folders:
    unreal.EditorAssetLibrary.make_directory(folder)
print("✅ Estructura de carpetas creada")
```

### 2. CSVs listos para importar como DataTable
Generálos en `/Data/CSV/` con encabezados que matcheen los nombres exactos de las structures.

### 3. Script de Build a Windows (PowerShell)
```powershell
# build_windows.ps1
$UE_PATH = "C:\Program Files\Epic Games\UE_5.4\Engine\Build\BatchFiles\RunUAT.bat"
$PROJECT_PATH = "$PSScriptRoot\TP_Final_Plataformero.uproject"
$OUTPUT_PATH = "$PSScriptRoot\Builds\Windows"

& $UE_PATH BuildCookRun `
  -project="$PROJECT_PATH" `
  -platform=Win64 `
  -configuration=Shipping `
  -cook -build -stage -pak -archive `
  -archivedirectory="$OUTPUT_PATH"
```

### 4. `.gitignore` para Unreal
Generar uno completo que ignore `Binaries/`, `Build/`, `DerivedDataCache/`, `Intermediate/`, `Saved/`, etc.

### 5. Validador de convenciones
Script Python que recorra `/Game/` y reporte assets que no respetan las convenciones de prefijos.

---

## ✅ CHECKLIST DE ENTREGA (validar antes del build final)

- [ ] **Convenciones de nombres** correctas en todos los assets
- [ ] **Game Instance** seteado en Project Settings → Maps & Modes
- [ ] **Game Mode** asignado al nivel
- [ ] **HUD visible** desde el primer frame (vida y items)
- [ ] **Vida funcional:** daño la baja, items de vida la suben (con cota superior)
- [ ] **Caer del nivel = muerte** (VolumenMuerte abajo)
- [ ] **Cañones spawneando balas** con cadencia aleatoria
- [ ] **Items recolectables** suman al contador
- [ ] **Plataformas móviles** funcionando
- [ ] **Condición de victoria:** todos los items recolectados muestra menú
- [ ] **Condición de derrota:** vida 0 reinicia
- [ ] **Blueprints comentados** (cajas de comentarios en cada flujo lógico)
- [ ] **Blueprints alineados** (sin nodos desordenados)
- [ ] **Comunicación con Cast To** (no usar GameInstance/PC genérico)
- [ ] **Al menos una función modular** (ej: `VerificarSiEsJugador`)
- [ ] **Build Windows Shipping** generado y testeado en otra máquina
- [ ] **Carpeta del build sin errores** al ejecutar el `.exe`

---

## 🚨 ERRORES COMUNES A PREVENIR (vistos en clase)

1. **Bala "lleva volando" al jugador en vez de dañar:** OnBeginOverlap conectado al StaticMesh en vez de la SphereCollision
2. **Bala no aparece al disparar:** Collision Handling Override = `NoCollisionFail` (default). DEBE ser `AlwaysSpawn`
3. **Volumen de daño no detecta al jugador:** Collision Preset incorrecto. Debe permitir Overlap con Pawn + Generate Overlap Events activado
4. **Vida no se restaura al reiniciar:** GameInstance no resetea variables automáticamente. Setear `Vida = 100` manualmente al reiniciar
5. **HUD no muestra cambios:** falta el flujo GI → PC → HUD. No conectar GI directo al HUD
6. **ProgressBar se ve mal:** la barra va de 0-1, no 0-100. SetPercent(Vida/100)
7. **Verificación de jugador con Function en vez de Macro:** las funciones no permiten múltiples salidas. Usar Macro o `GetPlayerCharacter == OtherActor`
8. **Cinemática vuelve al estado original:** falta `When Finished = Keep State` en la sección del Sequencer
9. **Trigger de cinemática se vuelve a disparar:** falta `DestroyActor` sobre el trigger después del primer overlap

---

## 💬 CÓMO DEBERÍAS RESPONDER

### Cuando el usuario pide algo concreto:
1. **Identificá** qué clase Core / Blueprint afecta
2. **Generá** los scripts/archivos automatizables PRIMERO
3. **Especificá** los pasos exactos en el editor (componentes, nodos, conexiones) con nombres de variables y tipos
4. **Adelantate**: si necesita algo upstream/downstream, alertá

### Cuando hay ambigüedad:
- Asumí lo que hace el profesor en clase (Blueprints puros, Kenney Platformer Kit, casting explícito)
- Si la decisión cambia la arquitectura, **preguntá una sola vez** antes de avanzar

### Formato de respuestas para Blueprints:
Usá este template:
```
### BP_NombreDelBlueprint

**Componentes:**
- Componente1 (Tipo) [como Root]
- Componente2 (Tipo)

**Variables:**
| Nombre | Tipo | Default | Instance Editable | Expose on Spawn |
|--------|------|---------|-------------------|-----------------|

**Lógica (Event/Function/Macro):**
1. Paso 1...
2. Paso 2...

**Comentario sugerido:** "Descripción para la caja de comentario"
```

---

## 📚 REFERENCIAS

- Transcripts de clase analizados: Semanas 10, 11, 12, 13, 14
- Plataforma de assets: kenney.nl/assets/platformer-kit
- Sonidos: freesound.org
- Documentación oficial Unreal Blueprints: docs.unrealengine.com/5.4/en-US/blueprints-visual-scripting-in-unreal-engine/

---

**Fin del contexto. Procedé según la consulta del usuario.**
