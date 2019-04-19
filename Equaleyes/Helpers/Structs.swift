//
//  Structs.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 16/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import Foundation

struct Teacher: Codable {
    let id: Int?
    let name: String?
    let schoolId: Int?
    let teacherClass: String? // Keyword 'class' cannot be used as an identifier
    let imageUrl: String?
    var description: String?
    var school: School?
    
    private enum CodingKeys : String, CodingKey {
        case id = "id", name = "name", schoolId = "schoolId", teacherClass = "class", imageUrl = "imageUrl", description = "description" // Did this because keyword 'class' cannot be used as an identifier
    }
}

struct Student: Codable {
    let id: Int?
    let name: String?
    let schoolId: Int?
    let grade: Int?
    var description: String?
    var school: School?
}

struct School: Codable {
    let id: Int?
    let name: String?
    let imageUrl: String?
}
