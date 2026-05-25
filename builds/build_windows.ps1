# =============================================================================
# build_windows.ps1 — Empaqueta el proyecto a Windows 64-bit Shipping
# =============================================================================
# Uso: PowerShell (como administrador o no)
#   cd C:\UE5\TPFinal
#   .\builds\build_windows.ps1
# =============================================================================

# --- CONFIGURACIÓN ----------------------------------------------------------
# Ajustá la versión de Unreal según la que tengas instalada (5.3, 5.4, etc.)
$UE_VERSION = "5.4"
$UE_INSTALL_DIR = "C:\Program Files\Epic Games\UE_$UE_VERSION"
$PROJECT_NAME = "TPFinal"

# Paths derivados
$UAT_PATH = "$UE_INSTALL_DIR\Engine\Build\BatchFiles\RunUAT.bat"
$PROJECT_PATH = "$PSScriptRoot\..\$PROJECT_NAME.uproject"
$OUTPUT_PATH = "$PSScriptRoot\Windows"

# --- VALIDACIONES -----------------------------------------------------------
Write-Host "==============================================" -ForegroundColor Cyan
Write-Host "  BUILD WINDOWS — TP Final Plataformero" -ForegroundColor Cyan
Write-Host "==============================================" -ForegroundColor Cyan

if (-not (Test-Path $UAT_PATH)) {
    Write-Host "[ERROR] No se encontró Unreal en: $UE_INSTALL_DIR" -ForegroundColor Red
    Write-Host "  Editá la variable `$UE_VERSION en este script." -ForegroundColor Yellow
    exit 1
}

if (-not (Test-Path $PROJECT_PATH)) {
    Write-Host "[ERROR] No se encontró el .uproject en: $PROJECT_PATH" -ForegroundColor Red
    exit 1
}

# Resolver path absoluto
$PROJECT_PATH = (Resolve-Path $PROJECT_PATH).Path

Write-Host "Proyecto:  $PROJECT_PATH" -ForegroundColor Green
Write-Host "Output:    $OUTPUT_PATH" -ForegroundColor Green
Write-Host "Engine:    $UE_INSTALL_DIR" -ForegroundColor Green
Write-Host ""

# --- LIMPIAR BUILD ANTERIOR -------------------------------------------------
if (Test-Path $OUTPUT_PATH) {
    Write-Host "Limpiando build anterior..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $OUTPUT_PATH
}

# --- EMPAQUETAR -------------------------------------------------------------
Write-Host "Iniciando build (esto puede tardar 15-30 minutos)..." -ForegroundColor Cyan
Write-Host ""

& $UAT_PATH BuildCookRun `
    -project="$PROJECT_PATH" `
    -noP4 `
    -platform=Win64 `
    -clientconfig=Shipping `
    -serverconfig=Shipping `
    -cook `
    -allmaps `
    -build `
    -stage `
    -pak `
    -archive `
    -archivedirectory="$OUTPUT_PATH" `
    -utf8output

# --- RESULTADO --------------------------------------------------------------
if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "  BUILD COMPLETADO CON ÉXITO" -ForegroundColor Green
    Write-Host "==============================================" -ForegroundColor Green
    Write-Host "Ubicación: $OUTPUT_PATH\Windows" -ForegroundColor Green
    Write-Host ""
    Write-Host "Para probar:" -ForegroundColor Cyan
    Write-Host "  cd `"$OUTPUT_PATH\Windows`"" -ForegroundColor White
    Write-Host "  .\$PROJECT_NAME.exe" -ForegroundColor White
} else {
    Write-Host ""
    Write-Host "==============================================" -ForegroundColor Red
    Write-Host "  BUILD FALLÓ (exit code: $LASTEXITCODE)" -ForegroundColor Red
    Write-Host "==============================================" -ForegroundColor Red
    Write-Host "Revisá los logs arriba para encontrar el error." -ForegroundColor Yellow
    exit $LASTEXITCODE
}
