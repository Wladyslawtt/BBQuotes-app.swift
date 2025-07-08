//
//  FetchService.swift
//  BBQuotes
//
//  Created by Vladyslav Tarabunin on 25/05/2025.
//

import Foundation
//הוא מגדיר מבנה  בשם פטשסרוויס. בתוך המבנה הזה יש אנום בשם פטשארור שתואמת לפרוטוקול ארור.
//הקייס בד רספונס זה המאפיין של האנום שיסמן שגיאה אם תיהיה תשובה לא תקינה מהשרת
//פרייבט אומר שהאנום הזה זמין רק בתוך הקובץ שבו הוא מוגדר, ולא מחוצה לו.
struct FetchService {
    private enum FetchError: Error {
        case badResponse
    }
    //נתון שמושך נתונים מהאתר שהגדרנו
    //פרייבט אומר שהמשתנה בייסיואראל זמין רק בתוך הקובץ או המחלקה/ההקשר שבו הוא מוגדר
    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    //https://breaking-bad-api-six.vercel.app/api/quotes/random?production=Breaking+Bad
    //פונקציה אסינכרונית שיכולה לזרוק שגיאה ומחזירה אובייקט מסוג קוות
    //הגדרנו בסוגריים של הפונקציה מאיפה ואיזה סוג של מידע
    func fetchQuote(from show: String) async throws -> Quote {
        //MARK: -1 Build fetch url
        //יוצר כתובת יוראל עם הנתיב קוות ראנדום על בסיס בייס יואראל
        let quoteURL = baseURL.appending(path: "quotes/random")
        //היא יוצרת יו אראל חדש שמוסיף לשורת הבסיס בייס יואראל את הפרמטר פרודקשיין
        //הערך של פרודקשיין נקבע לפי מה שנשלח לפונקציה בפרמטר שואו.
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        //MARK: -2 Fetch data
        //הקוד הזה שולח בקשת רשת לכתובת פטסיואראל שהגדרנו למעלה, מחכה לתשובה, ושומר את התוצאה בשתי משתנים
        //דאטה זה תוכן התגובה לדוגמא גייסון
        //וריספונס זה מידע על התגובה לדוגמא קוד סטטוס איץ טיטי פי
        //טריי אומר שייתכן יהיו שגיאות אז יש לטפל בזה בטו דו כטש או להמשיך לזרוק שגיאה
        //אוויט מחכה לסיום הבקשה בצורה אסינכרונית מבלי לחסום את התכנית
        //יואראל סשיין שרד זה דרך לגשת למופע משותף של מנהל הבקשות של האייאוס
        //דאטה פרום שולח בקשת גט לכתובת פטש יואראל ומחזיר זוג ערכים של דאטה וריספונס
        let (data,response) = try await URLSession.shared.data(from: fetchURL)
        
        //MARK: -3 Handle response
        //הקוד מוודא שהתשובה מהשרת היא איץ טיטי פי  תקינה עם קוד 200. אם לא – הוא זורק שגיאה. זה עוזר לטפל רק בתשובות תקינות ולהימנע מעיבוד של תגובות שגויות.
        //מגארד ועד איץטיטיפי הוא מנסה להמיר ריספונס שהוא סוג של יואראלריספונס לאיץטיטיפי ריספונס שזה סוג שמכיל מידע על קוד סטטוס איץטיטיפי אם ההמרה נכשלה התנאי יכשל
        //ריספונס סטטוס 200 הוא בודק אם קוד הסטטוס הוא 200 שזה אומר שהתשובה מהשרת תקינה
        //אלס אומר שאם אחד התנאים למעלה לא מתקיים כלומר שהריספונס הוא לא איתטיטיפי ריספונס או שהסטטוס שונה מ200 אז יש לזרוק שגיאה מותאמת אישית שהגדרנו מראש למעלה בשם פטש ארור בד ריספונס
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        //MARK: -4 Decode data
        //הקוד מנסה לפאנח נתוני גייסון שנמצאים במשתנה דאטה שהגדרנו למעלה ולהפוך אותו לאובייקט מסוג קווט שיהיה אפשר לעבוד איתו בקלות
        //גייסון דיקודר היא פונרצייה שממירה נתוני גייסון לנתוני סוויפט שיהיה קל לעבוד איתם
        //דיקוד מנסה לפאנח את הגייסון בתוך הדאטה ולהמיר אותו למופע של מחלקה או מבנה קווט
        // הוספנו טריי כי יש סיכוי שהתהליך יכול להכשל אם הפרמטר לא תואם לקווט
        //הוספנו סלפ לקווט כדי להגיד לדיקוד לפאנח את הנתונים בסטנדרט הספציפי הזה כמו בתיקייה הזאת
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        //MARK: -5 Return quote
        //אם הכל מושלם והושלם הוא פשוט מחזיר לנו את הקווט שפואנח בסוג שאנחנו צריכים
        return quote
    }
    //MARK: - fetchCharacter
    //הפונקציה פטשקרקטר מוגדרת כאסינכרוני וסרואו, כלומר היא פועלת באופן אסינכרוני אסינק ויכולה לזרוק שגיאות סרואו היא מקבלת מחרוזת בשם ניימ ומחזירה אובייקט מסוג צאר מקובץ צאר
    //לט קרקטר יואראל יוצרים כתובת יואראל חדשה על בסיס בייס יואראל ומוסיפים לה את הנתיב קרקטר
    //לט פטר יואראל מוסיפים לשורת ה־יואראל פרמטר חיפוש קיורי פרמטר בשם ניימ עם הערך שהועבר לפונקציה.
    func fetchCharacter(_ name: String) async throws -> Char {
        let characterURL = baseURL.appending(path: "characters")
        let fetchURL = characterURL.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        //שים לב להסבר למעלה
        let (data,response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        //לט דיקודר יוצרים אובייקט מסוג גייסוןדיקודר, שתפקידו להמיר נתוני גייסון לאובייקטים של סוויפט
        let decoder = JSONDecoder()
//מגדירים אסטרטגיית המרה לשמות המפתחות בגייסון כמו
//        אם השם במבנה גייסון כתוב בצורה של סנייק קייס עם קו תחתון  המפענח ימיר אותו אוטומטית לקמל קייס כמו של סוויפט
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        //מנסים לפענח את הנתוני דאטה מאיי פי איי למערך של אובייקטים מסוג צאר
        //טריי נדרש כי הפעולה יכולה לזרוק שגיאה אם הנתונים לא תואמים למבנה המצופה
        let characters = try decoder.decode([Char].self, from: data)
        //מחזיר את הקרקטר הראשון ברשימה
        return characters[0]
    }
    //הפונקציה פטשדס  היא אסינכרונית אסינק ויכולה לזרוק שגיאות סרואו היא מקבל שם של קרקטר ומחזירה אובייקט מסוג דס עם סימן שאלה כלומר אופציונאלי יתכן שתחזיר דס ויתכן ניל אם לא תהיה תוצאה
    //יוצרת יואראל שמפנה לנתיב דס בכתובת הבסיס בייסיואראל.
    //קיצור אחרי הדוט קום מוסיפה סלש דס
    func fetchDeath(for character: String) async throws -> Death? {
        let fetchURL = baseURL.appending(path: "deaths")
        
        //שים לב להסבר למעלה
        let (data,response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        //לט דיקודר יוצרים אובייקט מסוג גייסוןדיקודר, שתפקידו להמיר נתוני גייסון לאובייקטים של סוויפט
        let decoder = JSONDecoder()
        //מגדירים אסטרטגיית המרה לשמות המפתחות בגייסון כמו
        //        אם השם במבנה גייסון כתוב בצורה של סנייק קייס עם קו תחתון  המפענח ימיר אותו אוטומטית לקמל קייס כמו של סוויפט
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                //מנסים לפענח את הנתוני דאטה מאיי פי איי למערך של אובייקטים מסוג דס
                //טריי נדרש כי הפעולה יכולה לזרוק שגיאה אם הנתונים לא תואמים למבנה המצופה
        let deaths = try decoder.decode([Death].self, from: data)
        //עובר על כל האובייקטים במערך דס ובודק אם שם הדמות דס קרקטר תואם לשם שחיפשנו קרקטר אם נמצאה התאמה הוא מחזיר אובייקט דס מתאים אם לא הוא מחזיר ניל
        for death in deaths {
            if death.character == character {
                return death
            }
        }
        //הקוד מחפש את פרטי המוות של דמות מסוימת בתוך רשימת מקרי מוות שהתקבלה מגייסון אם מוצא  מחזיר את המידע אם לא אז מחזיר ניל
        return nil
    }
    
    func fetchEpisode(from show: String) async throws -> Episode? {
        let episodeURL = baseURL.appending(path: "episodes")
        let fetchURL = episodeURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        //שים לב להסבר למעלה
        let (data,response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        //לט דיקודר יוצרים אובייקט מסוג גייסוןדיקודר, שתפקידו להמיר נתוני גייסון לאובייקטים של סוויפט
        let decoder = JSONDecoder()
//מגדירים אסטרטגיית המרה לשמות המפתחות בגייסון כמו
//        אם השם במבנה גייסון כתוב בצורה של סנייק קייס עם קו תחתון  המפענח ימיר אותו אוטומטית לקמל קייס כמו של סוויפט
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        //מנסים לפענח את הנתוני דאטה מאיי פי איי למערך של אובייקטים מסוג צאר
        //טריי נדרש כי הפעולה יכולה לזרוק שגיאה אם הנתונים לא תואמים למבנה המצופה
        let episodes = try decoder.decode([Episode].self, from: data)
        //מחזיר את הקרקטר הראשון ברשימה
        return episodes.randomElement()
    }
    
}
