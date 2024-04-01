//
//  MakingARoute.swift
//
//
//  Created by Franco Miguel Guevarra on 2/17/24.
//

import Foundation
import SwiftUI

let makingARoute = Lesson(
    id: "makingARoute",
    title: "Making A Route",
    icon: "mappin.and.ellipse",
    quiz: makingARouteQuiz,
    content: [
        TextElement("""
        Before we head out, we need to create a route to bring us to our destination. Luckily we have navigation apps, such as Apple Maps or the MTA’s official MyMTA app to do the work for us, but we can also figure out the route ourselves using what we learned in the previous lesson.

        Start your route with the station most accessible to you. Some people choose to walk to a different station if the one closest to them is busy. Then identify the station closest to your destination. Connect your starting point to your destination, paying attention to the services and transfers you need to take along the way. The subway includes a free transfer within 2 hours of paying your fare if you need it.
        """),
        ImageElement(
            image: "ServiceChanges",
            caption: """
            Service changes on weekends and late nights
            © MTA
            """
        ),
        TextElement("""
        It’s important to know that the subway runs differently on weekends and late nights. The MTA will also regularly announce any other planned service changes due to maintenance or unexpected disruptions. The announcements will include alternative travel routes for your convenience. Make sure to check these information beforehand to ensure a smooth ride.
        """)
    ]
)

let makingARouteQuiz = Quiz(
    type: .exercise,
    items: [
        QuizItem(
            question: """
            Why do some people start at a station other than the one closest to them?
            """,
            choices: [
                "Because the station closest to them is busy",
                "Because the station is affected by a service change",
                "Both of the above"
            ],
            correctAnswer: 2
        ),
        QuizItem(
            question: """
            Which services should we take if we need to take the \(Text.lineF) on a weekday at 1am.
            """,
            image: ImageElement(image: "Quiz_Route", caption: ""),
            choices: [
                "\(Text.lineA) \(Text.lineC) \(Text.lineD) \(Text.lineQ)",
                "\(Text.lineA) \(Text.lineD) \(Text.lineQ)",
                "\(Text.lineC) \(Text.lineD) \(Text.lineQ)"
            ],
            correctAnswer: 1
        )
    ]
)
