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
    
    private enum CodingKeys : String, CodingKey {
        case id = "id", name = "name", schoolId = "school_id", teacherClass = "class", imageUrl = "image_url" // Did this because keyword 'class' cannot be used as an identifier
    }
}

struct Student: Decodable {
    let id: Int?
    let name: String?
    let schoolId: Int?
    let grade: Int?
}
