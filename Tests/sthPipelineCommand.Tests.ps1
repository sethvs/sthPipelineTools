Remove-Module -Name sthPipelineTools -Force -ErrorAction 'SilentlyContinue'
# . "$PSScriptRoot\..\sthPipelineCommand.ps1"
Import-Module "$PSScriptRoot\..\sthPipelineTools.psd1"

describe 'Get-sthPipelineCommand' {
    
    context 'Using Named Parameters' {

        context 'Supplying Get-CimInstance [CmdletInfo] object' {
            
            $command = Get-Command -Name Get-CimInstance
            $result = Get-sthPipelineCommand -Command $command
            
            it 'Result should be based on type System.Management.Automation.PSCustomObject' {
                $result | should -BeOfType [System.Management.Automation.PSCustomObject]
            }
            
            it 'Result should be of type sth.PipelineCommand' {
                $result.pstypenames[0] | should -Be 'sth.PipelineCommand'
            }
            
            it 'Result.Command should be Get-CimInstance' {
                $result.Command | should -Be 'Get-CimInstance'
            }
            
            it 'Result.SupportsPipeline should be $true' {
                $result.SupportsPipeline | should -BeTrue
            }
        }
        
        context 'Supplying Start-Process [CmdletInfo] object' {
            
            $command = Get-Command -Name Start-Process
            $result = Get-sthPipelineCommand -Command $command
            
            it 'Result should be based on type System.Management.Automation.PSCustomObject' {
                $result | should -BeOfType [System.Management.Automation.PSCustomObject]
            }
            
            it 'Result should be of type sth.PipelineCommand' {
                $result.pstypenames[0] | should -Be 'sth.PipelineCommand'
            }
            
            it 'Result.Command should be Start-Process' {
                $result.Command | should -Be 'Start-Process'
            }
            
            it 'Result.SupportsPipeline should be $false' {
                $result.SupportsPipeline | should -BeFalse
            }
        }
        
        context 'Supplying Get-Verb [FunctionInfo] object' {
            
            $function = Get-Command -Name Get-Verb
            $result = Get-sthPipelineCommand -Command $function
            
            it 'Result should be based on type System.Management.Automation.PSCustomObject' {
                $result | should -BeOfType [System.Management.Automation.PSCustomObject]
            }
            
            it 'Result should be of type sth.PipelineCommand' {
                $result.pstypenames[0] | should -Be 'sth.PipelineCommand'
            }
            
            it 'Result.Command should be Get-Verb' {
                $result.Command | should -Be 'Get-Verb'
            }
            
            it 'Result.SupportsPipeline should be $true' {
                $result.SupportsPipeline | should -BeTrue
            }
        }
        
        context 'Supplying gcim [AliasInfo] object' {
            
            $alias = Get-Command -Name gcim
            $result = Get-sthPipelineCommand -Command $alias
            
            it 'Result should be based on type System.Management.Automation.PSCustomObject' {
                $result | should -BeOfType [System.Management.Automation.PSCustomObject]
            }
            
            it 'Result should be of type sth.PipelineCommand' {
                $result.pstypenames[0] | should -Be 'sth.PipelineCommand'
            }
            
            it 'Result.Command should be Get-CimInstance' {
                $result.Command | should -Be 'Get-CimInstance'
            }
            
            it 'Result.SupportsPipeline should be $true' {
                $result.SupportsPipeline | should -BeTrue
            }
        }
        
        context 'Supplying Get-CimInstance [String] object' {
            
            $result = Get-sthPipelineCommand -Command 'Get-CimInstance'
            
            it 'Result should be based on type System.Management.Automation.PSCustomObject' {
                $result | should -BeOfType [System.Management.Automation.PSCustomObject]
            }
            
            it 'Result should be of type sth.PipelineCommand' {
                $result.pstypenames[0] | should -Be 'sth.PipelineCommand'
            }
            
            it 'Result.Command should be Get-CimInstance' {
                $result.Command | should -Be 'Get-CimInstance'
            }
            
            it 'Result.SupportsPipeline should be $true' {
                $result.SupportsPipeline | should -BeTrue
            }
        }
        
        context 'Supplying gcim [String] object' {
            
            $result = Get-sthPipelineCommand -Command 'gcim'
            
            it 'Result should be based on type System.Management.Automation.PSCustomObject' {
                $result | should -BeOfType [System.Management.Automation.PSCustomObject]
            }
            
            it 'Result should be of type sth.PipelineCommand' {
                $result.pstypenames[0] | should -Be 'sth.PipelineCommand'
            }
            
            it 'Result.Command should be Get-CimInstance' {
                $result.Command | should -Be 'Get-CimInstance'
            }
            
            it 'Result.SupportsPipeline should be $true' {
                $result.SupportsPipeline | should -BeTrue
            }
        }
        
        context 'Supplying NonExistent-Command [String] object' {
            
            $result = Get-sthPipelineCommand -Command 'NonExistent-Command'
            
            it 'Result should contain "`nCommands not found:"' {
                $result | should -Contain "`nCommands not found:"
            }
            
            it 'Result should contain NonExistent-Command' {
                $result | should -Contain 'NonExistent-Command'
            }
        }

        context 'Supplying NonExistent-Command [String] object with -HideNotFoundCommands parameter' {
        
            $result = Get-sthPipelineCommand -Command 'NonExistent-Command' -HideNotFoundCommands
            
            it 'Result should not contain "`nCommands not found:"' {
                $result | should -Not -Contain "`nCommands not found:" -Because "because -HideNotFoundCommands was used"
            }
            
            it 'Result should not contain NonExistent-Command' {
                $result | should -Not -Contain 'NonExistent-Command'  -Because "because -HideNotFoundCommands was used"
            }
        }

        context 'Supplying [Process] object' {
            $process = Get-Process | Select-Object -First 1
            $result = Get-sthPipelineCommand -Command $process

            it 'Result shouls contain "`nCommands not found:"' {
                $result | Should -Contain "`nCommands not found:"
            }
            
            it "Result should contain '$($process.ToString())'" {
                $result | Should -Contain "$($process.ToString())"
            }
        }
    }
        
    context 'Using positional parameters' {

        context 'Supplying Get-CimInstance [CmdletInfo] object' {
            
            $command = Get-Command -Name Get-CimInstance
            $result = Get-sthPipelineCommand $command
            
            it 'Result should be based on type System.Management.Automation.PSCustomObject' {
                $result | should -BeOfType [System.Management.Automation.PSCustomObject]
            }
            
            it 'Result should be of type sth.PipelineCommand' {
                $result.pstypenames[0] | should -Be 'sth.PipelineCommand'
            }
            
            it 'Result.Command should be Get-CimInstance' {
                $result.Command | should -Be 'Get-CimInstance'
            }
            
            it 'Result.SupportsPipeline should be $true' {
                $result.SupportsPipeline | should -BeTrue
            }
        }
    }

    context 'Using pipeline' {

        context 'Supplying [CmdletInfo] (Get-CimInstance), [FunctionInfo] (Get-Verb), [AliasInfo] (gps), "Get-PSDrive" and "gsv" objects' {

            $command = Get-Command -Name Get-CimInstance
            $function = Get-Command -Name Get-Verb
            $alias = Get-Command -Name gps
            $result = $command, $function, $alias, 'Get-PSDrive', 'gsv' | Get-sthPipelineCommand
            
            it 'Result should be based on type System.Management.Automation.PSCustomObject' {
                $result[0] | should -BeOfType -ExpectedType [System.Management.Automation.PSCustomObject]
            }
            
            it 'Result should be of type sth.PipelineCommand' {
                $result[0].pstypenames[0] | should -Be 'sth.PipelineCommand'
            }
            
            it 'Result at position <index> should be: <Command>, <SupportsPipeline>' -TestCases @(
                @{Index = 0; Command = 'Get-CimInstance'; SupportsPipeline = $true},
                @{Index = 1; Command = 'Get-Verb'; SupportsPipeline = $true},
                @{Index = 2; Command = 'Get-Process'; SupportsPipeline = $true},
                @{Index = 3; Command = 'Get-PSDrive'; SupportsPipeline = $true},
                @{Index = 4; Command = 'Get-Service'; SupportsPipeline = $true}
                ) {
                    Param($index,$command,$SupportsPipeline)
                    $result[$index].Command             | Should -Be -ExpectedValue $command
                    $result[$index].SupportsPipeline    | Should -Be -ExpectedValue $SupportsPipeline
                }
            }
        }
            
    context 'Invoking function without parameters' {
        
        $result = Get-sthPipelineCommand
        
        it 'Return should be $null' {
            $result | Should -BeNullOrEmpty
        }
    }
}
