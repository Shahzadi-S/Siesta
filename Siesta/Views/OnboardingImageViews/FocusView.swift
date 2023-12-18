//
//  MemoriseView.swift
//  Siesta
//
//  Created by Sanaa Shahzadi on 17/12/2023.
//

import SwiftUI

enum AnimationPhase: CaseIterable {
    case start, middle, end
}

struct FocusView: View {
    @State private var animationStart = 0
    @State private var animateGreen = 0
    @State private var animateYellow = 0
    @State private var animateBlue = 0
    
    var body: some View {
        VStack {
            HStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.red)
                    .phaseAnimator(AnimationPhase.allCases, trigger: animationStart) { content, phase in
                        content
                            .opacity(phase == .middle ? 1 : 0.3)
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.animationStart = 1
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            self.animateGreen = 1
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            self.animateYellow = 1
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                            self.animateBlue = 1
                        }
                    }
                
                
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.green)
                    .phaseAnimator(AnimationPhase.allCases, trigger: animateGreen) { content, phase in
                        content
                            .opacity(phase == .middle ? 1 : 0.3)
                    }
            }
            HStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.yellow)
                    .phaseAnimator(AnimationPhase.allCases, trigger: animateYellow) { content, phase in
                        content
                            .opacity(phase == .middle ? 1 : 0.3)
                    }
                
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.blue)
                    .phaseAnimator(AnimationPhase.allCases, trigger: animateBlue) { content, phase in
                        content
                            .opacity(phase == .middle ? 1 : 0.3)
                    }
            }
        }
        .scaledToFit()
    }
}

#Preview {
    FocusView()
}
