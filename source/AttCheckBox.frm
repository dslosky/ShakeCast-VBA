VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} AttCheckBox 
   Caption         =   "Select Facility Attributes"
   ClientHeight    =   5880
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   4680
   OleObjectBlob   =   "AttCheckBox.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "AttCheckBox"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False







Private Sub AllButton_Click()

For Each cont In Me.AttFrame.Controls
    If TypeOf cont Is MSForms.CheckBox Then
        cont.Value = True
    End If
Next cont

End Sub

Private Sub AttFrame_Click()

End Sub

Private Sub CancelButton_Click()

    Unload Me

    
End Sub

Private Sub ClearButton_Click()
' un-select all the group names

For Each cont In Me.AttFrame.Controls
    If TypeOf cont Is MSForms.CheckBox Then
        cont.Value = False
    End If
Next cont

End Sub
Private Sub OkayButton_Click()

If Me.Caption = "Select Facility Attributes" Then

    Set myFrame = AttForm.AttFrame
    Dim contStr As String
    contStr = ""
    For Each cont In myFrame.Controls
        If TypeOf cont Is MSForms.Label Or TypeOf cont Is MSForms.TextBox Then
        'Cont.Delete
            myFrame.Controls(cont.Name).Name = cont.Name & "DELETE"
        End If
    Next cont
    
    
    ' edit attribute string
    Dim attStr As String
    Dim attArr() As String
    Dim eachAtt() As String
    
    attStr = ActiveCell.Value
    attArr = Split(attStr, "%")
    
    
    Dim i As Integer
    i = 0
    
    
    For Each Control In Me.AttFrame.Controls
        If TypeOf Control Is MSForms.CheckBox Then
            If Control.Value = True Then
                
                Set lab = myFrame.Controls.Add("Forms.Label.1", "CheckBox_" & i)
                lab.Caption = Control.Caption
                lab.Left = 5
                lab.Top = 5 + (i * 28)
                lab.Font.Size = 12
                lab.Height = 23
                
                Set txtbox = myFrame.Controls.Add("Forms.TextBox.1", Control.Caption)
                txtbox.Left = 150
                txtbox.Top = 5 + (i * 28)
                txtbox.Font.Size = 12
                txtbox.Height = 23
                i = i + 1
                
                For Each cont In myFrame.Controls
                    If TypeOf cont Is MSForms.TextBox Then
                        If Control.Caption & "DELETE" = cont.Name Then
                            txtbox.Text = myFrame.Controls(cont.Name).Text
                        End If
                    End If
                Next cont
            
            End If
        End If
    Next Control
    
    For Each cont In myFrame.Controls
        If (TypeOf cont Is MSForms.Label Or TypeOf cont Is MSForms.TextBox) And _
                InStr(cont.Name, "DELETE") Then
           AttForm.Controls.Remove cont.Name
        End If
    Next cont
        
        
    Dim totalHeight As Integer
    totalHeight = 5
    
    For Each cont In AttForm.AttFrame.Controls
    
        If TypeOf cont Is MSForms.Label Then
            totalHeight = totalHeight + 28
        End If
    
    Next cont
    
    If totalHeight > AttForm.AttFrame.Height Then
        AttForm.AttFrame.ScrollHeight = totalHeight
    End If
ElseIf Me.Caption = "Select Facility Types" Then

    Dim facString As String
    Dim facCount As Integer
    
    facCount = 0
    For Each Control In Me.AttFrame.Controls
        If TypeOf Control Is MSForms.CheckBox Then
            If Control.Value = True Then
            
                If facCount = 0 Then
                    facString = Control.Caption
                    facCount = facCount + 1
                Else
                    facString = facString & "," & Control.Caption
                    facCount = facCount + 1
                End If
                
            End If
        End If
    Next Control
    
    ActiveCell.Value = facString
    
    Application.ScreenUpdating = False
    CheckGroups
    Application.ScreenUpdating = True
End If
    
Unload Me
End Sub

Private Sub UserForm_Initialize()


' get rid of any checkboxes that currently exist
For Each Control In Me.AttFrame.Controls
    If TypeOf Control Is MSForms.CheckBox Then
    Control.Delete
    End If
Next Control

If InStr(ActiveCell.Address, "AE") And ActiveSheet.Range("A1").Value = "Facility Worksheet" Then
    makeAttCheck
ElseIf InStr(ActiveCell.Address, "B") And ActiveSheet.Range("A1").Value = "Notification Worksheet" Then
    makeFacTypesForm
End If

End Sub
