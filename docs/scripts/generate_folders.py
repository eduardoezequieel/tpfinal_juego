"""
generate_folders.py — Crea la estructura de carpetas del proyecto en Content/
Cómo ejecutarlo:
1. Abrir Unreal Editor con el proyecto
2. Edit → Plugins → buscar "Python Editor Script Plugin" → habilitar → reiniciar editor
3. Tools → Execute Python Script → seleccionar este archivo
"""

import unreal

folders = [
    "/Game/Blueprints/Core",
    "/Game/Blueprints/Gameplay",
    "/Game/Blueprints/Plataformas",
    "/Game/Blueprints/Fisicas",
    "/Game/Data/Structures",
    "/Game/Data/DataTables",
    "/Game/Data/Enums",
    "/Game/UI",
    "/Game/Materiales",
    "/Game/Materiales/Instances",
    "/Game/Sonidos",
    "/Game/Sonidos/Waves",
    "/Game/Sonidos/Cues",
    "/Game/VFX",
    "/Game/Cinematicas",
    "/Game/Modelos",
    "/Game/Modelos/Kenney",
    "/Game/Mapas",
]

print("=" * 60)
print("Creando estructura de carpetas del proyecto...")
print("=" * 60)

created = 0
skipped = 0

for folder in folders:
    if unreal.EditorAssetLibrary.does_directory_exist(folder):
        print(f"  [SKIP] Ya existe: {folder}")
        skipped += 1
    else:
        result = unreal.EditorAssetLibrary.make_directory(folder)
        if result:
            print(f"  [OK]   Creada: {folder}")
            created += 1
        else:
            print(f"  [FAIL] No se pudo crear: {folder}")

print("=" * 60)
print(f"Carpetas creadas: {created} | Saltadas (ya existían): {skipped}")
print("=" * 60)
