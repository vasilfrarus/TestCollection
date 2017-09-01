//
//  ChatControllerView.swift
//  TestCollection
//
//  Created by Admin on 01/09/2017.
//  Copyright © 2017 1C Rarus. All rights reserved.
//

import UIKit

final class ChatControllerView: UIView {
    
    var bmaInputAccessoryView: UIView?
    
    override var inputAccessoryView: UIView? {
        return self.bmaInputAccessoryView
    }
}

