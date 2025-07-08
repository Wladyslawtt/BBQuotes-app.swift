//
//  CharacterView.swift
//  BBQuotes
//
//  Created by Vladyslav Tarabunin on 24/05/2025.
//

import SwiftUI

struct CharacterView: View {
    let character: Char
    let show: String
    
    var body: some View {
        GeometryReader{ geo in
            ScrollViewReader { proxy in //שם גולל אוטומטי
                ZStack(alignment: .top){
                    Image(show.removeCaseAndSpace())
                        .resizable()
                        .scaledToFit()
                    
                    ScrollView{//פה אנו הבאנו את האדם והתמונה שלו מקובץ ויומודל שהוציא אותו מאתר
                        //שמנו פור איטצ כדי שנוכל לראות את כל התמונות של האדם
                        //הוספנו טאבויו כדי שיהיה אפשר לדפדף בין התמונות
                        //והסלפ זה אומר שזה נביא את כל התמונות מעצמו כלומר מהאתר כי אסור לרשום סתם כתובת אינטרנט אלא במקום שמים סלפ
                        TabView{
                            ForEach(character.images, id: \.self){ characterImageURL
                                in
                                AsyncImage(url: characterImageURL) { image in
                                    image// כאן רשמנו קוד שיציג לנו את הסוג שנו רוצים
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {//כאן הוספנו קוד שיציג לנו את התמונה
                                    ProgressView()
                                }
                            }
                        }
                        .tabViewStyle(.page)
                        .frame(width: geo.size.width/1.2, height: geo.size.height/1.7)
                        .clipShape(.rect(cornerRadius: 25))
                        .padding(.top, 60)
                        
                        VStack(alignment: .leading) {
                            Text(character.name)//כאון הבנו את השם של הדמות
                                .font(.largeTitle)
                            //כאן הוספנו את השם של היוצר
                            Text("Portrayed By: \(character.portrayedBy)")
                                .font(.subheadline)
                            
                            Divider()//שם פס לפיצול
                            //כאן הוספנו את השם של הדמות והפרטים שלה
                            Text("\(character.name) Character Info")
                            
                            Text("Born: \(character.birthday)")
                            
                            Divider()
                            
                            Text("Occupations:")
                            //הבאנו את כל העבודות שלו ושמנו כל עבודה תחת כוכבית
                            ForEach(character.occupations,id: \.self) { occupation in
                                Text("• \(occupation)")
                                    .font(.subheadline)
                            }
                            
                            Divider()
                            
                            Text("Nicknames:")
                            //                        שמנו איף כי לא לכולם יש הרבה שמות
                            //אז מה שזה אומר שאם יש יותר מ0 שמות זה אמור להראות כל שם בכוכבית
                            if character.aliases.count > 0 {
                                //הבאנו את כל השמות שלו ושמנו כל שם תחת כוכבית
                                ForEach(character.aliases,id: \.self) { alias in
                                    Text("• \(alias)")
                                        .font(.subheadline)
                                }
                            }else{//אם אין כלום אז יופיע כלום
                                Text("None")
                                    .font(.subheadline)
                            }
                            
                            Divider()
                            //זו לשונית שפותחת עוד סעיף ניסתר במקרה שלנו הוא נמצא בסוף
                            DisclosureGroup("Status (Spoiler Alert!):") {
                                VStack(alignment: .leading) {
                                    Text(character.status)
                                        .font(.title2)
                                    
                                    if let death = character.death {//הקוד הזה מביא את תמונת המוות של הדמות אם יש לו
                                        AsyncImage(url: death.image) { image in
                                            image// כאן רשמנו קוד שיציג לנו את הסוג שנו רוצים
                                                .resizable()
                                                .scaledToFill()
                                                .clipShape(.rect(cornerRadius: 15))
                                                .onAppear{//מפעיל את הגולל האוטומטי כשהכל יטען על המסך
                                                    //פרוקסי כי זה מה שהגדרנו לגולל האוטומטי
                                                    //1 כי זה המספר הסידורי של המסך שהגדרנו למטה
                                                    //ובטומ זה לאן אנחנו רוצים שזה יגלול
                                                    withAnimation{//הוספנו אנימציה לגלילה
                                                        proxy.scrollTo(1,anchor: .bottom)
                                                    }
                                                }
                                        } placeholder: {//כאן הוספנו קוד שיציג לנו את התמונה
                                            ProgressView()
                                        }
                                        //קוד זה מביא את פרטי המוות
                                        Text("How: \(death.details)")
                                            .padding(.bottom, 7)
                                        //קוד זה מביא את המילים האחרונות שלו
                                        Text("Last Words: \"\(death.lastWords)\"")
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .tint(.primary)
                        }
                        .frame(width: geo.size.width/1.25, alignment: .leading)
                        .padding(.bottom,50)
                        .id(1)//נותן מספר סידורי למסך שלנו שתחת הגולל האוטומטי
                    }
                    .scrollIndicators(.hidden)//מסתיר את הגולל
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CharacterView(character: ViewModel().character, show: Constants.bbName)
}
