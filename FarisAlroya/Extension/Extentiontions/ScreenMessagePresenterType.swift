//
//  ScreenMessagePresenterType.swift
//  express-stores
//
//  Created by Hussein AlRyalat on 01/11/2021.
//

import UIKit

public enum PresentedMessageType {
    case success
    case failure

    var color: UIColor {
        switch self {
        case .success:
            return #colorLiteral(red: 0, green: 0.5086244345, blue: 0, alpha: 1)
        case .failure:
            return .red
        }
    }
}

/**
 A type that presents a message into the screen, using alert or toast like.
 */
protocol ScreenMessagePresenterType: AnyObject {
    func show(message: String, messageType: PresentedMessageType)
}

extension UIViewController: ScreenMessagePresenterType {
    func show(message: String?, messageType: PresentedMessageType) {
        if let message = message {
            self.show(message: message, messageType: messageType)
        }
    }

    func show(message: String, messageType: PresentedMessageType) {
        CardMessagePresenter().show(message: message, messageType: messageType)
    }
}
