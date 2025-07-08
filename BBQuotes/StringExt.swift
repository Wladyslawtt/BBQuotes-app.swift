//
//  StringExt.swift
//  BBQuotes
//
//  Created by Vladyslav Tarabunin on 05/06/2025.
//
// אקסטנשיון זה פשוט יצירת קובץ עם כל הפונקציות שאנחנו רוצים להשתמש בכל האפליקציה שלנו
extension String {// החץ לסרינג זה כי סטרינג זה אומר אותיות הפונקציה תחזיר אותיות
    func removeSpaces() -> String {//הפונ לוקחת מילה מוחקת רווחים ומחזירה מילה בלי רווחים
        self.replacingOccurrences(of: " ", with: "")
    }
    //השתמשנו רמוב ספייס מהפונ למעלה והוספנו גם להפןך אותיות גדולות לקטנות במילים שיחזיר
    func removeCaseAndSpace() -> String {//הפונ לוקחת מילה ומוחקת רווחים ואותיות גדולות
        self.removeSpaces().lowercased()
    }
}
