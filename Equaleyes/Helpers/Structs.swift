//
//  Structs.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 16/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit

struct Teacher: Codable, DisplayablePerson {
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
    
    var shortInfoAttributedString: NSAttributedString? {
        get {
            let shortInfoMutableAttributedString = NSMutableAttributedString()
            
            if let teacherNameString = name {
                let techerNameLocalizedString = teacherNameString + "\n"
                shortInfoMutableAttributedString.append(techerNameLocalizedString.customAttributedString(font: Font.header, textColor: UIColor.darkGray))
            }
            
            if let teacherClassString = teacherClass {
                let teacherClassLocalizedString = "class".localizedString() + ": " + teacherClassString + "\n"
                shortInfoMutableAttributedString.append(teacherClassLocalizedString.customAttributedString(font: Font.content, textColor: UIColor.darkGray))
            }
            
            if let teacherSchoolNameString = school?.name {
                let teacherSchoolNameLocalizedString = "school".localizedString() + ": " + teacherSchoolNameString
                shortInfoMutableAttributedString.append(teacherSchoolNameLocalizedString.customAttributedString(font: Font.content, textColor: UIColor.darkGray))
            }
            
            return shortInfoMutableAttributedString
        }
    }
    
    var longInfoAttributedString: NSAttributedString? {
        get {
            let longInfoMutableAttributedString = NSMutableAttributedString()
            
            if let teacherDescriptionString = description {
                let longInfoTitleLocalizedString = "details_about_title".localizedString() + "\n"
                longInfoMutableAttributedString.append(longInfoTitleLocalizedString.customAttributedString(font: Font.header, textColor: UIColor.darkGray))
                
                let teacherDescriptionLocalizedString = "\(String(describing: teacherDescriptionString))"
                longInfoMutableAttributedString.append(teacherDescriptionLocalizedString.customAttributedString(font: Font.content, textColor: UIColor.darkGray))
            }
            
            return longInfoMutableAttributedString
        }
    }
    
    var schoolImageUrl: String? {
        get {
            return school?.imageUrl
        }
    }
    
    var isContactable: Bool {
        get {
            return true
        }
    }
}

struct Student: Codable, DisplayablePerson {
    let id: Int?
    let name: String?
    let schoolId: Int?
    let grade: Int?
    var description: String?
    var school: School?
    
    var shortInfoAttributedString: NSAttributedString? {
        get {
            let shortInfoMutableAttributedString = NSMutableAttributedString()
            
            if let studentNameString = name {
                let studentNameLocalizedString = studentNameString + "\n"
                shortInfoMutableAttributedString.append(studentNameLocalizedString.customAttributedString(font: Font.header, textColor: UIColor.darkGray))
            }
            
            if let studentGradeInt = grade {
                let teacherClassLocalizedString = "grade".localizedString() + ": " + "\(studentGradeInt)" + "\n"
                shortInfoMutableAttributedString.append(teacherClassLocalizedString.customAttributedString(font: Font.content, textColor: UIColor.darkGray))
            }
            
            if let studentSchoolNameString = school?.name {
                let schoolNameLocalizedString = "school".localizedString() + ": " + studentSchoolNameString
                shortInfoMutableAttributedString.append(schoolNameLocalizedString.customAttributedString(font: Font.content, textColor: UIColor.darkGray))
            }
            
            return shortInfoMutableAttributedString
        }
    }
    
    var longInfoAttributedString: NSAttributedString? {
        get {
            let longInfoMutableAttributedString = NSMutableAttributedString()
            
            if let studentDescriptionString = description {
                let longInfoTitleLocalizedString = "details_about_title".localizedString() + "\n"
                longInfoMutableAttributedString.append(longInfoTitleLocalizedString.customAttributedString(font: Font.header, textColor: UIColor.darkGray))
                
                let studentDescriptionLocalizedString = "\(String(describing: studentDescriptionString))"
                longInfoMutableAttributedString.append(studentDescriptionLocalizedString.customAttributedString(font: Font.content, textColor: UIColor.darkGray))
            }
            
            return longInfoMutableAttributedString
        }
    }
    
    var schoolImageUrl: String? {
        get {
            return school?.imageUrl
        }
    }
    
    var isContactable: Bool {
        get {
            return false
        }
    }
}

struct School: Codable {
    let id: Int?
    let name: String?
    let imageUrl: String?
}
