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

    "Installation complete!"
}
catch {
    Write-Host $_.Exception.Message
}

"Getting user settings"
$settings = Get-Content -Raw -Path $env:appdata\Code\User\settings.json -Encoding UTF8 | ConvertFrom-Json

"Updating user settings"
$settings.'editor.wordWrap' = "on"
$settings.'open-php-html-js-in-browser.selectedBrowser' = "Chrome" 
$settings.'open-php-html-js-in-browser.customUrlToOpen' = 'http://localhost:8888/${fileBasename}' 
$settings.'open-php-html-js-in-browser.documentRootFolder' = "C:\Bitnami\wampstack-7.3.8-0\apache2\htdocs" 
$settings.'php.executablePath' = "C:\Bitnami\wampstack-7.3.8-0\php\php.exe" 
$settings.'php.validate.executablePath' = "C:\Bitnami\wampstack-7.3.8-0\php\php.exe" 

"Saving user settings"
$settings | ConvertTo-Json -depth 50 | ForEach-Object { $_.Replace("\u0027", "'") } | Out-File $env:appdata\Code\User\settings.json

pause

