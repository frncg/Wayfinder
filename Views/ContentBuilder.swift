//
//  ContentBuilder.swift
//  Wayfinder
//
//  Created by Franco Miguel Guevarra on 1/13/24.
//

import SwiftUI

@available(iOS 17.0, *)
struct ContentBuilder: View {
    
    @Environment(CourseProgress.self) var courseProgress
    var lesson: Lesson
    @State var quizOpen = false
    
    var body: some View {
        GeometryReader { geometry in
            Content
                .frame(maxWidth: 750)
                .padding(.horizontal, geometry.size.width * 0.13)
                .frame(maxWidth: .infinity, alignment: .top)
                .background(Color(UIColor.secondarySystemGroupedBackground))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .navigation) {
                        Button("Previous", systemImage: "chevron.backward") {
                            courseProgress.currentItem -= 1
                        }
                        .disabled(
                            !(courseProgress.currentItem > 0)
                        )
                        
                        Button("Previous", systemImage: "chevron.forward") {
                            courseProgress.currentItem += 1
                        }
                        .disabled(
                            !(courseProgress.currentItem < Course.count - 1)
                        )
                    }
                }
                .toolbarBackground(geometry.size.width > 800 ? .hidden : .automatic)
        }
    }
    
    var Content: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text(lesson.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.trailing, 12)
                        
                        IconCircle(icon: lesson.icon)
                    }
                    .padding(.bottom, 10)
                    .transition(.opacity)
                    
                    ElementBuilder
                    
                    Button {
                        withAnimation(.snappy) {
                            quizOpen = true
                        }
                    } label: {
                        HStack {
                            Text("Start Exercise")
                            Image(systemName: "text.badge.checkmark")
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .frame(height: 45)
                    }
                    .buttonStyle(.bordered)
                    .tint(Color.accentColor)
                    
                    Divider()
                    
                    HStack(spacing: 25) {
                        if lesson != Course.first {
                            Button("Previous", systemImage: "chevron.backward") {
                                courseProgress.currentItem -= 1
                            }
                        }
                        
                        Spacer()
                        
                        if lesson != Course.last {
                            Button {
                                courseProgress.currentItem += 1
                            } label: {
                                HStack {
                                    Text("Next")
                                    Image(systemName: "chevron.forward")
                                }
                            }
                        } else {
                            Button {
                                withAnimation(.snappy) {
                                    courseProgress.currentSection = .finalQuiz
                                }   
                            } label: {
                                HStack {
                                    Text("Final Quiz")
                                    Image(systemName: "chevron.forward")
                                }
                            }
                        }
                    }
                    .controlSize(.large)
                    
                    
                }
                .id(lesson)
                .padding(.top, 10)
                .padding(.bottom, 30)
                .padding(.horizontal, 15)
                .animation(.snappy, value: lesson)
                .sheet(isPresented: $quizOpen) {
                    QuizView(quiz: lesson.quiz)
                        .padding([.leading, .top, .trailing], 40)
                        .ignoresSafeArea()
                }
            }
            .onChange(of: lesson) {
                proxy.scrollTo(lesson, anchor: .top)
            }
        }

    }
    
    var ElementBuilder: some View {
        ForEach(lesson.content) { element in
            
            if let body = element as? TextElement {
                Text(body.text)
                    .font(.callout)
                    .lineSpacing(3.5)
            }
            
            if let subheading = element as? SubheadingElement {
                Text(subheading.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top, 10)
            }
            
            if let list = element as? ListElement {
                ForEach(list.text.indices, id: \.self) { line in
                    HStack(alignment: .top) {
                        Text(list.type == .unordered ? "• " : "\(line + 1). ")
                        Text(list.text[line])
                            .font(.callout)
                            .lineSpacing(3.5)
                    }
                    .padding(.horizontal, 20)
                }
            }
            
            if let image = element as? ImageElement {
                VStack(alignment: .leading, spacing: 10) {
                    Image(image.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .materialBorder(radius: 12)
                    
                    Text(image.caption)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: 375)
                .padding(.vertical, 10)
            }
            
            if let images = element as? ImageGridElement {
                LazyVGrid(columns: [GridItem(alignment: .top), GridItem(alignment: .top)]) {
                    ForEach(images.images) { image in
                        VStack(alignment: .leading, spacing: 10) {
                            Image(image.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .materialBorder(radius: 8)
                                
                            
                            Text(image.caption)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            
            if let symbolGrid = element as? SymbolGridElement {
                SymbolGridElementView(symbols: symbolGrid.symbols)
            }
            
            if let tip = element as? TipElement {
                TipElementView(element: tip)
            }
        }
        .transition(.opacity)
    }
}

