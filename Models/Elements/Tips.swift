//
//  Tips.swift
//
//
//  Created by Franco Miguel Guevarra on 2/20/24.
//

import SwiftUI

enum TipType {
    case safety
    case etiquette
    
    var titleView: some View {
        switch self {
        case .safety:
            HStack {
                Image(systemName: "checkmark.shield.fill")
                Text("Safety First")
            }
            .font(.callout)
            .fontWeight(.semibold)
            .foregroundStyle(.green)
        case .etiquette:
            HStack {
                Image(systemName: "figure.2.arms.open")
                Text("Etiquette")
            }
            .font(.callout)
            .fontWeight(.semibold)
            .foregroundStyle(.blue)
        }
    }
    
    var color: Color {
        switch self {
        case .safety:
            Color.green
        case .etiquette:
            Color.blue
        }
    }
}

class TipElement: Element {
    var type: TipType
    var title: String
    var content: String
    
    init(type: TipType, title: String, content: String) {
        self.type = type
        self.title = title
        self.content = content
        super.init()
    }
}

struct TipElementView: View {
    
    var element: TipElement
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            element.type.titleView
                .padding(.bottom, 5)
            
            Text(element.title)
                .fontWeight(.semibold)
            Text(element.content)
        }
        .font(.callout)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(element.type.color)
                .opacity(0.15)
        }
    }
}
