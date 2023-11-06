# Script que confirma los cambios de un repositorio local (de git) y los envía a un repositorio 
# remoto (en GitHub) de forma semanal, mostrando la cantidad de lineas modificadas.
# De no haber cambios se le notifica al usuario.

repositorio_remoto="git@github.com:alfopisano/obligatorio2.git"

# Cambiar al directorio del repositorio local
cd /Users/apisano/obligatorio2
git pull

# Realizar una comprobación para ver si hay cambios pendientes
if [ "$(git status --porcelain)" != "" ]; then
    # Calcular la cantidad de líneas modificadas
    lineas_modificadas=$(git diff --shortstat HEAD~1..HEAD | awk '{print "líneas añadidas " $4 ",", "líneas borradas " $6 ",", "total " $4 + $6}')

    # Actualizar el archivo README.md
   (echo; echo "Cambios commit $(date +'%Y-%m-%d %H:%M:%S'): $lineas_modificadas") >> README.md

    # Enviar los cambios al repositorio remoto
    git add .
    git commit -m "Commit semanal $(date +'%Y-%m-%d %H:%M:%S')"
    git push $repositorio_remoto

    echo "Cambios confirmados y enviados al repositorio remoto. Cambios realizados: $lineas_modificadas"
else
    echo "No hay cambios pendientes para confirmar."
fi