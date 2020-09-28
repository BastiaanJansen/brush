//
//  SampleView.swift
//  Brush WatchKit Extension
//
//  Created by Bastiaan Jansen on 27/06/2020.
//

import SwiftUI
import HealthKit

struct SampleView: View {
    let sample: HKCategorySample
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack {
            Button(action: deleteSample) {
                Label("Delete", image: "trash.fill")
                    .foregroundColor(.red)
            }
        }
    }
    
    func deleteSample() {
        print("sample: " + String(sample.value))
        if HKHealthStore.isHealthDataAvailable() {
            let healthStore = HKHealthStore()
            healthStore.delete(sample) { success, error in
                if let error = error {
                    fatalError(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        } else {
            fatalError("Healthkit not available")
        }
    }
}

//struct SampleView_Previews: PreviewProvider {
//    static var previews: some View {
//        SampleView()
//    }
//}
