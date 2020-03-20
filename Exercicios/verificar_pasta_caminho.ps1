#Para chamar: arquivo.ps1 PARAMETRO(Path)


#Parametros
param([string]$dir)


#Function
function get-dirInfo($dir){


   $results = Get-ChildItem $dir -Recurse | Measure-Object -property length -sum
   $espaco = +[math]::Round(($results).sum/1mb,2)
   $cp = "MB"

   if($espaco -gt 999){
       $espaco = +[math]::Round(($results).sum/1gb,2)
       $cp = "GB"
   }

    ""
    "Espaco usado: "+$espaco+" "+$cp
    "Quantidade de arquivos: "+($results).count

     if(($espaco -gt 500) -and ($cp = "MB")){

        "Voce guarda muitos arquivos na pasta"

     }

     if(($espaco -gt 2) -and ($cp = "GB")){

        "Voce guarda muitos arquivos na pasta"

     }

    

     if($results.Count -gt 10){
     ""
     "Maiores arquivos do diretorio: "
   
     Get-ChildItem $dir | sort length -descending | format-table -Property name,length | select -First 10

         
     }
     ""
     "Consulta feita em: "+(Get-Date -Format "dddd MM/dd/yyyy HH:mm K")

}
$caminho =$env:username

#Main process
get-dirInfo $dir