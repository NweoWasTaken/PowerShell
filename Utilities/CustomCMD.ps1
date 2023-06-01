# Make sure this script has been downloaded from NweoScripts or the official repository on Github
# You can also run this script just by using the following command in poweshell irm | https://nwst.netfliy.app/scripts [Not yet tbh]

# Variables
$version = "1.0.1"
$date = Get-Date -UFormat "%A %m/%d/%Y"
$scriptRoot = Split-Path -Path $PSScriptRoot -Qualifier
$driveName = $scriptRoot.Substring(0, 1)
$time = Get-Date
$timef = $time.ToString("HH:mm:ss,ff")

# Funciones
function cmd($a) {
    $filePath = "$Env:LOCALAPPDATA\NweoScripts\CustomCMD\cmd.bat"
    mkdir -Path $Env:LOCALAPPDATA\NweoScripts\CustomCMD -ErrorAction SilentlyContinue
    $content = @(
        "prompt $a",
        "cls",
        " pause"
    )
    $content | Set-Content -Path $filePath -Encoding ASCII
    Start-Process -FilePath 'cmd.exe' -ArgumentList "/c $filePath"
}

Add-Type -AssemblyName System.Windows.Forms

$Main = New-Object system.Windows.Forms.Form
$Main.MaximizeBox = $False
$Main.MinimizeBox = $False
$Main.text = "CustomCMD " + $version
$Main.BackColor = "#1f1f1f"
$Main.FormBorderStyle = "FixedSingle"
$Main.ClientSize = New-Object System.Drawing.Size '700, 450'
$Main.StartPosition = "CenterScreen"

$TitleGui = New-Object System.Windows.Forms.Label
$TitleGui.Location = New-Object System.Drawing.Point(50, 25)
$TitleGui.Size = New-Object System.Drawing.Size(500, 40)
$TitleGui.Text = "CustomCMD"
$TitleGui.ForeColor = "#ffffff"
$TitleGui.Font = 'consolas,30'
$Main.Controls.Add($TitleGui)

$TitleGui = New-Object System.Windows.Forms.Label
$TitleGui.Location = New-Object System.Drawing.Point(50, 80)
$TitleGui.Size = New-Object System.Drawing.Size(500, 20)
$TitleGui.Text = "A script to customize the CMD startup prompt"
$TitleGui.ForeColor = "#ffffff"
$TitleGui.Font = 'consolas,10'
$Main.Controls.Add($TitleGui)

$TextArea = New-Object System.Windows.Forms.TextBox
$TextArea.Location = New-Object System.Drawing.Point(50, 100)
$TextArea.Size = New-Object System.Drawing.Size(500, 10)
$TextArea.Font = New-Object System.Drawing.Font('Consolas', 10)
$TextArea.Text = "`$P`$G"
$Main.Controls.Add($TextArea)

$ApplyBtn = New-Object System.Windows.Forms.Button
$ApplyBtn.Location = New-Object System.Drawing.Point(50, 400)
$ApplyBtn.Size = New-Object System.Drawing.Size(100, 25)
$ApplyBtn.Text = "Apply"
$ApplyBtn.ForeColor = "#ffffff"
$ApplyBtn.Add_Click({
    Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\Command Processor" -Recurse -ErrorAction SilentlyContinue
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Command Processor" -ErrorAction SilentlyContinue
    New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Command Processor" -Name autorun -Value ("prompt "+$TextArea.Text) -PropertyType String -ErrorAction SilentlyContinue
    [System.Windows.Forms.MessageBox]::Show('The CMD prompt has been updated correctly!', 'Warning', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information)
})
$Main.Controls.Add($ApplyBtn)

$CMDBtn = New-Object System.Windows.Forms.Button
$CMDBtn.Location = New-Object System.Drawing.Point(160, 400)
$CMDBtn.Size = New-Object System.Drawing.Size(100, 25)
$CMDBtn.Text = "Open CMD"
$CMDBtn.ForeColor = "#ffffff"
$CMDBtn.Add_Click({
    Start-Process -FilePath 'cmd.exe'
})
$Main.Controls.Add($CMDBtn)

$RstBtn = New-Object System.Windows.Forms.Button
$RstBtn.Location = New-Object System.Drawing.Point(270, 400)
$RstBtn.Size = New-Object System.Drawing.Size(100, 25)
$RstBtn.Text = "Reset CMD"
$RstBtn.ForeColor = "#ffffff"
$RstBtn.Add_Click({
    Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\Command Processor" -Recurse -ErrorAction SilentlyContinue
    [System.Windows.Forms.MessageBox]::Show('The CMD prompt has been reset to the default!', 'Warning', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information)
})
$Main.Controls.Add($RstBtn)

$PreBtn = New-Object System.Windows.Forms.Button
$PreBtn.Location = New-Object System.Drawing.Point(550, 100)
$PreBtn.Size = New-Object System.Drawing.Size(100, 25)
$PreBtn.Text = "Preview in CMD"
$PreBtn.ForeColor = "#ffffff"
$PreBtn.Add_Click({
    cmd($TextArea.Text)
})
$Main.Controls.Add($PreBtn)

$BtnA = New-Object System.Windows.Forms.Button
$BtnA.Location = New-Object System.Drawing.Point(50, 150)
$BtnA.Size = New-Object System.Drawing.Size(50, 25)
$BtnA.Text = "&&"
$BtnA.ForeColor = "#ffffff"
$BtnA.Add_Click({
    $TextArea.Text = $TextArea.Text + $TextBox.Text + "`$A"
})
$Main.Controls.Add($BtnA)

$BtnB = New-Object System.Windows.Forms.Button
$BtnB.Location = New-Object System.Drawing.Point(110, 150)
$BtnB.Size = New-Object System.Drawing.Size(50, 25)
$BtnB.Text = "|"
$BtnB.ForeColor = "#ffffff"
$BtnB.Add_Click({
    $TextArea.Text = $TextArea.Text + $TextBox.Text + "`$B"
})
$Main.Controls.Add($BtnB)

$BtnC = New-Object System.Windows.Forms.Button
$BtnC.Location = New-Object System.Drawing.Point(170, 150)
$BtnC.Size = New-Object System.Drawing.Size(50, 25)
$BtnC.Text = "("
$BtnC.ForeColor = "#ffffff"
$BtnC.Add_Click({
    $TextArea.Text = $TextArea.Text + $TextBox.Text + "`$C"
})
$Main.Controls.Add($BtnC)

$BtnD = New-Object System.Windows.Forms.Button
$BtnD.Location = New-Object System.Drawing.Point(50, 200)
$BtnD.Size = New-Object System.Drawing.Size(180, 25)
$BtnD.Text =  ("Current Date:", $date )
$BtnD.ForeColor = "#ffffff"
$BtnD.Add_Click({
    $TextArea.Text = $TextArea.Text + $TextBox.Text + "`$D"
})
$Main.Controls.Add($BtnD)

$BtnE = New-Object System.Windows.Forms.Button
$BtnE.Location = New-Object System.Drawing.Point(300, 300)
$BtnE.Size = New-Object System.Drawing.Size(220, 25)
$BtnE.Text =  "Escape (Deletes the following character)"
$BtnE.ForeColor = "#ffffff"
$BtnE.Add_Click({
    $TextArea.Text = $TextArea.Text + $TextBox.Text + "`$E"
})
$Main.Controls.Add($BtnE)

$BtnF = New-Object System.Windows.Forms.Button
$BtnF.Location = New-Object System.Drawing.Point(230, 150)
$BtnF.Size = New-Object System.Drawing.Size(50, 25)
$BtnF.Text = ")"
$BtnF.ForeColor = "#ffffff"
$BtnF.Add_Click({
    $TextArea.Text = $TextArea.Text + $TextBox.Text + "`$F"
})
$Main.Controls.Add($BtnF)

$BtnG = New-Object System.Windows.Forms.Button
$BtnG.Location = New-Object System.Drawing.Point(350, 150)
$BtnG.Size = New-Object System.Drawing.Size(50, 25)
$BtnG.Text = ">"
$BtnG.ForeColor = "#ffffff"
$BtnG.Add_Click({
    $TextArea.Text = $TextArea.Text + $TextBox.Text + "`$G"
})
$Main.Controls.Add($BtnG)

$BtnH = New-Object System.Windows.Forms.Button
$BtnH.Location = New-Object System.Drawing.Point(50, 300)
$BtnH.Size = New-Object System.Drawing.Size(240, 25)
$BtnH.Text = "Backspace (Deletes the previous character)"
$BtnH.ForeColor = "#ffffff"
$BtnH.Add_Click({
    $TextArea.Text = $TextArea.Text + $TextBox.Text + "`$H"
})
$Main.Controls.Add($BtnH)

$BtnL = New-Object System.Windows.Forms.Button
$BtnL.Location = New-Object System.Drawing.Point(290, 150)
$BtnL.Size = New-Object System.Drawing.Size(50, 25)
$BtnL.Text = "<"
$BtnL.ForeColor = "#ffffff"
$BtnL.Add_Click({
    $TextArea.Text = $TextArea.Text + $TextBox.Text + "`$L"
})
$Main.Controls.Add($BtnL)

$BtnN = New-Object System.Windows.Forms.Button
$BtnN.Location = New-Object System.Drawing.Point(240, 200)
$BtnN.Size = New-Object System.Drawing.Size(100, 25)
$BtnN.Text = "Current drive ("+$driveName+")"
$BtnN.ForeColor = "#ffffff"
$BtnN.Add_Click({
    $TextArea.Text = $TextArea.Text + $TextBox.Text + "`$N"
})
$Main.Controls.Add($BtnN)

$BtnP = New-Object System.Windows.Forms.Button
$BtnP.Location = New-Object System.Drawing.Point(350, 200)
$BtnP.Size = New-Object System.Drawing.Size(250, 25)
$BtnP.Text = "Current drive and Path("+$PSScriptRoot.Substring(0, 10)+"...)"
$BtnP.ForeColor = "#ffffff"
$BtnP.Add_Click({
    $TextArea.Text = $TextArea.Text + $TextBox.Text + "`$P"
})
$Main.Controls.Add($BtnP)

$BtnQ = New-Object System.Windows.Forms.Button
$BtnQ.Location = New-Object System.Drawing.Point(410, 150)
$BtnQ.Size = New-Object System.Drawing.Size(50, 25)
$BtnQ.Text = "="
$BtnQ.ForeColor = "#ffffff"
$BtnQ.Add_Click({
    $TextArea.Text = $TextArea.Text + $TextBox.Text + "`$Q"
})
$Main.Controls.Add($BtnQ)

$BtnS = New-Object System.Windows.Forms.Button
$BtnS.Location = New-Object System.Drawing.Point(470, 150)
$BtnS.Size = New-Object System.Drawing.Size(60, 25)
$BtnS.Text = "(Space)"
$BtnS.ForeColor = "#ffffff"
$BtnS.Add_Click({
    $TextArea.Text = $TextArea.Text + $TextBox.Text + "`$S"
})
$Main.Controls.Add($BtnS)

$BtnT = New-Object System.Windows.Forms.Button
$BtnT.Location = New-Object System.Drawing.Point(50, 250)
$BtnT.Size = New-Object System.Drawing.Size(150, 25)
$BtnT.Text =  ("Current Time:", $timef )
$BtnT.ForeColor = "#ffffff"
$BtnT.Add_Click({
    $TextArea.Text = $TextArea.Text + $TextBox.Text + "`$T"
})
$Main.Controls.Add($BtnT)

$BtnV = New-Object System.Windows.Forms.Button
$BtnV.Location = New-Object System.Drawing.Point(210, 250)
$BtnV.Size = New-Object System.Drawing.Size(150, 25)
$BtnV.Text =  ("Windows version number")
$BtnV.ForeColor = "#ffffff"
$BtnV.Add_Click({
    $TextArea.Text = $TextArea.Text + $TextBox.Text + "`$V"
})
$Main.Controls.Add($BtnV)

$Btnd = New-Object System.Windows.Forms.Button
$Btnd.Location = New-Object System.Drawing.Point(540, 150)
$Btnd.Size = New-Object System.Drawing.Size(50, 25)
$Btnd.Text = "$"
$Btnd.ForeColor = "#ffffff"
$Btnd.Add_Click({
    $TextArea.Text = $TextArea.Text + $TextBox.Text + "`$$"
})
$Main.Controls.Add($Btnd)

$Btnl = New-Object System.Windows.Forms.Button
$Btnl.Location = New-Object System.Drawing.Point(600, 150)
$Btnl.Size = New-Object System.Drawing.Size(50, 25)
$Btnl.Text = "\n"
$Btnl.ForeColor = "#ffffff"
$Btnl.Add_Click({
    $TextArea.Text = $TextArea.Text + $TextBox.Text + "`$_"
})
$Main.Controls.Add($Btnl)

$Main.ShowDialog() | Out-Null
