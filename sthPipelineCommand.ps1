Using namespace System.Management.Automation

<#
.externalHelp sthPipelineTools.psm1-Help.xml
#>
function Get-sthPipelineCommand
{
    [CmdletBinding()]
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
                    continue
                }
            }
            
            if ($cmd -is [AliasInfo])
            {
                $cmd = $cmd.ReferencedCommand
            }
            
            $hash = @{
                Command = $cmd.Name
            }
            
            $cmd.Parameters.Values.Attributes | 
            Where-Object {$_.TypeId.Name -eq 'ParameterAttribute'} |
            ForEach-Object {if ($_.ValueFromPipeline -or $_.ValueFromPipelineByPropertyName)
                {
                    $hash.Add('SupportsPipeline',$true)
                    [PSCustomObject]$hash | Add-Member -TypeName 'sth.PipelineCommand' -PassThru
                    continue
                }
            }
            $hash.Add('SupportsPipeline',$false)
            [PSCustomObject]$hash | Add-Member -TypeName 'sth.PipelineCommand' -PassThru
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