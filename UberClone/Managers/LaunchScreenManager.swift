//
//  LaunchScreenPhase.swift
//  UberClone
//
//  Created by Tom Miller on 05/12/2022.
//

import Foundation

enum LaunchScreenPhase {
    case first
    case second
    case completed
}

final class LaunchScreenManager: ObservableObject {
    @Published var state: LaunchScreenPhase = .first
    
    func dismiss() {
        state = .second
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.state = .completed
        }
    }
}
