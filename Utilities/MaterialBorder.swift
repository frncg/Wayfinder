//
//  MaterialBorder.swift
//
//
//  Created by Franco Miguel Guevarra on 1/13/24.
//

import SwiftUI

struct MaterialBorder: ViewModifier {
    var radius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .stroke(.secondary, lineWidth: 1)
                    .opacity(0.2)
            }
    }
}

extension View {
    func materialBorder(radius: CGFloat) -> some View {
        modifier(MaterialBorder(radius: radius))
    }
}
