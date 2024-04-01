//
//  RidingTheTrain.swift
//
//
//  Created by Franco Miguel Guevarra on 2/14/24.
//

import Foundation
import SwiftUI

let ridingTheTrain = Lesson(
    id: "ridingTheTrain",
    title: "Riding The Train",
    icon: "tram.fill",
    quiz: ridingTheTrainQuiz,
    content: [
        SubheadingElement("Boarding"),
        ImageGridElement(
            images: [
                ImageElement(
                    image: "Train_Display",
                    caption: """
                    Train display showing service and end station
                    © Jordan Rodriguez
                    """
                ),
                ImageElement(
                    image: "Train_StripMap",
                    caption: """
                    Overhead train map
                    © [NYC Subway Guide](https://www.nycsubwayguide.com)
                    """
                )
            ]
        ),
        TextElement("""
        Once your train arrives, the symbol of the service it runs will be at the front. Most trains will also indicate the service on the windows on its side, as well as the last station it will serve. The conductor will also announce this information including the train’s next stop.
        """),
        TipElement(
            type: .etiquette,
            title: "Let others exit first",
            content: """
            Letting others exit first makes it easier for the train to make room for those who need to board.
            """
        ),
        TextElement("""
        After making sure it’s the right train, you can board. Inside the train, overhead displays or maps indicate the next stations and information about them. Pay attention to these or the conductor’s announcements so you don’t miss your stop.
        """),
        SubheadingElement("Exiting"),
        TextElement("""
        Once you’ve arrived at your station, exit the train and follow the signs marked clearly with the word EXIT. The sign will also be accompanied by services you can transfer to. You’ll have to go through the turnstiles or revolving doors to exit but wont need to swipe or tap your card. On the mezzanine level, exit signs have landmarks or street names to show where you’ll be exiting.
        """),
        TipElement(
            type: .safety,
            title: "Stay in public, well-lit areas",
            content: """
            If travelling alone and/or late at night, make yourself seen by others. If you feel uncomfortable, go to a safe area.
            """
        ),
        TextElement("""
        Thats it! You’ve successfully learned how to ride the New York Subway. But we’re not done yet. In the next lesson, we’ll learn how to stay safe and maintain etiquette on your trip.
        """)
    ]
)


let ridingTheTrainQuiz = Quiz(
    type: .exercise,
    items: [
        QuizItem(
            question: """
            What's the best way to know if the train on the platform is the right one?
            """,
            choices: [
                "Look at the displays on its windows",
                "Ask a stranger or the station agent",
                "Look at the platform timetable to see which train arrived"
            ],
            correctAnswer: 0
        ),
        QuizItem(
            question: """
            Do we need to swipe or tap our card before we exit through the turnstiles?
            """,
            choices: [
                "Yes, at all times",
                "Yes, only if you need to transfer",
                "Not at all"
            ],
            correctAnswer: 2
        ),
    ]
)
