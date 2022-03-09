//
//  Helper.swift
//  Onboarding
//
//  Created by Mohamed Elatabany on 09/03/2022.
//

import Foundation


class Helper {

    static func delay(durationInSeconds seconds: Double, execute: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: execute)
    }
    
}
