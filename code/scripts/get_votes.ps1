for ($i=42; $i -gt 0; $i--){ 
    $finalYear = 2018 - (50-$i)*2
    $congress = 115 - (50 - $i)
    for($j=0; $j -lt2; $j++) {
        $session=$finalYear-$j
        Write-Host "Running python run votes --congress=$congress --session=$session"
        python run votes --congress=$congress --session=$session
    }
}