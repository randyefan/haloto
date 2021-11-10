//
//  Enum.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 01/11/21.
//

import Foundation

enum ProductLogin {
    case User
    case Bengkel
}

enum TextFieldState {
    case Editable
    case notEditable
}

enum ButtonState {
    case Yellow
    case Blue
    case BlueOutlined
    case GreyButton
    case Disabled
}

enum StarState {
    case active
    case inactive
}

enum FormCardType {
    case OTP
    case Login
}

enum PopUpListState: String {
    case model = "Model"
    case manufacturer = "Manufacturer"
    case service = "Service"
    case replaced = "Replaced"
    case newvehicle = "Add New Vehicle"
    case edit = "Edit"
}

enum ReusableConsultPopUpState {
    case request
    case accepted
    case declined
    case afterService
}

enum TimerType {
    case full
    case short
    case digits
}

enum ReceiptCardImage {
    case beforeScan
    case afterScan
}

enum EntryTextFieldType {
    case picker
    case keyboard
}
