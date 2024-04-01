//
//  Elements.swift
//  
//
//  Created by Franco Miguel Guevarra on 1/12/24.
//

import Foundation
import SwiftUI

class Element: Identifiable {
    var id: UUID
    
    init() {
        self.id = UUID()
    }
}

class TextElement: Element {
    var text: LocalizedStringKey
    
    init(_ text: LocalizedStringKey) {
        self.text = text
        super.init()
    }
}

class SubheadingElement: Element {
    var text: String
    
    init(_ text: String) {
        self.text = text
        super.init()
    }
}

class ListElement: Element {
    enum ListElementType {
        case unordered
        case ordered
    }
    
    var type: ListElementType
    var text: [LocalizedStringKey]
    
    init(type: ListElementType, text: [LocalizedStringKey]) {
        self.type = type
        self.text = text
        super.init()
    }
}

class ImageElement: Element {
    var image: String
    var caption: LocalizedStringKey
    
    init(image: String, caption: LocalizedStringKey) {
        self.image = image
        self.caption = caption
        super.init()
    }
}

class ImageGridElement: Element {
    var images: [ImageElement]
    
    init(images: [ImageElement]) {
        self.images = images
        super.init()
    }
}
