//
//  InTheStation.swift
//
//
//  Created by Franco Miguel Guevarra on 1/23/24.
//

import Foundation
import SwiftUI

let inTheStation = Lesson(
    id: "inTheStation",
    title: "In the Station",
    icon: "figure.walk",
    quiz: inTheStationQuiz,
    content: [
        TextElement("""
        It's finally time to embark on your journey. The station can be confusing to navigate at first, but it'll get easier once you learn the common layouts and patterns of the station.
        
        Most stations are divided into three parts: the street level, mezzanine, and platforms.
        """),
        SubheadingElement("Entrances"),
        ImageGridElement(
            images: [
                ImageElement(
                    image: "Entrance_Classic",
                    caption: """
                    Classic subway entrance
                    © Jordan Rodriguez
                    """
                ),
                ImageElement(
                    image: "Entrance_Building",
                    caption: """
                    Subway entrance inside building
                    © Jordan Rodriguez
                    """
                )
            ]
        ),
        TextElement("""
        Most stations are easily recognizable by its iconic green staircase by the street. Other stations may be designed differently, and others may be located inside a building.

        Before entering, read the signs on the entrance. Some stations have dedicated entrances for specific trains and directions. The signage will also indicate any elevators or passageways to other stations.
        """),
        SubheadingElement("Mezzanine"),
        TextElement("""
        The entrance will lead to the mezzanine, where the ticketing area is. Larger stations may have stands or other public facilities.

        Just like entrances, a set of turnstiles might lead to a specific platform. Signage will show which platforms they lead to.
        """),
        ImageGridElement(
            images: [
                ImageElement(
                    image: "Mezzanine_MetroCard",
                    caption: """
                    MetroCard machines
                    © Jordan Rodriguez
                    """
                ),
                ImageElement(
                    image: "Mezzanine_Turnstile",
                    caption: """
                    Turnstiles for specific platform
                    © Jordan Rodriguez
                    """
                )
            ]
        ),
        TextElement("""
        You can head directly to the turnstiles and pay with contactless payment methods such as a credit card or Apple Pay, or go to a ticketing machine and get a MetroCard. You can also use an OMNY card which works similarly to the MetroCard and can be purchased in various retail stores in the city. Once you pay your fare, head to the turnstiles and swipe or tap your card to go through.
        """),
        TipElement(
            type: .safety,
            title: "Secure your belongings",
            content: """
            Put any loose items inside your bag and keep them in front of you at all times to avoid theft or loss.
            """
        ),
        SubheadingElement("Platforms"),
        ImageGridElement(
            images: [
                ImageElement(
                    image: "Platform_Signage",
                    caption: """
                    Signage with directions to platform
                    © Jordan Rodriguez
                    """
                ),
                ImageElement(
                    image: "Platform_Clock",
                    caption: """
                    Platform clock showing ETA of next train
                    © Jordan Rodriguez
                    """
                )
            ]
        ),
        TextElement("""
        After you go through the turnstiles, follow the signage to reach the platform you need. This can easily be the most confusing part of navigating the station.

        Signage will be marked by the services the platform serves and the direction of the train. Uptown and downtown are terms used to show that the train is going in the north and south direction of Manhattan respectively. The boroughs of New York City, such as Brooklyn and Queens, are also used to indicate where the train is heading towards. The arrow on the sign will tell you where to go to reach the platform.

        On the platform, there will be signs to tell you which side of the platform to stand on. Most stations will have timetables that show the service and end station of the next train and its estimated time of arrival.

        At this point, you should be entirely sure that you are at the right platform and are waiting for the right train. In the next lesson, we'll learn what to do when the train arrives.
        """),
        TipElement(
            type: .safety,
            title: "Keep your distance from the edge of the platform",
            content: """
            If someone or something falls onto the tracks, call 911 or locate the nearest station agent immediately. If a train is incoming, wave your phone flashlight to let them know.
            """
        )
    ]
)

let inTheStationQuiz = Quiz(
    type: .exercise,
    items: [
        QuizItem(
            question: """
            Which one of these is not true about this station entrance?
            """,
            image: ImageElement(
                image: "Quiz_Station_1",
                caption: """
                © Billy Wilson, licensed under [CC BY-NC 2.0](https://creativecommons.org/licenses/by-nc/2.0/)
                """
            ),
            choices: [
                "It serves \(Text.lineR) and \(Text.lineW)",
                "It provides access to other 23rd St. stations",
                "It leads to platforms that run towards Downtown & Brooklyn"
            ],
            correctAnswer: 1
        ),
        QuizItem(
            question: """
            What does "Downtown & Brooklyn" mean?
            """,
            image: ImageElement(
                image: "Quiz_Station_2",
                caption: ""
            ),
            choices: [
                "The train is headed south of Manhattan and towards Brooklyn",
                "The name of the line on the platform",
                "The train is headed to downtown Brooklyn"
            ],
            correctAnswer: 0
        ),
    ]
)
