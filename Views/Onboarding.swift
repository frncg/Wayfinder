//
//  Onboarding.swift
//  Wayfinder
//
//  Created by Franco Miguel Guevarra on 1/23/24.
//

import Foundation
import SwiftUI


fileprivate let onboardingData: [(symbol: String, title: String, text: String)] = [
    (
        symbol: "lightbulb.fill",
        title: "Simple Lessons",
        text: "Wayfinder features four short lessons presented in an easy-to-digest format."
    ),
    (
        symbol: "text.badge.checkmark",
        title: "Exercises",
        text: "Test your knowledge with exercises at the end of each lesson and complete the course with the Final Quiz."
    ),
    (
        symbol: "figure.2",
        title: "Friendly and Accessible",
        text: "This app is designed to be fun, easy to navigate, and with accessibility in mind."
    )
]

struct Onboarding: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 10) {
                HStack(alignment: .lastTextBaseline, spacing: 5) {
                    Text("Wayfinder")
                    Image(systemName: "train.side.front.car")
                        .foregroundStyle(Color.accentColor)
                }
                .font(.largeTitle)
                .fontWeight(.bold)
                
                Text("Learn how to ride the New York City Subway")
            }
            .padding(.bottom, 10)
            
            VStack(spacing: 40) {
                ForEach(onboardingData, id: \.title) { tile in
                    HStack(spacing: 20) {
                        Image(systemName: tile.symbol)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color.accentColor)
                            .symbolRenderingMode(.hierarchical)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(tile.title)
                                .fontWeight(.semibold)
                            Text(tile.text)
                                .foregroundStyle(.secondary)
                        }
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .font(.callout)
                }
            }
            .frame(maxWidth: 700)
            .padding(.vertical, 10)
            
            Button("Continue") {
                dismiss()
            }
            .frame(maxWidth: .infinity)
            .buttonStyle(.bordered)
            .tint(.accentColor)
            .controlSize(.large)
            
            Text("""
            Disclaimer: Subway symbols, graphics, and map data used are property of the MTA. Images used adhere to individual licensing terms. Lessons adapted and some images sourced with permission from [NYC Subway Guide.](https://www.nycsubwayguide.com)
            """)
            .font(.caption)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 100)
        .padding(.vertical, 30)
        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
        
    }
}

#Preview {
    Onboarding()
}
