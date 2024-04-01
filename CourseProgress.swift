//
//  CourseProgress.swift
//  Wayfinder
//
//  Created by Franco Miguel Guevarra on 1/13/24.
//

import Foundation

enum CourseSection: Int {
    case lesson = 0
    case finalQuiz = 1
    case map = 2
}

@Observable
class CourseProgress {
    
    private(set) var progress: [Int] {
        didSet {
            let data = try? JSONEncoder().encode(progress)
            
            UserDefaults.standard.setValue(data, forKey: "CourseProgress")
        }
    }
    
    var currentSection: CourseSection {
        didSet {
            UserDefaults.standard.setValue(currentSection.rawValue, forKey: "CurrentSection")
        }
    }
    
    
    var currentItem: Int {
        didSet {
            UserDefaults.standard.setValue(currentItem, forKey: "CurrentItem")
        }
    }
    
    var finalQuiz: Bool {
        didSet {
            UserDefaults.standard.setValue(finalQuiz, forKey: "FinalQuiz")
        }
    }
    
    init() {
        currentItem = UserDefaults.standard.integer(forKey: "CurrentItem")
        currentSection = CourseSection(rawValue: UserDefaults.standard.integer(forKey: "CurrentSection")) ?? .lesson
        finalQuiz = UserDefaults.standard.bool(forKey: "FinalQuiz")
        
        if let progress = UserDefaults.standard.data(forKey: "CourseProgress") {
            let decoded = try? JSONDecoder().decode([Int].self, from: progress)
            self.progress = decoded ?? []
        } else {
            progress = []
        }

    }
    
    func updateProgress(with index: Int) {
        if !progress.contains(index) {
            progress.append(index)
        }
    }
    
    func resetProgress() {
        currentItem = 0
        currentSection = .lesson
        progress = []
        finalQuiz = false
    }
}
