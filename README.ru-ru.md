# sthPipelineTools

**sthPipelineTools** - это модуль, содержащий две функции, предназначенные для работы и исследования механизма конвейера в PowerShell.

В модуль входят следующие функции:

**Get-sthPipelineCommand** - Функция проверяет, поддерживает ли указанная команда получение данных по конвейеру.

**Get-sthPipelineParameter** - Функция Get-sthPipelineParameters выводит информацию о параметрах указанной команды, которые поддерживают получение данных по конвейеру.

Результаты содержат имена параметров, их типы, набор параметров, в который они входят, является ли он набором параметров по умолчанию, является ли параметр обязательным (Mandatory), а также, какие из способов сопоставления поступающих данных - ByValue, ByPropertyName - он поддерживает.

Вы можете установить модуль sthPipelineTools из PowerShell Gallery:


```
Install-Module sthPipelineTools
```

## Как с этим работать?

### Get-sthPipelineCommand

Команда проверяет, поддерживает ли командлет Get-Process получение данных по конвейеру.

```powershell
Get-sthPipelineCommand -Command Get-Process

Command     SupportsPipeline
-------     ----------------
Get-Process             True
```

---

Команда проверяет, поллерживает ли функция Get-Verb получение данных по конвейеру.

```powershell
Get-sthPipelineCommand -Command Get-Verb

Command  SupportsPipeline
-------  ----------------
Get-Verb             True
```

---

Команда проверяет, поддерживает ли командлет Get-Service получение данных по конвейеру. 

При запросе используется его псевдоним - "gsv".

```powershell
Get-sthPipelineCommand -Command gsv

Command     SupportsPipeline
-------     ----------------
Get-Service             True
```

---

Первая команда получает объект [CmdletInfo], описывающий командлет Get-Process.

Вторая команда получает объект [FunctionInfo], описывающий функцию Get-Verb.

Третья команда получает объект [AliasInfo], описывающий псевдоним "gsv".

Четвертая команда проверяет, поддерживают ли эти команды получение данных по конвейеру.

```powershell
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

Первая команда получает объект [CmdletInfo], описывающий командлет Get-Process.

Вторая команда получает объект [FunctionInfo], описывающий функцию Get-Verb.

Третья команда получает объект [AliasInfo], описывающий псевдоним "gsv".

Четвертая команда проверяет, поддерживают ли эти команды, а также Get-PSDrive и Get-Content (мы использовали его псевдоним - 'cat'), получение данных по конвейеру.

В этот раз мы передали данные функции Get-sthPipelineCommand при помощи конвейера.

```powershell
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

Первая комада получает массив команд, входящих в модуль 'Microsoft.PowerShell.Management'.

Вторая команда проверяет, поддерживают ли они получение данных по конвейеру.

```powershell
$commands = Get-Command -Module 'Microsoft.PowerShell.Management'
Get-sthPipelineCommand -Command $commands
```

---

Команда проверяет, поддерживает ли командлет Get-Process получение данных по конвейеру.

Результат содержит информацию о Get-Process, а также сообщает о том, что команда Non-ExistingCommand не была найдена.

```powershell
Get-sthPipelineCommand -Command Get-Process, Non-ExistingCommand

Command     SupportsPipeline
-------     ----------------
Get-Process             True

Commands not found:
Non-ExistingCommand
```

---

Команда проверяет, поддерживает ли командлет Get-Process получение данных по конвейеру.

Так как мы указали параметр -HideNotFoundCommands, функция не будет сообщать о несуществующей команде.

```powershell
Get-sthPipelineCommand -Command Get-Process, Non-ExistingCommand -HideNotFoundCommands

Command     SupportsPipeline
-------     ----------------
Get-Process             True
```

### Get-sthPipelineParameter

Команда отображает информацию о параметрах командлета Get-Process, которые поддерживают получение данных по конвейеру.

```powershell
Get-sthPipelineParameter -Command Get-Process

   Command: Get-Process

ParameterName ParameterType                ParameterSet            Mandatory ByValue ByPropertyName
------------- -------------                ------------            --------- ------- --------------
Name          System.String[]              NameWithUserName        False     False   True
Name          System.String[]              Name (IsDefault)        False     False   True
Id            System.Int32[]               IdWithUserName          True      False   True
Id            System.Int32[]               Id                      True      False   True
InputObject   System.Diagnostics.Process[] InputObjectWithUserName True      True    False
InputObject   System.Diagnostics.Process[] InputObject             True      True    False
ComputerName  System.String[]              Id                      False     False   True
ComputerName  System.String[]              Name (IsDefault)        False     False   True
ComputerName  System.String[]              InputObject             False     False   True
```

---

Команда отображает информацию о параметрах функции Get-Verb, которые поддерживают получение данных по конвейеру.

```powershell
Get-sthPipelineParameter -Command Get-Verb

   Command: Get-Verb

ParameterName ParameterType   ParameterSet       Mandatory ByValue ByPropertyName
------------- -------------   ------------       --------- ------- --------------
verb          System.String[] __AllParameterSets False     True    False
```

---

Команда отображает информацию о параметрах командлета Get-Service, которые поддерживают получение данных по конвейеру. 

При запросе используется его псевдоним - "gsv".

```powershell
Get-sthPipelineParameter -Command gsv

   Command: Get-Service

ParameterName ParameterType                             ParameterSet        Mandatory ByValue ByPropertyName
------------- -------------                             ------------        --------- ------- --------------
Name          System.String[]                           Default (IsDefault) False     True    True
ComputerName  System.String[]                           __AllParameterSets  False     False   True
InputObject   System.ServiceProcess.ServiceController[] InputObject         False     True    False
```

---

Первая команда получает объект [CmdletInfo], описывающий командлет Get-Process.

Вторая команда получает объект [FunctionInfo], описывающий функцию Get-Verb.

Третья команда получает объект [AliasInfo], описывающий псевдоним "gsv".

Четвертая команда отображает информацию о параметрах указанных командлетов и функций, которые поддерживают получение данных по конвейеру.

```powershell
$command = Get-Command -Name Get-Process
$function = Get-Command -Name Get-Verb
$alias = Get-Command gsv

Get-sthPipelineParameter -Command $command, $function, $alias
```

---

Первая команда получает объект [CmdletInfo], описывающий командлет Get-Process.

Вторая команда получает объект [FunctionInfo], описывающий функцию Get-Verb.

Третья команда получает объект [AliasInfo], описывающий псевдоним "gsv".

Четвертая команда отображает информацию о параметрах указанных командлетов и функций, которые поддерживают получение данных по конвейеру.

В этот раз мы передали данные функции Get-sthPipelineParameter при помощи конвейера.

```powershell
$command = Get-Command -Name Get-Process
$function = Get-Command -Name Get-Verb
$alias = Get-Command gsv

$command, $function, $alias, 'Get-PSDrive', 'cat' | Get-sthPipelineParameter
```

---

Команда отображает информацию о параметрах командлета Get-Process, которые поддерживают получение данных по конвейеру.

Также функция сообщает о несуществующей команде - "Non-ExistingCommand".

```powershell
Get-sthPipelineParameter -Command Get-Process, Non-ExistingCommand

   Command: Get-Process

ParameterName ParameterType                ParameterSet            Mandatory ByValue ByPropertyName
------------- -------------                ------------            --------- ------- --------------
Name          System.String[]              NameWithUserName        False     False   True
Name          System.String[]              Name (IsDefault)        False     False   True
Id            System.Int32[]               IdWithUserName          True      False   True
Id            System.Int32[]               Id                      True      False   True
InputObject   System.Diagnostics.Process[] InputObjectWithUserName True      True    False
InputObject   System.Diagnostics.Process[] InputObject             True      True    False
ComputerName  System.String[]              Id                      False     False   True
ComputerName  System.String[]              Name (IsDefault)        False     False   True
ComputerName  System.String[]              InputObject             False     False   True

Commands not found:
Non-ExistingCommand
```

---

Команда отображает информацию о параметрах командлета Get-Process, которые поддерживают получение данных по конвейеру.

Так как мы указали параметр -HideNotFoundCommands, функция не будет сообщать о несуществующей команде.

```powershell
Get-sthPipelineParameter -Command Get-Process, Non-ExistingCommand -HideNotFoundCommands

   Command: Get-Process

ParameterName ParameterType                ParameterSet            Mandatory ByValue ByPropertyName
------------- -------------                ------------            --------- ------- --------------
Name          System.String[]              NameWithUserName        False     False   True
Name          System.String[]              Name (IsDefault)        False     False   True
Id            System.Int32[]               IdWithUserName          True      False   True
Id            System.Int32[]               Id                      True      False   True
InputObject   System.Diagnostics.Process[] InputObjectWithUserName True      True    False
InputObject   System.Diagnostics.Process[] InputObject             True      True    False
ComputerName  System.String[]              Id                      False     False   True
ComputerName  System.String[]              Name (IsDefault)        False     False   True
ComputerName  System.String[]              InputObject             False     False   True
```

---

Функция Get-sthPipelineCommand проверяет, поддерживают ли командлеты 
Get-Process, Start-Process и Stop-Process получение данных по конвейеру.

Затем функция передает полученные данные функции Get-sthPipelineParameter, 
которая выводит информацию о поддерживающих конвейер параметрах.

Так как из трех указанных команд конвейер поддерживают только две - Get-Process and Stop-Process, 
функция Get-sthPipelineParameter не отображает информацию о паарметрах командлета Start-Process.

```powershell
Get-sthPipelineCommand -Command Get-Process, Start-Process, Stop-Process | Get-sthPipelineParameter

   Command: Get-Process

ParameterName ParameterType                ParameterSet            Mandatory ByValue ByPropertyName
------------- -------------                ------------            --------- ------- --------------
Name          System.String[]              NameWithUserName        False     False   True
Name          System.String[]              Name (IsDefault)        False     False   True
Id            System.Int32[]               IdWithUserName          True      False   True
Id            System.Int32[]               Id                      True      False   True
InputObject   System.Diagnostics.Process[] InputObjectWithUserName True      True    False
InputObject   System.Diagnostics.Process[] InputObject             True      True    False
ComputerName  System.String[]              Id                      False     False   True
ComputerName  System.String[]              Name (IsDefault)        False     False   True
ComputerName  System.String[]              InputObject             False     False   True


   Command: Stop-Process

ParameterName ParameterType                ParameterSet   Mandatory ByValue ByPropertyName
------------- -------------                ------------   --------- ------- --------------
Name          System.String[]              Name           True      False   True
Id            System.Int32[]               Id (IsDefault) True      False   True
InputObject   System.Diagnostics.Process[] InputObject    True      True    False
```