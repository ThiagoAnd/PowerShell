function Display-FolderStats([string]$path){
#Recebe todo os arquivos, e os arquivos das pastas que estão dentro
$files = dir $path -Recurse 
#Retorna a contagem dos arquivos e mais a soma do tamanho deles
$totals = $files | Measure-Object -property length -Sum
$stats = "" | select path,count,size
$stats.path =$path
$stats.count = $totals.Count
$stats.size = [math]::Round($totals.Sum/1mb,2)

return $stats
}

Display-FolderStats "c:\temp"