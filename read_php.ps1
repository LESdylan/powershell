$SourceFile = Read-Host "Share the path of the content you want to allocate"
$content = Get-Content -Path $SourceFile
$destinationFile = "C:\xampp\htdocs\allocated_content.php"

# Bloc try/catch pour vérifier si Set-Content s'est bien passé
try {
    Set-Content -Path $destinationFile -Value $content
    
    Write-Host "the script has successfully written the destination file '$destinationFile'." -ForegroundColor Green
    Write-Host "Vous pouvez accéder à votre fichier PHP en visitant : http://localhost/allocated_content.php" -ForeGroundColor Blue
} catch {
    Write-Host "Une erreur s'est produite lors de l'écriture du fichier." -ForegroundColor Red
}
