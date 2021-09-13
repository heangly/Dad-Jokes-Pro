//
//  HapticFeedback.swift
//  FunnyDadJokes
//
//  Created by Heang Ly on 9/12/21.
//

import UIKit

struct HapticFeedback {
    static func selectionChanged() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }

    static func selectionChangedLight() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    static func selectionChangedMedium() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    static func selectionChangedHeavy() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    static func success(){
        let generator = UINotificationFeedbackGenerator()
          generator.notificationOccurred(.success)
    }
    
    static func warning(){
        let generator = UINotificationFeedbackGenerator()
          generator.notificationOccurred(.warning)
    }
    
    static func error(){
        let generator = UINotificationFeedbackGenerator()
          generator.notificationOccurred(.error)
    }
}
