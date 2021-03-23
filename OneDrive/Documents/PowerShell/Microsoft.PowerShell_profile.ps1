# ------------------------------------------------------------------------------
# ALIAS
# ------------------------------------------------------------------------------
New-Alias -Name cfg -Value Invoke-Cfg
New-Alias -Name vi -Value 'C:\Program Files (x86)\vim\vim81\vim.exe'
New-Alias -Name vim -Value 'C:\Program Files (x86)\vim\vim81\vim.exe'

# ------------------------------------------------------------------------------
# DOT FILES
# ------------------------------------------------------------------------------
function Invoke-Cfg() { & git --git-dir='C:\Users\Adrian\.cfg' --work-tree='C:\Users\Adrian' $args }

# ------------------------------------------------------------------------------
# PSReadLine
# ------------------------------------------------------------------------------
if ($host.Name -eq 'ConsoleHost')
{
    Import-Module PSReadLine
}

Set-PSReadLineKeyHandler -Key Ctrl+Shift+b `
                         -BriefDescription BuildCurrentDirectory `
                         -LongDescription "dotnet Build the current directory" `
                         -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("dotnet build")
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadLineKeyHandler -Key Ctrl+Shift+t `
                         -BriefDescription TestCurrentDirectory `
                         -LongDescription "dotnet Test the current directory" `
                         -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("dotnet test")
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}
                         
# ------------------------------------------------------------------------------
# OH-MY-POSH
# ------------------------------------------------------------------------------
Set-PoshPrompt -Theme ~\.oh-my-posh.omp.json

