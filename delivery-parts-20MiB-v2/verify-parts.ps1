$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$manifestPath = Join-Path $root 'PARTS-SHA256SUMS.txt'
$combinedManifestPath = Join-Path $root 'ARCHIVE-SHA256.txt'

$entries = Get-Content -LiteralPath $manifestPath | Where-Object { $_.Trim() } | ForEach-Object {
  if ($_ -notmatch '^([a-f0-9]{64})  (.+)$') { throw "Invalid checksum line: $_" }
  [PSCustomObject]@{ Hash = $Matches[1]; Name = $Matches[2] }
}

if ($entries.Count -ne 31) { throw "Expected 31 parts, found $($entries.Count)." }

foreach ($entry in $entries) {
  $file = Join-Path $root $entry.Name
  if (-not (Test-Path -LiteralPath $file -PathType Leaf)) { throw "Missing part: $($entry.Name)" }
  $actual = (Get-FileHash -LiteralPath $file -Algorithm SHA256).Hash.ToLower()
  if ($actual -ne $entry.Hash) { throw "Checksum failed: $($entry.Name)" }
  Write-Host "PASS: $($entry.Name)"
}

$combinedLine = Get-Content -LiteralPath $combinedManifestPath | Where-Object { $_.Trim() } | Select-Object -First 1
if ($combinedLine -notmatch '^([a-f0-9]{64})  (.+)$') { throw 'Invalid archive checksum file.' }
$expectedCombined = $Matches[1]

$sha = [Security.Cryptography.SHA256]::Create()
$buffer = New-Object byte[] (4MB)
try {
  foreach ($entry in $entries) {
    $stream = [IO.File]::OpenRead((Join-Path $root $entry.Name))
    try {
      while (($read = $stream.Read($buffer, 0, $buffer.Length)) -gt 0) {
        [void]$sha.TransformBlock($buffer, 0, $read, $null, 0)
      }
    }
    finally {
      $stream.Dispose()
    }
  }
  [void]$sha.TransformFinalBlock([byte[]]::new(0), 0, 0)
  $actualCombined = ([BitConverter]::ToString($sha.Hash)).Replace('-', '').ToLower()
}
finally {
  $sha.Dispose()
}

if ($actualCombined -ne $expectedCombined) { throw "Archive checksum failed: $actualCombined" }
Write-Host "PASS: all 31 parts and combined archive SHA256 $actualCombined" -ForegroundColor Green
