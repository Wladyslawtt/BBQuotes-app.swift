//
//  FetchView.swift
//  BBQuotes
//
//  Created by Vladyslav Tarabunin on 24/05/2025.
//

import SwiftUI
//זה היה פעם קווטויו
struct FetchView: View {
    let vm = ViewModel() //יבאנו את קובץ הויו מודל
    let show: String //הגדרנו ששמות הסדרות יהיו באותיות
    
    @State var showCharacterInfo = false//הגדנו שיופיע מידע על כל דמות כברירת מחדל זה חבוי
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{//בתמונה שמנו קוד שממיר את שם התמונה לאותיות קטנות בלי רווחים מהקובץ סטרינג אקס כדי שיהיה קל יותר לתכנה למצוא את התמונה
                Image(show.removeCaseAndSpace())
                    .resizable()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
                
                VStack{
                    VStack{
                        Spacer(minLength: 60)
                        
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                        case .fetching:
                            ProgressView()
                        case .successQuote://יבאנו את הציטוטים מהקובץ ויו מודל שהגדרנו למעלה
                            //הוספנו שני קווט כי קווט ראשון זה הסוג והקווט השני זה הקווט עצמו
                            
                            Text("\"\(vm.quote.quote)\"")
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 25))
                                .padding(.horizontal)
                            
                            ZStack(alignment: .bottom) {//פה אנו הבאנו את האדם והתמונה שלו מקובץ ויומודל שהוציא אותו מאתר
                                //הוספנו 0 כי זו התמונה הראשונה מהאתר שאנו רוצים שתופיע
                                AsyncImage(url: vm.character.images[0]) { image in
                                    image// כאן רשמנו קוד שיציג לנו את הסוג שנו רוצים
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {//כאן הוספנו קוד שיציג לנו את התמונה
                                    ProgressView()
                                }
                                .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                                
                                Text(vm.quote.character) //כאן הוספנו יציג את השם המתאים של האדם שבחרנו
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                            }
                            .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                            .clipShape(.rect(cornerRadius: 25))
                            .onTapGesture {
                                showCharacterInfo.toggle()//המידע על הדמות יופיע בלחיצה
                            }
                            //יבוא תצוגת פרק מתקייה אפיסודויו
                        case .successEpisode:
                            EpisodeView(episode: vm.episode)
                            
                        case .failed(let error):
                            Text(error.localizedDescription)
                        }
                        
                        
                        Spacer(minLength: 20)
                    }
                    HStack{
                        Button {//תסק מאפשר להריץ קוד שלא חוסם את הממשק הגרפי
                            Task{//צריך לשים תסק על פקודה אסינכרונית
                                await vm.getQuoteData(for: show)//קורא לפונקציה אסינכרונית גט דאטה של אובייקט ה-ויו מודל שמעבירה את הפרמטר שואו וממתין  לסיום הפעולה
                                //כשלוחצים על הכפתור מתבצעת קריאה אסינכרונית לפונקציה גט דאטה שמביאה נתונים  עבור שואו
                            }
                        }label:{
                            Text("Get Random Quote")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color("\(show.removeSpaces())Button"))//מתאים את הצבע שיצרנו באסטס
                                .clipShape(.rect(cornerRadius: 25))
                                .shadow(color://מתאים את הצבע שיצרנו באסטס
                                        Color("\(show.removeSpaces())Shadow"), radius: 2)
                        }
                        
                        Spacer()
                        
                        Button {//תסק מאפשר להריץ קוד שלא חוסם את הממשק הגרפי
                            Task{//צריך לשים תסק על פקודה אסינכרונית
                                await vm.getEpisode(for: show)//קורא לפונקציה אסינכרונית גט דאטה של אובייקט ה-ויו מודל שמעבירה את הפרמטר שואו וממתין  לסיום הפעולה
                                //כשלוחצים על הכפתור מתבצעת קריאה אסינכרונית לפונקציה גט פרק שמביאה נתונים  עבור שואו
                            }
                        }label:{
                            Text("Get Random Episode")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color("\(show.removeSpaces())Button"))//מתאים את הצבע שיצרנו באסטס
                                .clipShape(.rect(cornerRadius: 25))
                                .shadow(color://מתאים את הצבע שיצרנו באסטס
                                        Color("\(show.removeSpaces())Shadow"), radius: 2)
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer(minLength: 95)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .toolbarBackgroundVisibility(.visible, for: .tabBar) //שם שקיפות ללשונית למטה
        .sheet(isPresented: $showCharacterInfo){//מקפיץ את המידע מהויו מודל שהגדרנו מראש יחד עם השואו שגם הגדרנו
            //שיט זה חלונית קופצת הגרנו שזה המידע יופיע כחלונית קופצת
            CharacterView(character: vm.character, show: show)
        }
    }
}

#Preview {
    FetchView(show: Constants.bbName)
        .preferredColorScheme(.dark)
}
