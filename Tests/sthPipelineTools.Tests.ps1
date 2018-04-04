Remove-Module -Name sthPipelineTools -Force -ErrorAction 'SilentlyContinue'
. "$PSScriptRoot\..\sthPipelineCommand.ps1"
. "$PSScriptRoot\..\sthPipelineParameter.ps1"

describe 'Get-sthPipelineCommand | Get-sthPipelineParameter' {
    
    context 'Sending Get-Process, Start-Process, Stop-Process' {

        $command = 'Get-Process', 'Start-Process', 'Stop-Process'
        $result = Get-sthPipelineCommand $command | Get-sthPipelineParameter

        it 'Entry should exist: Command: <Command> Parameter: <ParameterName> ParameterType: <ParameterType> ParameterSet: <ParameterSet> Mandatory: <Mandatory> ByValue: <ByValue> ByPropertyName :<ByPropertyName>' -TestCases @(
            @{Command = 'Get-Process'; ParameterName = 'Name'; ParameterType = 'System.String[]'; ParameterSet = 'Name (IsDefault)'; Mandatory = $false; ByValue = $false; ByPropertyName = $true},
            @{Command = 'Stop-Process'; ParameterName = 'Id'; ParameterType = 'System.Int32[]'; ParameterSet = 'Id (IsDefault)'; Mandatory = $true; ByValue = $false; ByPropertyName = $true}
        )   {
            Param($Command,$ParameterName,$ParameterType,$ParameterSet,$Mandatory,$ByValue,$ByPropertyName)
            $element = $result | Where-Object -FilterScript {$_.Command -eq $Command -and $_.ParameterName -eq $ParameterName -and  $_.ParameterSet -eq $ParameterSet}
            
            $element.Command | should -Be $Command
            $element.ParameterName | should -Be $ParameterName
            $element.ParameterType.FullName | should -Be $ParameterType
            $element.ParameterSet | should -Be $ParameterSet
            $element.Mandatory | should -Be $Mandatory
            $element.ByValue | should -Be $ByValue
            $element.ByPropertyName | should -Be $ByPropertyName
        }

        it 'Result should not contain Start-Process' {
            $result.Command | should -Not -Contain 'Start-Process'
        }
    }
}