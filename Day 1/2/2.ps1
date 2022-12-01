$input = 'input.txt'

#Create temporary directory and copy input file
mkdir temp_files | Out-Null
Copy-Item $input .\temp_files

#Split input into multiple files
Set-Location .\temp_files
If (Test-Path $input){
    $File = Get-Item $input
    (Get-Content $File.FullName -Raw) -Split "(?<=`r?`n *`r?`n)" |
        ForEach-Object {$i=1}{
            $_ | Set-Content ("{0}_{1}{2}" -f $File.BaseName,$i++,$File.Extension)
        }
}

#Change directory and remove input file
Set-Location ..
$tempinput = '.\temp_files\' + $input
Remove-Item $tempinput

#Calculate finalist files
Get-ChildItem -path .\temp_files\*.txt | ForEach-Object {
    $calories = Get-Content -Path $_.PSPath | Measure-Object -Sum | Select-Object -ExpandProperty sum
    if ($calories -gt $1stcalories) {
        $3thcalories = $2ndcalories
        $2ndcalories = $1stcalories
        $1stcalories = $calories
    }
    if (($calories -gt $2ndcalories) -and ($calories -lt $1stcalories)) {
        $3thcalories = $2ndcalories
        $2ndcalories = $calories
    }
    if (($calories -gt $3thcalories) -and ($calories -lt $2ndcalories)) {
        $3thcalories = $calories
    }
}

#Calculate total number
$combinedcalories = $1stcalories + $2ndcalories + $3thcalories

#Output finalist and max numbers
Write-Host 'Most calories:' $1stcalories
Write-Host 'Second most calories:' $2ndcalories
Write-Host 'Third most calories:' $3thcalories
Write-Host 'Combined:' $combinedcalories

#Remove temp files and variables
Remove-Item -recurse .\temp_files
Remove-Variable * -ErrorAction SilentlyContinue