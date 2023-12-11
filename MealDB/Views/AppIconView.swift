//  AppIconView.swift
//  MealDB
//  Created by Zaid Naing on 11/21/23.

import SwiftUI
///App icon Gallery
struct AppIconView: View {
    let appIcons: [AlternativeAppIcons] = [
        AlternativeAppIcons(appIconName: "AppIcon1", scrollIconName: "icon1"),
        AlternativeAppIcons(appIconName: "AppIcon2", scrollIconName: "icon2"),
        AlternativeAppIcons(appIconName: "AppIcon3", scrollIconName: "icon3"),
        AlternativeAppIcons(appIconName: "AppIcon4", scrollIconName: "icon4")]
    
    var body: some View {
        ZStack{
            AnimatedBackground()
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
            VStack{
                Text("Choose an icon")
                    .font(.title)
                    .bold()
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 20){
                        ForEach(appIcons) { icon in
                            VStack{
                                Button{
                                    UIApplication.shared.setAlternateIconName(icon.appIconName)
                                }label:{
                                    Image(icon.scrollIconName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 70, height: 70)
                                        .clipShape(.rect(cornerRadius: 15))
                                }
                            }
                        }
                    }
                }
                .padding(20)
            }
        }
    }
}

#Preview {
    AppIconView()
}
