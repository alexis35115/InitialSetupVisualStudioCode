"Killing all Visual Studio Code instances.."

Stop-Process -Name "code" -ErrorAction SilentlyContinue

"Installing VS Code Extensions..."

try {
    code --install-extension ritwickdey.LiveServer --force
    code --install-extension esbenp.prettier-vscode --force
    code --install-extension VisualStudioExptTeam.vscodeintellicode --force
    code --install-extension bloody-ux.sftp-sync --force
    code --install-extension lihui.vs-color-picker --force
    code --install-extension msjsdiag.debugger-for-chrome --force
    code --install-extension PrimaFuture.open-php-html-js-in-browser --force
    code --install-extension rifi2k.format-html-in-php --force
    code --install-extension Zignd.html-css-class-completion --force
    code --install-extension ms-vsliveshare.vsliveshare --force
    code --install-extension zignd.html-css-class-completion --force
    code --install-extension liximomo.sftp --force

    "Installation complete!"
}
catch {
    Write-Host $_.Exception.Message
}

"Getting user settings"
if(![System.IO.File]::Exists($path)){
    $settings = "{}" | ConvertFrom-Json
}
else{
    $settings = Get-Content -Raw -Path $env:appdata\Code\User\settings.json -Encoding UTF8 | ConvertFrom-Json
}

"Updating user settings"
$settings | add-member -force -name "editor.wordWrap" -value "on" -MemberType NoteProperty
$settings | add-member -force -name "open-php-html-js-in-browser.selectedBrowser" -value "Chrome" -MemberType NoteProperty
$settings | add-member -force -name "open-php-html-js-in-browser.customUrlToOpen" -value 'http://localhost:8888/${fileBasename}' -MemberType NoteProperty
$settings | add-member -force -name "open-php-html-js-in-browser.documentRootFolder" -value "C:\Bitnami\wampstack-7.3.8-0\apache2\htdocs" -MemberType NoteProperty
$settings | add-member -force -name "php.executablePath" -value "C:\Bitnami\wampstack-7.3.8-0\php\php.exe" -MemberType NoteProperty
$settings | add-member -force -name "php.validate.executablePath" -value "C:\Bitnami\wampstack-7.3.8-0\php\php.exe" -MemberType NoteProperty

$settings | add-member -force -name "terminal.integrated.shell.windows" -value "C:\Windows\System32\cmd.exe" -MemberType NoteProperty

$list = New-Object System.Collections.ArrayList
$list.Add("/K")
$list.Add("chcp 65001") 

$settings | add-member -force -name "terminal.integrated.shellArgs.windows" -value $list -MemberType NoteProperty

"Saving user settings"
$settings | ConvertTo-Json -depth 50 | ForEach-Object { $_.Replace("\u0027", "'") } | Out-File $env:appdata\Code\User\settings.json -Encoding utf8

pause

