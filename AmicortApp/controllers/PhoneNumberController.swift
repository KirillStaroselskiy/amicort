//
//  PhoneNumberController.swift
//  AmicortApp
//
//  Created by MacBook on 10/11/2018.
//  Copyright © 2018 Kirill. All rights reserved.
//

import Foundation

class PhoneNumberController {
    
    var view: PhoneNumberProtocol?
    
    init(view: PhoneNumberProtocol) {
        self.view = view
    }
    
    func onEnter(phoneNumber: String) {
        ApiClient.getSms(phone: phoneNumber)
    }
}
