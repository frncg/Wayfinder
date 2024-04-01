//
//  Quiz.swift
//
//
//  Created by Franco Miguel Guevarra on 1/17/24.
//

import Foundation
import SwiftUI
import ConfettiSwiftUI

enum QuizType {
    case exercise
    case finalQuiz
}

class QuizItem: Identifiable {
    var id: UUID
    var question: LocalizedStringKey
    var image: ImageElement?
    var choices: [LocalizedStringKey]
    var correctAnswer: Int
    
    init(question: LocalizedStringKey, image: ImageElement? = nil, choices: [LocalizedStringKey], correctAnswer: Int) {
        self.id = UUID()
        self.question = question
        self.image = image
        self.choices = choices
        self.correctAnswer = correctAnswer
    }
}

class Quiz {
    var type: QuizType
    var items: [QuizItem]
    
    init(type: QuizType, items: [QuizItem]) {
        self.type = type
        self.items = items
    }
}

@available(iOS 17.0, *)
struct QuizView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @Environment(CourseProgress.self) var courseProgress
    var quiz: Quiz
    
    @State var currentQuestion: Int = 0
    @State var selectedAnswer: Int = 0
    @State var showingResults: Bool = false
    @State var quizComplete: Bool = false
    @State var confetti: Int = 0
    @State var showImage: Bool = false
    
    var body: some View {
        switch quiz.type {
        case .exercise:
            ExerciseView
        case .finalQuiz:
            FinalQuizView
        }
    }
    
    var ExerciseView: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Exercise")
                
                Spacer()
                
                Button("Dismiss", systemImage: "xmark.circle.fill") {
                    dismiss()
                }
                .font(.largeTitle)
                .symbolRenderingMode(.hierarchical)
                .labelStyle(.iconOnly)
                .fontWeight(.medium)
                .tint(.secondary)
            }
            .font(.title2)
            .fontWeight(.semibold)
            
            Divider()
            
            if !quizComplete {
                QuestionView
                    .transition(.push(from: .trailing))
            } else {
                QuizCompletedView
                    .transition(.push(from: .trailing))
            }
            
            Spacer()
        }
        .task {
            if courseProgress.progress.contains(courseProgress.currentItem) {
                quizComplete = true
            }
        }
    }
    
    var FinalQuizView: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                if !quizComplete {
                    HStack(spacing: 10) {
                        Text("Final Quiz")
                            .fontWeight(.bold)
                        
                        FinalQuizIcon()
                    }
                    .font(.largeTitle)
                    .transition(.opacity)
                    
                    QuestionView
                        .transition(.push(from: .trailing))
                        .padding(.top, 30)
                } else {
                    QuizCompletedView
                        .transition(.push(from: .trailing))
                }
                
                Spacer()
            }
            .frame(maxWidth: 600)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding(.top, 10)
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.hidden)
            .onAppear {
                if courseProgress.finalQuiz {
                    quizComplete = true
                }
            }
        }
    }
    
    var QuestionView: some View {
        VStack {
            let item = quiz.items[currentQuestion]
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Question \(currentQuestion + 1) of \(quiz.items.count)")
                    .font(.subheadline)
                Text(item.question)
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if let imageElement = item.image {
                VStack(alignment: .leading, spacing: 7) {
                    Image(imageElement.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 150)
                        .frame(maxWidth: 700)
                        .materialBorder(radius: 12)
                    
                    if imageElement.caption != "" {
                        Text(imageElement.caption)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                
                
            }
            
            VStack(spacing: 10) {
                ForEach(item.choices.indices, id: \.self) { index in
                    let choice = item.choices[index]
                    let isCorrectAnswer = item.choices.firstIndex(of: choice) == item.correctAnswer
                    let isSelectedAnswer = item.choices.firstIndex(of: choice) == selectedAnswer
                    
                    Button {
                        if !showingResults {
                            selectedAnswer = item.choices.firstIndex(of: choice)!
                            withAnimation(.snappy) {
                                showingResults = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                
                                withAnimation(.smooth) {
                                    if isCorrectAnswer {
                                        if currentQuestion + 1 < quiz.items.count {
                                            currentQuestion += 1
                                        } else {
                                            switch quiz.type {
                                            case .exercise:
                                                courseProgress.updateProgress(with: courseProgress.currentItem)
                                            case .finalQuiz:
                                                courseProgress.finalQuiz = true
                                            }
                                            
                                            quizComplete = true
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                if confetti == 0 {
                                                    confetti = 1
                                                }
                                            }
                                        }
                                    }
                                    showingResults = false
                                }
                            }
                        }
                        
                    } label: {
                        HStack(alignment: .center) {
                            Text(choice)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            if showingResults && isSelectedAnswer {
                                Image(systemName: isCorrectAnswer ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    .foregroundStyle(isCorrectAnswer ? .green : .red)
                            }
                            
                        }
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 25)
                        .frame(height: 85)
                        .background {
                            if showingResults && isSelectedAnswer {
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(isCorrectAnswer ? .green : .red)
                                    .opacity(0.3)
                            } else {
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(Color(UIColor.secondarySystemBackground))

                            }
                            
                        }
                        .tint(.primary)
                    }
                    .disabled(showingResults && !isSelectedAnswer ? true : false)
                }
            }
            .padding(.top, 15)
        }
        .id(currentQuestion)
        .padding(.top, 10)
    }
    
    var QuizCompletedView: some View {
        VStack(alignment: .center, spacing: 15) {
            
            switch quiz.type {
            case .exercise:
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(Color.accentColor)
                    .confettiCannon(
                        counter: $confetti,
                        num: 40,
                        openingAngle: Angle(
                            degrees: 0
                        ),
                        closingAngle: Angle(
                            degrees: 360
                        ),
                        radius: 180
                    )
                
                Text("You have completed this exercise")
                    .font(.title3)
                
                HStack {
                    Button("Restart", systemImage: "arrow.clockwise") {
                        withAnimation(.smooth) {
                            resetQuiz()
                        }
                    }
                    
                    if courseProgress.currentItem < Course.count - 1 {
                        Button("Continue", systemImage: "chevron.forward") {
                            dismiss()
                            courseProgress.currentItem += 1
                        }
                    } else {
                        Button("Final Quiz", systemImage: "text.badge.checkmark") {
                            dismiss()
                            courseProgress.currentSection = .finalQuiz
                        }
                    }
                        
                }
                .buttonStyle(.bordered)
                .tint(.accentColor)
                .controlSize(.large)
                .padding(.top, 15)
            case .finalQuiz:
                FinalQuizIcon()
                    .confettiCannon(
                        counter: $confetti,
                        num: 70,
                        openingAngle: Angle(
                            degrees: 0
                        ),
                        closingAngle: Angle(
                            degrees: 360
                        ),
                        radius: 240
                    )
                
                Text("You have completed the course!")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                
                HStack {
                    Button("Restart Quiz", systemImage: "arrow.clockwise") {
                        withAnimation(.smooth) {
                            resetQuiz()
                        }
                    }
                }
                
                .buttonStyle(.bordered)
                .tint(.accentColor)
                .controlSize(.large)
                .padding(.top, 15)
            }
            
                
            
        }
        .padding(.vertical, 80)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    func resetQuiz() {
        currentQuestion = 0
        selectedAnswer = 0
        showingResults = false
        quizComplete = false
        confetti = 0
    }
}

let finalQuiz = Quiz(
    type: .finalQuiz,
    items: [
        QuizItem(
            question: """
            Which trains stop at stations marked by a white circle?
            """,
            choices: [
                "Local trains only",
                "Express trains only",
                "Both Local and Express trains"
            ],
            correctAnswer: 2
        ),
        QuizItem(
            question: """
            The subway offers free transfers within how many hours of paying your fare.
            """,
            choices: [
                "Two",
                "Two and a half",
                "Three"
            ],
            correctAnswer: 0
        ),
        QuizItem(
            question: """
            What do we need to make sure before entering a station or going through a turnstile?
            """,
            choices: [
                "That they lead to the right platform",
                "That the trains it runs aren't affected by a service change",
                "Both of the above"
            ],
            correctAnswer: 2
        ),
        QuizItem(
            question: """
            This display shows what information?
            """,
            image: ImageElement(
                image: "FinalQuiz_4",
                caption: """
                © LogicalRailfan, licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0)
                """
            ),
            choices: [
                "The symbol and name of the service",
                "The symbol and the end station of the service",
                "The symbol of the service and the current station"
            ],
            correctAnswer: 1
        ),
        QuizItem(
            question: """
            What should we do when someone falls onto the tracks and a train is incoming?
            """,
            choices: [
                "Wave your flashlight towards the train",
                "Jump down and save them",
                "Ask the person on the tracks to start running"
            ],
            correctAnswer: 0
        ),
    ]
)
