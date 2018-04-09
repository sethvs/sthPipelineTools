# sthPipelineTools

**sthPipelineTools** - it is a module containing two functions for working with and exploring PowerShell pipeline.

It contains following functions:

[**Get-sthPipelineCommand**](#get-sthpipelinecommand) - Function checks, whether a specified command supports pipelining.

[**Get-sthPipelineParameter**](#get-sthpipelineparameter) - Function discovers parameters of the specified command, that accept pipeline input and displays their Names, Aliases, Types, Parameter Sets, whether it is a default Parameter Set, whether it is a Mandatory parameter as well as supported methods of accepting pipeline input - ByValue and ByPropertyName.

You can install sthPipelineTools module from PowerShell Gallery:

```
Install-Module sthPipelineTools
```

## How to use it?

### Get-sthPipelineCommand

This command checks, whether Get-Process cmdlet supports pipelining.

```
Get-sthPipelineCommand -Command Get-Process

Command     SupportsPipeline
-------     ----------------
Get-Process             True
```

---

This command checks, whether Get-Verb function supports pipelining.

```
Get-sthPipelineCommand -Command Get-Verb

Command  SupportsPipeline
-------  ----------------
Get-Verb             True
```

---

Command checks, whether Get-Service cmdlet supports pipelining. 

We used its alias 'gsv' as a parameter value.

```
Get-sthPipelineCommand -Command gsv

Command     SupportsPipeline
-------     ----------------
Get-Service             True
```

---

The first command gets [CmdletInfo] object for Get-Process cmdlet.

The second command gets [FunctionInfo] object for Get-Verb function.

The third command gets [AliasInfo] object for gsv alias.

The fourth command checks, whether these commands support pipelining.

```
$command = Get-Command -Name Get-Process
$function = Get-Command -Name Get-Verb
$alias = Get-Command gsv

Get-sthPipelineCommand -Command $command, $function, $alias

Command     SupportsPipeline
-------     ----------------
Get-Process             True
Get-Verb                True
Get-Service             True
```

---

The first command gets [CmdletInfo] object for Get-Process cmdlet.

The second command gets [FunctionInfo] object for Get-Verb function.

The third command gets [AliasInfo] object for gsv alias.

The fourth command checks, whether these commands and Get-PSDrive and Get-Content (we used its alias - 'cat') support pipelining.

This time we provide commands to Get-sthPipelineCommand using pipeline.

```
$command = Get-Command -Name Get-Process
$function = Get-Command -Name Get-Verb
$alias = Get-Command gsv

$command, $function, $alias, 'Get-PSDrive', 'cat' | Get-sthPipelineCommand

Command     SupportsPipeline
-------     ----------------
Get-Process             True
Get-Verb                True
Get-Service             True
Get-PSDrive             True
Get-Content             True
```

---

The first command gets array of cmdlets, that are members of 'Microsoft.PowerShell.Management' module.

The second command displays whether these commands support pipelining.

```
$commands = Get-Command -Module 'Microsoft.PowerShell.Management'
Get-sthPipelineCommand -Command $commands
```

---

This command checks if two commands support pipeline - Get-Process and some nonexisting command.

Result displays information about Get-Process cmdlet and also shows that Non-ExistingCommand was not found.

```
Get-sthPipelineCommand -Command Get-Process, Non-ExistingCommand

Command     SupportsPipeline
-------     ----------------
Get-Process             True

Commands not found:
Non-ExistingCommand
```

---

This command checks if two commands support pipeline - Get-Process and some nonexisting command.

Because -HideNotFoundCommands switch parameter was used, Get-sthPipelineCommand doesn't show information about non-existing command.

```
Get-sthPipelineCommand -Command Get-Process, Non-ExistingCommand -HideNotFoundCommands

Command     SupportsPipeline
-------     ----------------
Get-Process             True
```

### Get-sthPipelineParameter

This command displays information about parameters of Get-Process cmdlet, that can accept pipeline input.

```
Get-sthPipelineParameter -Command Get-Process

   Command: Get-Process

ParameterName Aliases     ParameterType                ParameterSet            Mandatory ByValue ByPropertyName
------------- -------     -------------                ------------            --------- ------- --------------
Name          ProcessName System.String[]              NameWithUserName        False     False   True
Name          ProcessName System.String[]              Name (IsDefault)        False     False   True
Id            PID         System.Int32[]               IdWithUserName          True      False   True
Id            PID         System.Int32[]               Id                      True      False   True
InputObject               System.Diagnostics.Process[] InputObjectWithUserName True      True    False
InputObject               System.Diagnostics.Process[] InputObject             True      True    False
ComputerName  Cn          System.String[]              Id                      False     False   True
ComputerName  Cn          System.String[]              Name (IsDefault)        False     False   True
ComputerName  Cn          System.String[]              InputObject             False     False   True
```

---

This command displays information about parameters of Get-Verb function, that can accept pipeline input.

```
Get-sthPipelineParameter -Command Get-Verb

   Command: Get-Verb

ParameterName Aliases ParameterType   ParameterSet       Mandatory ByValue ByPropertyName
------------- ------- -------------   ------------       --------- ------- --------------
verb                  System.String[] __AllParameterSets False     True    False
```

---

Command displays information about parameters of Get-Service cmdlet, that can accept pipeline input.

We used its alias 'gsv' as a parameter value.

```
Get-sthPipelineParameter -Command gsv

   Command: Get-Service

ParameterName Aliases     ParameterType                             ParameterSet        Mandatory ByValue ByPropertyName
------------- -------     -------------                             ------------        --------- ------- --------------
Name          ServiceName System.String[]                           Default (IsDefault) False     True    True
ComputerName  Cn          System.String[]                           __AllParameterSets  False     False   True
InputObject               System.ServiceProcess.ServiceController[] InputObject         False     True    False
```

---

The first command gets [CmdletInfo] object for Get-Process cmdlet.

The second command gets [FunctionInfo] object for Get-Verb function.

The third command gets [AliasInfo] object for gsv alias.

The fourth command displays information about parameters of specified cmdlets and functions, that support pipeline input.

```
$command = Get-Command -Name Get-Process
$function = Get-Command -Name Get-Verb
$alias = Get-Command gsv

Get-sthPipelineParameter -Command $command, $function, $alias
```

---

The first command gets [CmdletInfo] object for Get-Process cmdlet.

The second command gets [FunctionInfo] object for Get-Verb function.

The third command gets [AliasInfo] object for gsv alias.

The fourth command displays information about parameters of specified cmdlets and functions, that support pipeline input.

This time we provide commands to Get-sthPipelineParameter using pipeline.

```
$command = Get-Command -Name Get-Process
$function = Get-Command -Name Get-Verb
$alias = Get-Command gsv

$command, $function, $alias, 'Get-PSDrive', 'cat' | Get-sthPipelineParameter
```

---

This command displays information about parameters of Get-Process cmdlet, that can accept pipeline input.

Also, output contains information about non-existing command.

```
Get-sthPipelineParameter -Command Get-Process, Non-ExistingCommand

   Command: Get-Process

ParameterName Aliases     ParameterType                ParameterSet            Mandatory ByValue ByPropertyName
------------- -------     -------------                ------------            --------- ------- --------------
Name          ProcessName System.String[]              NameWithUserName        False     False   True
Name          ProcessName System.String[]              Name (IsDefault)        False     False   True
Id            PID         System.Int32[]               IdWithUserName          True      False   True
Id            PID         System.Int32[]               Id                      True      False   True
InputObject               System.Diagnostics.Process[] InputObjectWithUserName True      True    False
InputObject               System.Diagnostics.Process[] InputObject             True      True    False
ComputerName  Cn          System.String[]              Id                      False     False   True
ComputerName  Cn          System.String[]              Name (IsDefault)        False     False   True
ComputerName  Cn          System.String[]              InputObject             False     False   True

Commands not found:
Non-ExistingCommand
```

---

This command displays information about parameters of Get-Process cmdlet, that can accept pipeline input.

Because -HideNotFoundCommands switch parameter was used, Get-sthPipelineParameter 
doesn't show information about non-existing command.

```
Get-sthPipelineParameter -Command Get-Process, Non-ExistingCommand -HideNotFoundCommands

   Command: Get-Process

ParameterName Aliases     ParameterType                ParameterSet            Mandatory ByValue ByPropertyName
------------- -------     -------------                ------------            --------- ------- --------------
Name          ProcessName System.String[]              NameWithUserName        False     False   True
Name          ProcessName System.String[]              Name (IsDefault)        False     False   True
Id            PID         System.Int32[]               IdWithUserName          True      False   True
Id            PID         System.Int32[]               Id                      True      False   True
InputObject               System.Diagnostics.Process[] InputObjectWithUserName True      True    False
InputObject               System.Diagnostics.Process[] InputObject             True      True    False
ComputerName  Cn          System.String[]              Id                      False     False   True
ComputerName  Cn          System.String[]              Name (IsDefault)        False     False   True
ComputerName  Cn          System.String[]              InputObject             False     False   True
```

---

Function Get-sthPipelineCommand gets information about whether Get-Process, Start-Process and Stop-Process cmdlets support pipelining.

Then it sends results to Get-sthPipelineParameter function, which returns information about parameters, that can accept objects from pipeline.

Of these three commands, only two - Get-Process and Stop-Process - support pipelining, therefore Get-sthPipelineParameter results don't contain information about Start-Process.

```
Get-sthPipelineCommand -Command Get-Process, Start-Process, Stop-Process | Get-sthPipelineParameter

   Command: Get-Process

ParameterName Aliases     ParameterType                ParameterSet            Mandatory ByValue ByPropertyName
------------- -------     -------------                ------------            --------- ------- --------------
Name          ProcessName System.String[]              NameWithUserName        False     False   True
Name          ProcessName System.String[]              Name (IsDefault)        False     False   True
Id            PID         System.Int32[]               IdWithUserName          True      False   True
Id            PID         System.Int32[]               Id                      True      False   True
InputObject               System.Diagnostics.Process[] InputObjectWithUserName True      True    False
InputObject               System.Diagnostics.Process[] InputObject             True      True    False
ComputerName  Cn          System.String[]              Id                      False     False   True
ComputerName  Cn          System.String[]              Name (IsDefault)        False     False   True
ComputerName  Cn          System.String[]              InputObject             False     False   True


   Command: Stop-Process

ParameterName Aliases     ParameterType                ParameterSet   Mandatory ByValue ByPropertyName
------------- -------     -------------                ------------   --------- ------- --------------
Name          ProcessName System.String[]              Name           True      False   True
Id                        System.Int32[]               Id (IsDefault) True      False   True
InputObject               System.Diagnostics.Process[] InputObject    True      True    False
```