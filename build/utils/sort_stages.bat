@@:: This prolog allows a PowerShell script to be embedded in a .CMD file.
@@:: Any non-PowerShell content must be preceeded by "@@"
@@setlocal
@@pushd "%~dp0"
@@set POWERSHELL_BAT_ARGS=%*
@@if defined POWERSHELL_BAT_ARGS set POWERSHELL_BAT_ARGS=%POWERSHELL_BAT_ARGS:"=\"%
@@PowerShell -Command Invoke-Expression $('$args=@(^&{$args} %POWERSHELL_BAT_ARGS%);'+[String]::Join([char]10,$((Get-Content '%~nx0') -notmatch '^^@@'))) & goto :EOF

$inputFile = '..\..\src\Stages.asm';
if(![System.IO.File]::Exists($inputFile)) {echo "File not found: $inputFile" ; exit}
$lines = Get-Content $inputFile;
$startProcessing = $false;
$entries = @();

foreach ($line in $lines) {
    if ($line -match '// Add stages here') {
        $startProcessing = $true;
        continue;
    }

    if ($startProcessing -and ($line -match 'add_stage\(.*".*".*\)')) {
        $title = '';
        if ($line -match '".*?"') {
            $title = $matches[0].Trim('"'); # Extract and clean the title
        }
        $entries += [PSCustomObject]@{
            Line = $line;
            Title = $title;
        }
    }
}

# Sort entries alphabetically by Title
$sortedEntries = $entries | Sort-Object Title;

$output = @();

foreach ($line in $lines) {
    $entry = $sortedEntries | Where-Object { $_.Line -eq $line };
    if ($entry) {
        # Use the index in sortedEntries as the order
        $index = [array]::IndexOf($sortedEntries, $entry);
        $order = $index + 1; # Convert zero-based index to one-based
        $line = $line -replace ',\s*\d+\)$', ", $order)";
    }
    $output += $line;
}

$output | Set-Content $inputFile;
Write-Host 'Done! The file has been updated with alphabetical order values.';