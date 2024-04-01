//
//  CourseTabView.swift
//  Wayfinder
//
//  Created by Franco Miguel Guevarra on 1/12/24.
//

import SwiftUI

@available(iOS 17.0, *)
struct CourseTabView: View {
    
    @Environment(CourseProgress.self) var courseProgress
    
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(Course.indices, id: \.self) { index in
                LessonTab(index: index)
                
                ProgressTrack
            }
            EndTab()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .dynamicTypeSize(DynamicTypeSize.small...DynamicTypeSize.xxLarge)

    }
    
    // MARK: ProgressTrack - Line between course items
    var ProgressTrack: some View {
        Rectangle()
            .fill(Color.accentColor.opacity(0.2))
            .frame(width: 20, height: 70)
            .padding(.vertical, -40)
            .zIndex(-1)
            .frame(width: 45)
    }
}

@available(iOS 17.0, *)
struct LessonTab: View {
    
    @Environment(CourseProgress.self) var courseProgress
    var index: Int
    
    var body: some View {
        let lesson = Course[index]
        HStack(spacing: 13) {
            IconCircle(icon: lesson.icon)
                .frame(width: 45, height: 45)
            
            HStack(spacing: 7) {
                Text(lesson.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                        .symbolEffect(.disappear, isActive: !courseProgress.progress.contains(index))
         
            }
            .padding(.trailing, 5)
            .font(.title3)
            .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.snappy) {
                courseProgress.currentItem = index
                courseProgress.currentSection = CourseSection.lesson
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(UIColor.tertiarySystemFill))
                .padding(.horizontal, -10)
                .padding(.vertical, -12)
                .opacity(
                    index == courseProgress.currentItem && courseProgress.currentSection == .lesson ? 1 : 0
                )
        }
    }
}

struct EndTab: View {
    
    @Environment(CourseProgress.self) var courseProgress
    
    var body: some View {
        HStack(spacing: 13) {
            FinalQuizIcon()
            Text("Final Quiz")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.green)
                    .symbolEffect(.disappear, isActive: !courseProgress.finalQuiz)
                    .padding(.trailing, 5)
        }
        .fontWeight(.semibold)
        .font(.title3)
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.snappy) {
                courseProgress.currentSection = .finalQuiz
            }
            
        }
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(UIColor.tertiarySystemFill))
                .padding(-10)
                .opacity(
                    courseProgress.currentSection == .finalQuiz ?  1 : 0
                )
        }
    }
}

