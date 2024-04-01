//
//  IconCircle.swift
//  Wayfinder
//
//  Created by Franco Miguel Guevarra on 1/12/24.
//

import SwiftUI

struct IconCircle: View {
    
    var icon: String
    
    var body: some View {
        Image(systemName: icon)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .font(.system(size: 18))
            .background {
                Circle()
                    .fill(Color.accentColor)
                    .frame(width: 40, height: 40)
            }
        
        
    }
}

struct FinalQuizIcon: View {
    
    var body: some View {
        Image(systemName: "checkmark.seal.fill")
            .resizable()
            .fontWeight(.medium)
            .foregroundStyle(Color.accentColor)
            .frame(width: 45, height: 45)
            .background {
                Circle()
                    .fill(.white)
                    .padding(10)
            }
        
        
    }
}

#Preview {
    FinalQuizIcon()
}
