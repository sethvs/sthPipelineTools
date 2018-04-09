Remove-Module -Name sthPipelineTools -Force -ErrorAction 'SilentlyContinue'
# . "$PSScriptRoot\..\sthPipelineParameter.ps1"
Import-Module "$PSScriptRoot\..\sthPipelineTools.psd1"

describe 'Get-sthPipelineParameter' {
    function Test-inElement
    {
        Param($Property, $Value)
        if ($Property -eq 'ParameterType')
        {
            $element.$Property.FullName | Should -Be $Value
        }
        else
        {
            $element.$Property | should -Be $Value
        }
    }

    context 'Using Named Parameters' {

        context 'Supplying Get-CimInstance [CmdletInfo] object' {
            
            $command = Get-Command -Name Get-CimInstance
            $result = Get-sthPipelineParameter -Command $command
            
            it 'Elements of Result should be based on type System.Management.Automation.PSCustomObject' {
                $result[0] | should -BeOfType [System.Management.Automation.PSCustomObject]
            }

            it 'Elements of Result should be of type sth.PipelineParameter' {
                $result[0].pstypenames[0] | should -Be 'sth.PipelineParameter'
            }
            
            context 'Testing parameter "ClassName" in ParameterSet "ClassNameComputerSet (IsDefault)"' {
                $element = $result | Where-Object -FilterScript {$_.ParameterName -match 'ClassName' -and  $_.ParameterSet -match 'ClassNameComputerSet'}

                it '<Property> property should be <Value>' -TestCases @(
                    @{Property = 'Command'; Value = 'Get-CimInstance'}
                    @{Property = 'ParameterName'; Value = 'ClassName'}
                    @{Property = 'Aliases'; Value = $null}
                    @{Property = 'AliasesString'; Value = ""}
                    @{Property = 'ParameterType'; Value = "System.String"}
                    @{Property = 'ParameterSet'; Value = 'ClassNameComputerSet (IsDefault)'}
                    @{Property = 'Mandatory'; Value = $true}
                    @{Property = 'ByValue'; Value = $false}
                    @{Property = 'ByPropertyName'; Value = $true}
                )   {
                    Test-inElement @args
                }
            }
        }

        context 'Supplying Get-Verb [FunctionInfo] object' {
            
            $function = Get-Command -Name Get-Verb
            $result = Get-sthPipelineParameter -Command $function
            
            it 'Elements of Result should be based on type System.Management.Automation.PSCustomObject' {
                $result[0] | should -BeOfType [System.Management.Automation.PSCustomObject]
            }

            it 'Elements of Result should be of type sth.PipelineParameter' {
                $result[0].pstypenames[0] | should -Be 'sth.PipelineParameter'
            }

            context 'Testing parameter "verb" in ParameterSet "__AllParameterSets"' {
                $element = $result

                it '<Property> property should be <Value>' -TestCases @(
                    @{Property = 'Command'; Value = 'Get-Verb'}
                    @{Property = 'ParameterName'; Value = 'verb'}
                    @{Property = 'Aliases'; Value = $null}
                    @{Property = 'AliasesString'; Value = ""}
                    @{Property = 'ParameterType'; Value = "System.String[]"}
                    @{Property = 'ParameterSet'; Value = '__AllParameterSets'}
                    @{Property = 'Mandatory'; Value = $false}
                    @{Property = 'ByValue'; Value = $true}
                    @{Property = 'ByPropertyName'; Value = $false}
                )   {
                    Test-inElement @args
                }
            }
        }
    
        context 'Supplying gcim [AliasInfo] object' {
            
            $alias = Get-Command -Name gcim
            $result = Get-sthPipelineParameter -Command $alias
            
            it 'Elements of Result should be based on type System.Management.Automation.PSCustomObject' {
                $result[0] | should -BeOfType [System.Management.Automation.PSCustomObject]
            }

            it 'Elements of Result should be of type sth.PipelineParameter' {
                $result[0].pstypenames[0] | should -Be 'sth.PipelineParameter'
            }
            
            context 'Testing parameter "ClassName" in ParameterSet "ClassNameComputerSet (IsDefault)"' {
                $element = $result | Where-Object -FilterScript {$_.ParameterName -match 'ClassName' -and  $_.ParameterSet -match 'ClassNameComputerSet'}

                it '<Property> property should be <Value>' -TestCases @(
                    @{Property = 'Command'; Value = 'Get-CimInstance'}
                    @{Property = 'ParameterName'; Value = 'ClassName'}
                    @{Property = 'Aliases'; Value = $null}
                    @{Property = 'AliasesString'; Value = ""}
                    @{Property = 'ParameterType'; Value = "System.String"}
                    @{Property = 'ParameterSet'; Value = 'ClassNameComputerSet (IsDefault)'},    
                    @{Property = 'Mandatory'; Value = $true},
                    @{Property = 'ByValue'; Value = $false},
                    @{Property = 'ByPropertyName'; Value = $true}
                )   {
                    Test-inElement @args
                }
            }
        }

        context 'Supplying Get-CimInstance [String] object' {
            
            $result = Get-sthPipelineParameter -Command 'Get-CimInstance'
            
            it 'Elements of Result should be based on type System.Management.Automation.PSCustomObject' {
                $result[0] | should -BeOfType [System.Management.Automation.PSCustomObject]
            }

            it 'Elements of Result should be of type sth.PipelineParameter' {
                $result[0].pstypenames[0] | should -Be 'sth.PipelineParameter'
            }
            
            context 'Testing parameter "ClassName" in ParameterSet "ClassNameComputerSet (IsDefault)"' {
                $element = $result | Where-Object -FilterScript {$_.ParameterName -match 'ClassName' -and  $_.ParameterSet -match 'ClassNameComputerSet'}

                it '<Property> property should be <Value>' -TestCases @(
                    @{Property = 'Command'; Value = 'Get-CimInstance'}
                    @{Property = 'ParameterName'; Value = 'ClassName'}
                    @{Property = 'Aliases'; Value = $null}
                    @{Property = 'AliasesString'; Value = ""}
                    @{Property = 'ParameterType'; Value = "System.String"}
                    @{Property = 'ParameterSet'; Value = 'ClassNameComputerSet (IsDefault)'}
                    @{Property = 'Mandatory'; Value = $true}
                    @{Property = 'ByValue'; Value = $false}
                    @{Property = 'ByPropertyName'; Value = $true}
                )   {
                    Test-inElement @args
                }
            }
        }
        
        context 'Supplying gcim [String] object' {
            
            $result = Get-sthPipelineParameter -Command 'gcim'
            
            it 'Elements of Result should be based on type System.Management.Automation.PSCustomObject' {
                $result[0] | should -BeOfType [System.Management.Automation.PSCustomObject]
            }

            it 'Elements of Result should be of type sth.PipelineParameter' {
                $result[0].pstypenames[0] | should -Be 'sth.PipelineParameter'
            }
            
            context 'Testing parameter "ClassName" in ParameterSet "ClassNameComputerSet (IsDefault)"' {
                $element = $result | Where-Object -FilterScript {$_.ParameterName -match 'ClassName' -and  $_.ParameterSet -match 'ClassNameComputerSet'}

                it '<Property> property should be <Value>' -TestCases @(
                    @{Property = 'Command'; Value = 'Get-CimInstance'}
                    @{Property = 'ParameterName'; Value = 'ClassName'}
                    @{Property = 'Aliases'; Value = $null}
                    @{Property = 'AliasesString'; Value = ""}
                    @{Property = 'ParameterType'; Value = "System.String"}
                    @{Property = 'ParameterSet'; Value = 'ClassNameComputerSet (IsDefault)'}
                    @{Property = 'Mandatory'; Value = $true}
                    @{Property = 'ByValue'; Value = $false}
                    @{Property = 'ByPropertyName'; Value = $true}
                )   {
                    Test-inElement @args
                }
            }
        }
        
        context 'Supplying NonExistent-Command [String] object' {
            
            $result = Get-sthPipelineParameter -Command 'NonExistent-Command'
            
            it 'Result should contain "`nCommands not found:"' {
                $result | should -Contain "`nCommands not found:"
            }
            
            it 'Result should contain NonExistent-Command' {
                $result | should -Contain 'NonExistent-Command'
            }
        }

        context 'Supplying NonExistent-Command [String] object with -HideNotFoundCommands parameter' {
        
            $result = Get-sthPipelineParameter -Command 'NonExistent-Command' -HideNotFoundCommands
            
            it 'Result should not contain "`nCommands not found:"' {
                $result | should -Not -Contain "`nCommands not found:" -Because "because -HideNotFoundCommands was used"
            }
            
            it 'Result should not contain NonExistent-Command' {
                $result | should -Not -Contain 'NonExistent-Command'  -Because "because -HideNotFoundCommands was used"
            }
        }

        context 'Supplying [Process] object' {
            $process = Get-Process | Select-Object -First 1
            $result = Get-sthPipelineParameter -Command $process

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
            $result = Get-sthPipelineParameter $command
            
            it 'Elements of Result should be based on type System.Management.Automation.PSCustomObject' {
                $result[0] | should -BeOfType [System.Management.Automation.PSCustomObject]
            }

            it 'Elements of Result should be of type sth.PipelineParameter' {
                $result[0].pstypenames[0] | should -Be 'sth.PipelineParameter'
            }
            
            context 'Testing parameter "ClassName" in ParameterSet "ClassNameComputerSet (IsDefault)"' {
                $element = $result | Where-Object -FilterScript {$_.ParameterName -match 'ClassName' -and  $_.ParameterSet -match 'ClassNameComputerSet'}

                it '<Property> property should be <Value>' -TestCases @(
                    @{Property = 'Command'; Value = 'Get-CimInstance'}
                    @{Property = 'ParameterName'; Value = 'ClassName'}
                    @{Property = 'Aliases'; Value = $null}
                    @{Property = 'AliasesString'; Value = ""}
                    @{Property = 'ParameterType'; Value = "System.String"}
                    @{Property = 'ParameterSet'; Value = 'ClassNameComputerSet (IsDefault)'}
                    @{Property = 'Mandatory'; Value = $true}
                    @{Property = 'ByValue'; Value = $false}
                    @{Property = 'ByPropertyName'; Value = $true}
                )   {
                    Test-inElement @args
                }
            }
        }
    }

    context 'Using pipeline' {

        context 'Supplying [CmdletInfo] (Get-CimInstance), [FunctionInfo] (Get-Verb), [AliasInfo] (gps), "Get-PSDrive" and "gsv" objects' {

            $command = Get-Command -Name Get-CimInstance
            $function = Get-Command -Name Get-Verb
            $alias = Get-Command -Name gps
            $result = $command, $function, $alias, 'Get-PSDrive', 'gsv' | Get-sthPipelineParameter
            
            it 'Elements of Result should be based on type System.Management.Automation.PSCustomObject' {
                $result[0] | should -BeOfType [System.Management.Automation.PSCustomObject]
            }

            it 'Elements of Result should be of type sth.PipelineParameter' {
                $result[0].pstypenames[0] | should -Be 'sth.PipelineParameter'
            }
            
            # it 'Command <Command> Parameter <ParameterName> Aliases <Aliases> AliasesCount <AliasesCount> AliasesString <AliasesString> ParameterSet <ParameterSet> should be: <Command>, <SupportsPipeline>' -TestCases @(
            it 'Entry should exist: Command: <Command> Parameter: <ParameterName> Aliases: <Aliases> AliasesCount: <AliasesCount> AliasesString: <AliasesString> ParameterType: <ParameterType> ParameterSet: <ParameterSet> Mandatory: <Mandatory> ByValue: <ByValue> ByPropertyName :<ByPropertyName>' -TestCases @(
            @{Command = 'Get-CimInstance'; ParameterName = 'ClassName'; Aliases = $null; AliasesCount = 0; AliasesString = ""; ParameterType = 'System.String'; ParameterSet = 'ClassNameComputerSet (IsDefault)'; Mandatory = $true; ByValue = $false; ByPropertyName = $true},
            @{Command = 'Get-Verb'; ParameterName = 'verb'; Aliases = $null; AliasesCount = 0; AliasesString = ""; ParameterType = 'System.String[]'; ParameterSet = '__AllParameterSets'; Mandatory = $false; ByValue = $true; ByPropertyName = $false},
            @{Command = 'Get-Process'; ParameterName = 'Name'; Aliases = 'ProcessName'; AliasesCount = 1; AliasesString = 'ProcessName'; ParameterType = 'System.String[]'; ParameterSet = 'Name (IsDefault)'; Mandatory = $false; ByValue = $false; ByPropertyName = $true},
            @{Command = 'Get-PSDrive'; ParameterName = 'Name'; Aliases = $null; AliasesCount = 0; AliasesString = ""; ParameterType = 'System.String[]'; ParameterSet = 'Name (IsDefault)'; Mandatory = $false; ByValue = $false; ByPropertyName = $true},
            @{Command = 'Get-Service'; ParameterName = 'Name'; Aliases = 'ServiceName'; AliasesCount = 1; AliasesString = 'ServiceName'; ParameterType = 'System.String[]'; ParameterSet = 'Default (IsDefault)'; Mandatory = $false; ByValue = $true; ByPropertyName = $true}
            )   {
                Param($Command,$ParameterName,$Aliases,$AliasesCount,$AliasesString,$ParameterType,$ParameterSet,$Mandatory,$ByValue,$ByPropertyName)
                $element = $result | Where-Object -FilterScript {$_.Command -eq $Command -and $_.ParameterName -eq $ParameterName -and  $_.ParameterSet -eq $ParameterSet}
                
                $element.Command | should -Be $Command
                $element.ParameterName | should -Be $ParameterName
                $element.Aliases | Should -Contain $Aliases
                $element.Aliases.Count | Should -Be $AliasesCount
                $element.AliasesString | Should -Be $AliasesString
                $element.ParameterType.FullName | should -Be $ParameterType
                $element.ParameterSet | should -Be $ParameterSet
                $element.Mandatory | should -Be $Mandatory
                $element.ByValue | should -Be $ByValue
                $element.ByPropertyName | should -Be $ByPropertyName
            }
        }
    }
            
    context 'Testing Aliases' {
        $result = Get-sthPipelineParameter -Command Restart-Computer

        it 'Testing Aliases property' {
            $result.Aliases | Should -Be 'CN', '__SERVER', 'Server', 'IPAddress'
            $result.Aliases | Should -HaveCount 4
        }

        it 'Testing AliasesString property' {
            $result.AliasesString | Should -Be 'CN, __SERVER, Server, IPAddress'
            $result.AliasesString | Should -BeOfType [System.String]
        }
    }

    context 'Invoking function without parameters' {
        
        $result = Get-sthPipelineParameter
        
        it 'Return should be $null' {
            $result | Should -BeNullOrEmpty
        }
    }
}
