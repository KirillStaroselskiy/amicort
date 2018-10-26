//
//  SelectNumberVC.swift
//  AmicortApp
//
//  Created by Kirill on 26/10/2018.
//  Copyright © 2018 Kirill. All rights reserved.
//

import UIKit

class SelectNumberVC: UIViewController{

    
    @IBOutlet weak var informText: UILabel!
    
    @IBOutlet weak var selectNumber: UITextField!
    @IBOutlet weak var enter: UIButton!
    @IBOutlet weak var registration: UIButton!
    
    var myPhoneNumber = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        texFieldSetup()
    }
    
    func texFieldSetup(){
        selectNumber.delegate = self
        selectNumber.keyboardType = .phonePad
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SelectNumberVC: UITextFieldDelegate{
    

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == self.selectNumber) && textField.text == ""{
            textField.text = "+7(" //your country code default
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
            if textField == selectNumber {
                let res = phoneMask(phoneTextField: selectNumber, textField: textField, range, string)
                myPhoneNumber = res.phoneNumber != "" ? "+\(res.phoneNumber)" : ""
               // print("Phone - \(myPhoneNumber)  MaskPhone=\(res.maskPhoneNumber)")
            if (res.phoneNumber.count == 11) || (res.phoneNumber.count == 0) {
                //phone number entered or completely cleared
                //print("EDIT END: Phone = \(myPhoneNumber)  MaskPhone = \(res.maskPhoneNumber)")
            }
            return res.result
        }
        return true
    }
    
    
    
}

extension UITextFieldDelegate {
    
    func phoneMask(phoneTextField: UITextField, textField: UITextField, _ range: NSRange, _ string: String) -> (result: Bool, phoneNumber: String, maskPhoneNumber: String) {
        
        let oldString = textField.text!
        let newString = oldString.replacingCharacters(in: Range(range, in: oldString)!, with: string)
        
        //in numString only Numeric characters
        let components = newString.components(separatedBy: CharacterSet.decimalDigits.inverted)
        let numString = components.joined(separator: "")
        
        let length = numString.count
        let maxCharInPhone = 11
        
        if newString.count < oldString.count { //backspace to work
            if newString.count <= 2 { //if now "+7(" and push backspace
                phoneTextField.text = ""
                return (false, "", "")
            } else {
                return (true, numString, newString) //will not in the process backspace
            }
        }
        
        if length > maxCharInPhone { // input is complete, do not add characters
            return (false, numString, newString)
        }
        var indexStart, indexEnd: String.Index
        var maskString = "", template = ""
        var endOffset = 0
        
        if newString == "+" { // allow add "+" if first Char
            maskString += "+"
        }
        //format +X(XXX)XXX-XXXX
        if length > 0 {
            maskString += "+"
            indexStart = numString.index(numString.startIndex, offsetBy: 0)
            indexEnd = numString.index(numString.startIndex, offsetBy: 1)
            maskString += String(numString[indexStart..<indexEnd]) + "("
        }
        if length > 1 {
            endOffset = 4
            template = ")"
            if length < 4 {
                endOffset = length
                template = ""
            }
            indexStart = numString.index(numString.startIndex, offsetBy: 1)
            indexEnd = numString.index(numString.startIndex, offsetBy: endOffset)
            maskString += String(numString[indexStart..<indexEnd]) + template
        }
        if length > 4 {
            endOffset = 7
            template = "-"
            if length < 7 {
                endOffset = length
                template = ""
            }
            indexStart = numString.index(numString.startIndex, offsetBy: 4)
            indexEnd = numString.index(numString.startIndex, offsetBy: endOffset)
            maskString += String(numString[indexStart..<indexEnd]) + template
        }
        var nIndex: Int
        nIndex = 7
                    //format +X(XXX)XXX-XX-XX  -> if need uncoment
                    nIndex = 9

                    if length > 7 {
                        endOffset = 9
                        template = "-"
                        if length < 9 {
                            endOffset = length
                            template = ""
                        }
                        indexStart = numString.index(numString.startIndex, offsetBy: 7)
                        indexEnd = numString.index(numString.startIndex, offsetBy: endOffset)
                        maskString += String(numString[indexStart..<indexEnd]) + template
                    }
        
        if length > nIndex {
            indexStart = numString.index(numString.startIndex, offsetBy: nIndex)
            indexEnd = numString.index(numString.startIndex, offsetBy: length)
            maskString += String(numString[indexStart..<indexEnd])
        }
        phoneTextField.text = maskString
        if length == maxCharInPhone {
            //dimiss kayboard
            phoneTextField.endEditing(true)
            return (false, numString, newString)
        }
        return (false, numString, newString)
    }
}
