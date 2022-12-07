//
//  NotificationsName+Extensions.swift
//  PaynetOne
//
//  Created by Duoc Nguyen  on 24/11/2022.
//

import Foundation

extension Notification.Name {
    static let userInterfaceStyle = Notification.Name("userInterfaceStyle")

}

enum UserInterfaceStyle{
    case DARKMOD,LIGHT,NOTHING
}
