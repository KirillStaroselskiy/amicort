//
//  SmsController.swift
//  AmicortApp
//
//  Created by MacBook on 10/11/2018.
//  Copyright © 2018 Kirill. All rights reserved.
//

import Foundation

class SmsController {
    
    var smsView: SmsProtocol?
    
    init (view: SelectSmsCodeVC) {
        smsView = view
    }
    
    func apiGet(success: Bool) {
        if success {
            smsView?.smsCorrect(data: "sd")
        } else {
            smsView?.onError(code: 412)
        }
    }
}

