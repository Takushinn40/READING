//
//  Model.swift
//  HappyReading
//
//  Created by cmStudent on 2023/02/03.
//

import Foundation
import SwiftUI

struct NoteModel: Identifiable, Codable {
    var id = UUID()
    var writeTime: String
    var title : String
    var content : String
}
