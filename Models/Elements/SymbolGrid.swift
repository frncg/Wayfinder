//
//  SymbolGrid.swift
//
//
//  Created by Franco Miguel Guevarra on 1/13/24.
//

import SwiftUI

class SymbolGridElement: Element {
    var symbols: [(images: [String], label: String)]
    
    init(_ symbols: [(images: [String], label: String)]) {
        self.symbols = symbols
        super.init()
    }
}

struct SymbolGridElementView: View {
    
    var symbols: [(images: [String], label: String)]
    
    var body: some View {
        HStack(alignment: .top, spacing: 25) {
            ForEach(symbols, id: \.label) { symbol in
                VStack(alignment: .center, spacing: 10) {
                    HStack {
                        ForEach(symbol.images, id: \.self) { image in
                            Image(image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 65)
                        }
                    }
                    
                    Text(symbol.label)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.vertical, 20)
    }
}
