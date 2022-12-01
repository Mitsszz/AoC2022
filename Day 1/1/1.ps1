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

#Calculate file with highest number
Get-ChildItem -path .\temp_files\*.txt | ForEach-Object {
    $calories = Get-Content -Path $_.PSPath | Measure-Object -Sum | Select-Object -ExpandProperty sum
    if ($calories -gt $maxcalories) {
        $maxcalories = $calories
    }
}

#Output highest number
Write-Host 'Max calories' $maxcalories

#Remove temp files and variables
Remove-Item -recurse .\temp_files
Clear-Variable -Name maxcalories