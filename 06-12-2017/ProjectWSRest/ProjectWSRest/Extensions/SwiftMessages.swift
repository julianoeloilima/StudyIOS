//
//  SwiftMessages.swift
//  ProjectWSRest
//
//  Created by Aloc SP08608 on 12/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import Foundation
import SwiftMessages

extension SwiftMessages {
    
    public static func successMessage(title: String, body: String) {
        SwiftMessages.message(title: title, body: body, theme: .success)
    }

    public static func infoMessage(title: String, body: String) {
        SwiftMessages.message(title: title, body: body, theme: .info)
    }

    public static func warningMessage(title: String, body: String) {
        SwiftMessages.message(title: title, body: body, theme: .warning)
    }

    public static func errorMessage(title: String, body: String) {
        SwiftMessages.message(title: title, body: body, theme: .error)
    }
    
    public static func message(title: String, body: String, theme: Theme) {
        let view = MessageView.viewFromNib(layout: MessageView.Layout.cardView)
        view.configureContent(title: title, body: body)
        view.button?.isHidden = true
        view.configureTheme(theme)
        view.configureDropShadow()
        SwiftMessages.show(view: view)
    }
    
}
