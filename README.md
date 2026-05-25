# TP Final — Juego Plataformero 3D

> Trabajo Final Integrador — Programación de Videojuegos y Animación Digital
> Lic. Federico Garazo

## 📝 Descripción

Juego plataformero 3D desarrollado en **Unreal Engine 5** con Blueprints puros.

### Mecánicas
- **Principales:** Correr, saltar, esquivar obstáculos (cañones con proyectiles), recolectar Items
- **Secundarias:** Recolectar Items de vida
- **Core loop:** Ir del Punto A al Punto B recolectando todos los items
- **Game Over:** Caerse del nivel o quedarse sin vida → reinicio
- **Victoria:** Recolectar todos los items

## 🛠️ Stack técnico

- Unreal Engine 5.x
- Blueprints (sin C++)
- Assets: Kenney Platformer Kit
- Build: Windows 64-bit Shipping

## 📂 Estructura del repo

```
TPFinal/
├── Content/              # (Generado por UE) Blueprints, mapas, assets
├── Config/               # Configuración del proyecto
├── docs/
│   ├── transcripts/      # Material de clase
│   └── screenshots/      # Capturas para el informe
├── builds/               # Builds compiladas para Windows
├── CLAUDE.md             # Contexto para Claude Code
├── README.md             # Este archivo
└── TPFinal.uproject      # Archivo del proyecto
```

## 🚀 Cómo abrir el proyecto

1. Tener Unreal Engine 5.4 instalado
2. Doble click en `TPFinal.uproject`
3. Si pide compilar shaders → esperar (puede tardar ~10 min la primera vez)

## 🎮 Controles

| Tecla | Acción |
|-------|--------|
| WASD | Mover |
| Espacio | Saltar |
| Mouse | Mirar |
| Esc | Pausa |

## 📦 Cómo generar el build final

Desde el editor: `File → Package Project → Windows`

O ejecutar `builds/build_windows.ps1`

## ✅ Estado de cumplimiento de la rúbrica

- [ ] Convenciones de nombres correctas
- [ ] Nivel con diseño interesante
- [ ] Blueprints comentados y alineados
- [ ] Clases Core usadas correctamente
- [ ] Comunicación entre Blueprints (Cast To)
- [ ] Funciones modulares
- [ ] UI muestra vida e items
- [ ] Build de Windows generada
