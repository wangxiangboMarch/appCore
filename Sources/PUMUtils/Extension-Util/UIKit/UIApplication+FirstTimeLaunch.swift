//
//  UIApplication+FirstTimeLaunch.swift
//  BSKAppCore
//
//  Created by εδΈζ on 2022/4/30.
//

import UIKit

extension UIApplication {
    public var isFirstTimeLaunch:Bool {
        let AppNotFirstTimeLaunchKey = "AppNotFirstTimeLaunch"
        let notFirstTime = UserDefaults.standard.bool(forKey: AppNotFirstTimeLaunchKey)
        if (!notFirstTime) {
            UserDefaults.standard.set(true, forKey: AppNotFirstTimeLaunchKey)
        }
        return !notFirstTime
    }
}
