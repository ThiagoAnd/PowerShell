#Cria um diretorio
#o 'create' é uma flag, se usar na chamada da função ele faz o check e ja cria, se não só retorna true ou false da existencia
#do diretorio

function Check-Folder([string]$path,[switch]$create){
 #Verificar se o caminho existe
 $exists = Test-Path $path   

 if(!$exists -and $create){
    #Cria o diretorio
    mkdir $path
    Write-host "Nao existe mas sera criado"
    #Cria o diretorio
    mkdir $path
    $exists = Test-Path $path
    Write-host "O diretorio foi criado"
 }
 return $exists

}
   
Check-Folder "c:\temp" -create