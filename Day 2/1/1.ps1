$input = Get-Content -Path .\input.txt
$maxpoints = 0
foreach ($game in $input) {
    if ($game -eq 'A Y') {
        $maxpoints = $maxpoints + 8
    }
    if ($game -eq 'A X') {
        $maxpoints = $maxpoints + 4
    }
    if ($game -eq 'A Z') {
        $maxpoints = $maxpoints + 3
    }
    if ($game -eq 'B Y') {
        $maxpoints = $maxpoints + 5
    }
    if ($game -eq 'B X') {
        $maxpoints = $maxpoints + 1
    }
    if ($game -eq 'B Z') {
        $maxpoints = $maxpoints + 9
    }
    if ($game -eq 'C Y') {
        $maxpoints = $maxpoints + 2
    }
    if ($game -eq 'C X') {
        $maxpoints = $maxpoints + 7
    }
    if ($game -eq 'C Z') {
        $maxpoints = $maxpoints + 6
    }  
}
Write-Host 'Points:' $maxpoints