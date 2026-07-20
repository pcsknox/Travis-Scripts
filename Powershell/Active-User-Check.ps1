$raw = (query user 2>$null) -join "`n"
$hasUserSession = ($raw -like '*Active*')
$hasUserSession