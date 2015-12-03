Function intergateForReportID {
    
    foreach ($line in $logFile) {
        if (($line.contains("ReportID=")) -eq $true) {
        
            if (([Regex]::match($line, 'ReportID=\d{2,3}').success) -eq $true) {
                $report = [Regex]::match($line, 'ReportID=\d{2,3}').value 
            }
            else {
                $report = "Dashboard"
            }
           
        $global:totalReportArray += $report
   
        }
    }
}

$global:totalReportArray = @()

Get-ChildItem "C:\temp\Scripts\Get-ReportUsage\Logs" | foreach { 

    $global:logFile = get-content $_.FullName
    intergateForReportID
    intergateForUsername
    Write-Host $_.Fullname 
    date

}

$totalReportArray | group | Sort-Object -Property Count -Descending | Format-table Count, Name


