# Created By P as in Papi
$p = (pwd).path

function Banner {
write-host "                                                                
 _____                      _____                 _     _       
|  _  |___ _ _ _ ___ ___   |_   _|___ ___ ___ ___| |___| |_ ___ 
|   __| . | | | | -_|  _|    | | |  _| .'|   |_ -| | .'|  _| -_|
|__|  |___|_____|___|_|      |_| |_| |__,|_|_|___|_|__,|_| |___|
                                                                " -foregroundcolor Cyan
echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - I"																
echo " "
write-host "- Quick translator on the spot! -" -foregroundcolor Yellow
echo " "
write-host "Version 0.75 Pre-Alpha" -foregroundcolor Yellow
write-host "~ DukeZilla 2023" -foregroundcolor Yellow
echo " "
echo "- - - - - - - - - - - - - - I"
$lang = gc $p\target-lang.txt
$host.UI.RawUI.ForegroundColor = "White"
echo " "
write-host "Output language set to: $lang" -foregroundcolor Green
write-host "Source: Google Translate" -foregroundcolor Yellow
write-host "Type /? to get for help and information on usage of Power Translate." -foregroundcolor Yellow
}

function Translator {
$host.UI.RawUI.ForegroundColor = "White"
echo " "
echo "- - - - - - - - - - - - - - - - - - - I"
echo " "
$main = Read-Host "Translate>"
if ($main -like "exit") {exit}
if ($main -like "set-lang") {set-lang}
if ($main -like "lang") {
	echo " "
	write-host "Translated Output: $lang"  -foregroundcolor Yellow
	Translator
}
if ($main -like "/?") {
	echo ' '
	type lang-docs.txt
	Translator
}
if ($main -like "cls") {
	clear
	Translator
}
echo " "
$host.UI.RawUI.ForegroundColor = "Green"

$Text = $main
$TargetLanguage = gc $p\target-lang.txt
$Uri = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=$($TargetLanguage)&dt=t&q=$Text".Replace(" ", "%20").Replace("\", "\\")
$Response = Invoke-WebRequest -Uri $Uri -Method Get

$TranslatedText = ($Response.Content).Substring(4)
$TranslatedText, $RemainingText = $TranslatedText.Split('"')
$TranslatedText > player-chat-translated.txt
echo "--------------------------------O"
echo $TranslatedText
echo "--------------------------------O"
Translator
}

$ValidateSet = (Get-Content -Path 'params.txt')

function set-lang {
echo " "
$lang = Read-Host "Set language output"
if ($lang -like "exit") {exit}
if ($lang -like "translator") {Translator}
if ($lang -like "/?") {
	echo ' '
	type lang-docs.txt
	Translator}
if ($lang -like "cls") {
	clear
	Translator}

if ($ValidateSet -contains $lang) {$true} else {
	echo " "
	write-host "Error: Wrong language paramater set." -foregroundcolor red
    set-lang
}

echo $lang > target-lang.txt
Write-Host "Language set to $lang"
Translator
}

Banner
Translator



# Unused / Scrapped
# ---------------------------------------------------


function set-lang {
    [CmdletBinding()]
	[Alias('set')]
	
    param
	(
		[Validatescript({
            if ($ValidateSet -contains $PSItem) {$true}
            else { throw $ValidateSet}})]
        [String]$lang
	)

    process 
	{
        echo $lang > target-lang.txt
        Write-Host "Language set to $lang"
		Translator
    }
}
PS> Install-Office -Version '15.0'
$ToMatch = @('String1','String2','String3')
Get-ADComputer -Filter * | ?{$_.Name -match $ToMatch}