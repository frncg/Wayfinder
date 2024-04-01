//
//  Course.swift
//  
//
//  Created by Franco Miguel Guevarra on 1/12/24.
//

import Foundation

let Course: [Lesson] = [
    readingTheMap,
    makingARoute,
    inTheStation,
    ridingTheTrain
]

class Lesson: Identifiable {
    var id: String
    var title: String
    var icon: String
    var quiz: Quiz
    var content: [Element]
    
    init(id: String, title: String, icon: String, quiz: Quiz, content: [Element]) {
        self.id = id
        self.title = title
        self.icon = icon
        self.quiz = quiz
        self.content = content
    }
}

extension Lesson: Hashable, Equatable {
    static func == (lhs: Lesson, rhs: Lesson) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
