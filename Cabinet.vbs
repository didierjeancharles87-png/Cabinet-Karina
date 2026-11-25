' Lanceur du Cabinet Dentaire : demarre le serveur (cache) puis ouvre l'application.
Option Explicit
Dim sh, fso, base, php, phpdir, port, url, silent, i, running, cmd
Set sh = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
base = fso.GetParentFolderName(WScript.ScriptFullName)
port = "8080"
url = "http://localhost:" & port & "/"
silent = (WScript.Arguments.Count > 0)

php = ""
If fso.FileExists(base & "\php\php.exe") Then
  php = base & "\php\php.exe"
ElseIf fso.FileExists("C:\xampp\php\php.exe") Then
  php = "C:\xampp\php\php.exe"
End If
If php = "" Then
  MsgBox "PHP est introuvable." & vbCrLf & vbCrLf & "Lisez le fichier LISEZ-MOI-WINDOWS.txt (etape 1) : telechargez PHP et copiez son contenu dans le dossier 'php' a cote de ce fichier.", 48, "Cabinet Dentaire"
  WScript.Quit
End If
phpdir = fso.GetParentFolderName(php)

Function IsRunning()
  Dim http
  IsRunning = False
  On Error Resume Next
  Set http = CreateObject("MSXML2.ServerXMLHTTP")
  http.setTimeouts 500, 500, 1000, 1000
  http.open "GET", "http://127.0.0.1:" & port & "/login.php", False
  http.send
  If Err.Number = 0 Then
    If InStr(http.responseText, "_csrf") > 0 Then IsRunning = True
  End If
  On Error GoTo 0
End Function

running = IsRunning()
If Not running Then
  cmd = """" & php & """ -c """ & base & "\php\php.ini"" -d ""extension_dir=" & phpdir & "\ext"" -S 0.0.0.0:" & port & " -t """ & base & "\cabinet"" """ & base & "\cabinet\router.php"""
  sh.CurrentDirectory = base & "\cabinet"
  sh.Run cmd, 0, False
  For i = 1 To 30
    WScript.Sleep 500
    If IsRunning() Then running = True : Exit For
  Next
  If Not running Then
    MsgBox "Le serveur n'a pas demarre (port " & port & " occupe ou PHP incomplet)." & vbCrLf & "Double-cliquez sur 'Diagnostic.bat' et envoyez-moi ce qui s'affiche.", 48, "Cabinet Dentaire"
    WScript.Quit
  End If
End If

If silent Then WScript.Quit

Dim browsers, b, done
browsers = Array(sh.ExpandEnvironmentStrings("%ProgramFiles(x86)%") & "\Microsoft\Edge\Application\msedge.exe", _
                 sh.ExpandEnvironmentStrings("%ProgramFiles%") & "\Microsoft\Edge\Application\msedge.exe", _
                 sh.ExpandEnvironmentStrings("%ProgramFiles%") & "\Google\Chrome\Application\chrome.exe", _
                 sh.ExpandEnvironmentStrings("%ProgramFiles(x86)%") & "\Google\Chrome\Application\chrome.exe", _
                 sh.ExpandEnvironmentStrings("%LocalAppData%") & "\Google\Chrome\Application\chrome.exe")
done = False
For Each b In browsers
  If fso.FileExists(b) Then
    sh.Run """" & b & """ --app=" & url, 1, False
    done = True : Exit For
  End If
Next
If Not done Then sh.Run url, 1, False

