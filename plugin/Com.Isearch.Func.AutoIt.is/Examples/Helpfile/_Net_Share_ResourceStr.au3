#include <GUIConstantsEx.au3>
#include <NetShare.au3>
#include <WindowsConstants.au3>

Global $g_idMemo

Example()

Func Example()
	Local $sServer, $sShare, $aInfo

	; Create GUI
	GUICreate("NetShare", 400, 300)

	; Create memo control
	$g_idMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($g_idMemo, 9, 400, 0, "Courier New")
	GUISetState(@SW_SHOW)

	; Get server and share information
	$sServer = InputBox("NetWork Demo", "Enter Server Name:", "\\MyServer", "", 200, 130)
	If @error Then Exit

	$sShare = InputBox("NetWork Demo", "Enter Share Name:", "MyShare", "", 200, 130)
	If @error Then Exit

	; Enumerate network connections
	$aInfo = _Net_Share_ConnectionEnum($sServer, $sShare)
	MemoWrite("Error ...................: " & @error)
	MemoWrite("Entries read ............: " & $aInfo[0][0])
	For $iI = 1 To $aInfo[0][0]
		MemoWrite("Connection ID ...........: " & $aInfo[$iI][0])
		MemoWrite("Connection type..........: " & _Net_Share_ResourceStr($aInfo[$iI][1]))
		MemoWrite("Number of files open ....: " & $aInfo[$iI][2])
		MemoWrite("Number of users .........: " & $aInfo[$iI][3])
		MemoWrite("Connection time .........: " & $aInfo[$iI][4])
		MemoWrite("Username ................: " & $aInfo[$iI][5])
		MemoWrite("Network name ............: " & $aInfo[$iI][6])
		MemoWrite()
	Next

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
EndFunc   ;==>Example

; Write message to memo
Func MemoWrite($sMessage = "")
	GUICtrlSetData($g_idMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
