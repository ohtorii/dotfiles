#
#Fish shellをExplorerの右クリックメニューに登録する。
#
#(方法)
#Windowsのレジストリを利用する。
#
#(注意)
#レジストリへ書き込むため管理者として実行して下さい。
#


$script:script_path=Split-Path -Parent $MyInvocation.MyCommand.Path

function regist ($root, $item, $icon_filename, $command) {
	#add "...<snip>...\fish_shel"
	New-Item -Force -Path "${root}" -Name $fish

	#set "fish_shell\(default)"
	Set-ItemProperty -Force -Path "${root}\${item}" -Name "(default)" -Value "Fish Shell Here"
	if (Test-Path ${icon_filename}){
		#add "fish_shell\Icon"
		New-ItemProperty -Force -Path "${root}\${item}" -Name Icon -PropertyType String -Value ${icon_filename}
	}else{
		Write-Output "Not found icon file."
	}

	#add "fish_shell\command"
	New-Item -Force -Path "${root}\${item}" -Name command

	#set "fish_shell\command\(default)""
	Set-ItemProperty -Force -Path "${root}\${item}\command" -Name "(default)" -Value $command
}

function main () {
	$fish="fish_shell"
	$icon_filename="${script_path}\image\fish_shell.ico"
	$command='cmd.exe /s /c set PATH=C:\tools\msys64\usr\bin;%PATH%&&start "" /D "%V" /B /WAIT "C:\tools\msys64\usr\bin\fish.exe" -i -l'
	regist "Registry::HKEY_CLASSES_ROOT\directory\BackGround\shell" "${fish}" "${icon_filename}" $command
	regist "Registry::HKEY_CLASSES_ROOT\directory\shell" "${fish}" "${icon_filename}" $command
}

main