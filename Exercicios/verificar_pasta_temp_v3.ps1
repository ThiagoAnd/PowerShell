function get-dirInfo($dir){

   $results = Get-ChildItem $dir -Recurse | Measure-Object -property length -sum
   $espaco = +[math]::Round(($results).sum/1mb,2)

    "Espaco usado: "+$espaco+" MB. "
    "Quantidade de arquivos: "+($results).count

     if($espaco -gt 500){

        "Voce guarda muitos arquivos na pasta temp"

     }

     if(($espaco -lt 500) -and ($espaco -gt 0)){
     "Sua pasta temp esta praticamente vazia"
     }

     if($results.Count > 10){
     Get-ChildItem C:\temp | format-table

         
     }
     "Consulta feita em: "+(Get-Date -Format "dddd MM/dd/yyyy HH:mm K")

}

get-dirInfo C:\temp\


