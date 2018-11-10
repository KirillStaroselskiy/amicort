//
//  PhoneNumberProtocol.swift
//  AmicortApp
//
//  Created by MacBook on 10/11/2018.
//  Copyright © 2018 Kirill. All rights reserved.
//

import Foundation

protocol PhoneNumberProtocol: BaseProtocol {
    func onError (message: String, code: Int)
}
