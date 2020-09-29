//
//  SettingsView.swift
//  Brush WatchKit Extension
//
//  Created by Bastiaan Jansen on 27/06/2020.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var settingsVM = SettingsViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Duration").font(.callout).bold()
            Text("Set the duration for each session").font(.footnote).foregroundColor(.gray)
            
            Spacer()
            
            HStack(alignment: .firstTextBaseline) {
                Text(String(settingsVM.goalTime)).font(.largeTitle).bold().foregroundColor(.accentColor)
                Text("sec.").foregroundColor(.gray)
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    settingsVM.changeGoalTime(step: -settingsVM.goalTimeStep)
                }) {
                    Group() {
                        Image(systemName: "minus").font(.system(size: 25, weight: .bold))
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40, alignment: .center)
                    .background(Rectangle()
                                    .foregroundColor(Color("DarkGray"))).cornerRadius(10)
                }.buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    settingsVM.changeGoalTime(step: settingsVM.goalTimeStep)
                }) {
                    Group() {
                        Image(systemName: "plus").font(.system(size: 25, weight: .bold))
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40, alignment: .center)
                    .background(Rectangle()
                                    .foregroundColor(Color("DarkGray"))).cornerRadius(10)
                }.buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
