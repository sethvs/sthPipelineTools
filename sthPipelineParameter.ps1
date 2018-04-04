Using namespace System.Management.Automation

<#
.externalHelp sthPipelineTools.psm1-Help.xml
#>
function Get-sthPipelineParameter
{
    Param(
        [Parameter(ValueFromPipeline)]
        [System.Object[]]$Command,
        [switch]$HideNotFoundCommands
    )

    Begin
    {
        $CommandNotFound = @()
    }

    Process
    {
        foreach ($cmd in $Command)
        {
            if ($cmd.pstypenames -contains 'sth.PipelineCommand')
            {
                if ($cmd.SupportsPipeline -eq $true)
                {
                    $cmd = $cmd.Command
                }
                else
                {
                    continue
                }
            }

            if (($cmd -isnot [string]) -and ($cmd -isnot [CommandInfo]))
            {
                $CommandNotFound += $foreach.current.ToString()
                continue
            }

            if ($cmd -is [string])
            {
                if (!($cmd = Get-Command -Name $cmd -ErrorAction 'SilentlyContinue'))
                {
                    $CommandNotFound += $foreach.current
                }
            }

            if ($cmd -is [AliasInfo])
            {
                $cmd = $cmd.ReferencedCommand
            }
            
            foreach ($parameter in $cmd.Parameters.Values)
            {
                $attributes = $parameter.Attributes | Where-Object {$_.TypeId.Name -eq 'ParameterAttribute'}
                
                if ($attributes.ValueFromPipeline -contains $true -or $attributes.ValueFromPipelineByPropertyName -contains $true)
                {
                    foreach ($a in $attributes)
                    {
                        $ParameterSet = "$($a.ParameterSetName)"
                        if (($cmd.ParameterSets | Where-Object {$_.Name -eq $a.ParameterSetName}).IsDefault)
                        {
                            $ParameterSet += " (IsDefault)"
                        }
                        $hash = [ordered]@{
                            Command = $cmd.Name
                            ParameterName = $parameter.Name
                            ParameterType = $parameter.ParameterType
                            ParameterSet = $ParameterSet
                            Mandatory = $a.Mandatory
                            ByValue = $a.ValueFromPipeline
                            ByPropertyName = $a.ValueFromPipelineByPropertyName
                        }
                        
                        [PSCustomObject]$hash | Add-Member -TypeName 'sth.PipelineParameter' -PassThru
                    }
                }
            }
        }
    }

    End
    {
        if ($CommandNotFound -and (-not $HideNotFoundCommands))
        {
            Write-Output -InputObject "`nCommands not found:"
            $CommandNotFound
        }
    }
}