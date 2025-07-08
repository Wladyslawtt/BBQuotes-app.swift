//
//  Char.swift
//  BBQuotes
//
//  Created by Vladyslav Tarabunin on 24/05/2025.
//

import Foundation

struct Char: Decodable{ //מפאנח גייסון
    let name: String //המידע שאנו רוצים שיוצג מגייסון
    let birthday: String
    let occupations: [String]
    let images: [URL]
    let aliases: [String]
    let status: String
    let portrayedBy: String
    var death: Death? // nil initially
    //הסימן שאלה הוא סימן אופציונלי מוסיפים אותו כשלא לכל נתון יש את המתשנה אז מוסיפים סימן אופציונלי שרק למי שיהיה נתון הוא יציג אותו.
    
    //שני הקודים אנום ואינט אלו שני קודים שהגדרנו בוויומודל בסוף היה צריך לרשם רק ינט וזה מילא את שני הקודים האלה כאן אם נרצה לשנות בהגדרות משהו שהגדרנו בוויומודל
    enum CodingKeys: CodingKey {
        case name
        case birthday
        case occupations
        case images
        case aliases
        case status
        case portrayedBy
    }
    //במקרה שלנו אנו שינינו את דס הוספנו לו קוד כדי שכן יציג משהו של דס
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.birthday = try container.decode(String.self, forKey: .birthday)
        self.occupations = try container.decode([String].self, forKey: .occupations)
        self.images = try container.decode([URL].self, forKey: .images)
        self.aliases = try container.decode([String].self, forKey: .aliases)
        self.status = try container.decode(String.self, forKey: .status)
        self.portrayedBy = try container.decode(String.self, forKey: .portrayedBy)
       
        //כאן נוצר מופע חדש של גייסוןדיקוד, מחלקה שממירה נתוני גייסון לאובייקטים של סוויפט.
        let deathDecoder = JSONDecoder()
        //הגדרה זו אומרת לדקודר שכשמזהים מפתחות קייס בקובץ הגייסון הם יומרו מסנייק קייס לקאמל קייס.
        deathDecoder.keyDecodingStrategy = .convertFromSnakeCase
        //כאן נטען קובץ גייסון בשם סאמפדס גייסון מתוך המשאבים באנדל של האפליקציה והופכים אותו לאובייקט מסוג דאטה.
        //טריי עם סימן קריאה אומר שהתוכנית תקרוס אם תהיה שגיאה  לדוגמה אם הקובץ לא קיים.
        //שים לב שהדיקודר תמיד יהיה תואם לקובץ גייסון שאנו רוצים להשתמש אחרת האפליקציה תקרוס
        let deathData = try! Data(contentsOf: Bundle.main.url(forResource: "sampledeath", withExtension: "json")!)
        //כאן מנסים לפענח לעשות דיקוד את הנתונים שנטענו לקובץ דסטדאטה ולהמיר אותם לאובייקט מסוג דס.
        death = try deathDecoder.decode(Death.self, from: deathData)
//        self.death = try container.decodeIfPresent(Death.self, forKey: .death)
    }
}
