function Display-FolderStats([string]$path){
#Recebe todo os arquivos, e os arquivos das pastas que estão dentro
$files = dir $path -Recurse 
#Retorna a contagem dos arquivos e mais a soma do tamanho deles
return $files | Measure-Object -property length -Sum
}

Display-FolderStats "c:\temp"