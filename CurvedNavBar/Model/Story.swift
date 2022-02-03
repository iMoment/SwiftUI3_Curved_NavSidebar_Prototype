//
//  Story.swift
//  CurvedNavBar
//
//  Created by Stanley Pan on 2022/02/03.
//

import SwiftUI

struct Story: Identifiable {
    var id: String = UUID().uuidString
    var image: String
    var title: String
}

var stories = [
    Story(image: "pic01", title: "Manhattan Highrise Living Room"),
    Story(image: "pic02", title: "Los Angeles Apartment Kitchen"),
    Story(image: "pic03", title: "Seoul 2-Room Condo Bedroom"),
    Story(image: "pic04", title: "Tokyo Mansion Dining Room"),
]
