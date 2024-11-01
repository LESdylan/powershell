# Paramètres
param (
    [string]$dbFilePath, # Chemin vers votre fichier .db
    [string]$outputFilePath  # Chemin vers le fichier SQL de sortie
)
sqlite3 $dbFilePath .dump > $outputFilePath
