//
//  Structs.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 16/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import Foundation

struct Teacher: Decodable {
    let id: Int?
    let name: String?
    let schoolId: Int?
    let teacherClass: String? // Keyword 'class' cannot be used as an identifier
    let imageUrl: String?
    var schoolName: String?
    var description: String?
    
    private enum CodingKeys : String, CodingKey {
        case id = "id", name = "name", schoolId = "schoolId", teacherClass = "class", imageUrl = "imageUrl", description = "description" // Did this because keyword 'class' cannot be used as an identifier
    }
}

struct Student: Decodable {
    let id: Int?
    let name: String?
    let schoolId: Int?
    let grade: Int?
    var description: String?
}

struct School: Decodable {
    let id: Int?
    let name: String?
    let imageUrl: String?
}
