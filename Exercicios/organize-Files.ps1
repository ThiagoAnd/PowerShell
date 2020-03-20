#Naõ testado Udemy


#Parameters
#The script should take 2 arguments $source and $destination (for the source and destination folders).
param([string]$source="c:\temp",[string]$destination="c:\temp\destination")

#Functions
#2)	Functions

#Create a function named CheckFolder that checks for the existence of a specific directory/folder that is passed 
#to it as a parameter. Also, include a switch parameter named create. If the directory/folder does not exist and 
#the create switch is specified, a new folder should be created using the name of the folder/directory that was 
#passed to the function.
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
   

#Create a function named DisplayFolderStatistics to display folder statistics for a directory/path that is passed 
#to it. Output should include the name of the folder, number of files in the folder, and total size of all files in 
#that directory.

function Display-FolderStats([string]$path){
#Recebe todo os arquivos, e os arquivos das pastas que estão dentro
$files = dir $path -Recurse  | where {!$_.PSIsContainer}
#Retorna a contagem dos arquivos e mais a soma do tamanho deles
$totals = $files | Measure-Object -property length -Sum
$stats = "" | select path,count,size
$stats.path =$path
$stats.count = $totals.Count
$stats.size = [math]::Round($totals.Sum/1mb,2)

return $stats
}






#3)	Main processing

#a) Test for existence of the source folder (using the CheckFolder function).

$sourceexists = Check-Folder $source

if (!$sourceexists){
    Write-Host "O diretorio não existe. O script não pode continuar."
    Exit
}


#b) Test for the existence of the destination folder; create it if it is not found (using the CheckFolder function 
#with the –create switch).Write-Host "Testing Destination Directory - $destination"
$destinationexists = Check-Folder $destination - create
if(!$destinationexists){
    Write-Host "O diretorio de destino não existe. O script não pode continuar."
    Exit
}

#c) Copy each file to the appropriate destination.
#get all the files that need to be copied
$files = dir $source -Recurse | where {!$_.PSIsContainer}



#c-i) Display a message when copying a file. The message should list where the file is being
#moved from and where it is being moved to.

#iterando cada arquivo de $files
foreach ($file in $files){
    #Tirou a extensao.. exemplo arquivo.jpg,.xml.. etc...
    $extension = $file.Extension.Replace(".","")

     #Aqui os diretorios estarao com as extensoes. Ex temp\destination\txt..destination\html...
    $extensionDestDirectory = "$destination\$extension"
   $extensionDestDirectory
  

    #Check se a pasta existe, se não ele cria
    $extDestDirExists = Check-Folder $extensionDestDirectory -create
    if(!$extDestDirExists){
        Write-Host "O diretorio de destino ($extensionDestDirectory) não pode ser criado. O script não pode continuar."
        Exit
    }
    #copy file
    copy $file.fullname $extensionDestDirectory

}



#d) Display each target folder name with the file count and byte count for each folder.

#Onde os diretorios são pastas
$dirs = dir $destination | where {$_.PSIsContainers}

#criar um array vazio
$allstats = @()


foreach ($dir in $dirs){
    $allstats += Display-FolderStats $dir.FullName

}

#Mostrando de forma ordenada
$allstats | sort size -Descending