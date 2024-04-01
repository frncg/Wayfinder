//
//  ReadingTheMap.swift
//
//
//  Created by Franco Miguel Guevarra on 1/17/24.
//

import Foundation
import SwiftUI

let readingTheMap = Lesson(
    id: "readingTheMap",
    title: "Reading the Map",
    icon: "point.topleft.down.to.point.bottomright.curvepath",
    quiz: readingTheMapQuiz,
    content: [
        TextElement("""
        The subway has a whopping 472 stations and 36 lines. However, it’s surprisingly easy to navigate once you get a hold of how the system operates. Open the sidebar to find the system map!
        """),
        SubheadingElement("Lines and Services"),
        SymbolGridElement([
            (images: ["Symbol_Line"], label: "Line"),
            (images: ["Symbol_Local"], label: "Local Service"),
            (images: ["Symbol_Express"], label: "Express Service")
        ]),
        TextElement("""
        As opposed to most metro systems, the subway lines do not represent a route, its services (commonly referred to as “trains”) do. It’s very important to know that routes are denoted by their letter or number, not by their color. While the Broadway-7th Ave trains \(Text.line1+Text.line2+Text.line3) may have same color, they have different end stations and ultimately different routes.

        Additionally, each train can either be local or express. **Local** trains stop on every station, while **Express** trains will skip stations for faster service. In the Broadway-7th Ave line, the \(Text.line1) is a local service, while the \(Text.line2+Text.line3) are express service.
        """),
        SubheadingElement("Stations"),
        SymbolGridElement([
            (images: ["Station_Local"], label: "Local station"),
            (images: ["Station_All"], label: "Local and Express station"),
            (images: ["Station_Full"], label: "Station info")
        ]),
        SymbolGridElement([
            (images: ["Station_Name"], label: "Station name"),
            (images: ["Station_Services"], label: "Station services\n(Full service in bold)"),
            (images: ["Station_Accessibility"], label: "Accessible station")
        ]),
        TextElement("""
        Each station on the map is marked by either a black or a white dot. Stations with a black dot show that only local trains stop, while those with a white dot show that both local and express trains stop.
        
        The services that stop at a station will be listed under the station name. Services in bold text indicate that the service will stop at the station full-time and those in thin text signify that the station is only served part-time.
        
        A wheelchair icon beside the services under the station name indicates that the station is ADA-accessible and features ramps and/or elevators.
        """),
        ImageElement(image: "Station_Multiple", caption: "Five 23rd St stations on different lines"),
        TextElement("""
        You might notice that station names are not unique. For example, there are five 23rd St stations each under different line and are located at different avenues.
        """),
        SubheadingElement("Transfers"),
        SymbolGridElement([
            (images: ["Transfer_Service"], label: "Transfer with multiple services"),
            (images: ["Transfer_Line"], label: "Transfer with multiple lines"),
            (images: ["Transfer_Complex"], label: "Transfer within complex"),
            (images: ["Transfer_OutOfSystem"], label: "Out-of-system transfer")
        ]),
        TextElement("""
        There are multiple types of station transfers on the subway. You can transfer in stations that serve multiple services or lines simply by switching platforms or between a group of stations called a station complex.
        
        In station complexes, passengers can transfer to another station without leaving the paid area through passageways. They are denoted by a solid black line connecting the stations. However, some stations allow transfer by exiting onto street level and walking to the other station. These are denoted by a white dashed line that resembles a ladder.
        """)
    ]
)

let readingTheMapQuiz = Quiz(
    type: .exercise,
    items: [
        QuizItem(
            question: """
            The 14th St station on the 6th Ave line (Orange) serves which trains?
            """,
            image: ImageElement(image: "Quiz_Map_1", caption: ""),
            choices: [
                "\(Text.lineF) and \(Text.lineM)",
                "\(Text.lineF) with part-time service for \(Text.lineM)",
                "\(Text.lineM) with part-time service for \(Text.lineF)"
            ],
            correctAnswer: 1
        ),
        QuizItem(
            question: """
            Transfer to the 14th St station on the Broadway-7th Ave line (Red) is best done by...
            """,
            image: ImageElement(image: "Quiz_Map_1", caption: ""),
            choices: [
                "Walking through a passageway",
                "Switching platforms",
                "Going onto street level and walking there"
            ],
            correctAnswer: 0
        ),
    ]
)
