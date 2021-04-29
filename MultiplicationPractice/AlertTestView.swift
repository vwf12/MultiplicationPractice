//
//  AlertTestView.swift
//  MultiplicationPractice
//
//  Created by FARIT GATIATULLIN on 02.04.2021.
//

import SwiftUI

extension Alert:Identifiable{
    public var id:String { "\(self)" }
}

struct AlertTestView: View {
    @State private var showingAlert = false
    @State private var activeAlert: ActiveAlert = .first
    @State var alert:Alert?

    var body: some View {
        Button(action: {
            if Bool.random() {
                alert = Alert(title: Text("Alert 1"))
            } else {
                alert = Alert(title: Text("Alert 2"))
            }
        }) {
            Text("Show random alert")
        }
        .alert(item:$alert) { $0 }
    }

    func showAlert(_ active: ActiveAlert) -> Void {
        DispatchQueue.global().async {
            self.activeAlert = active
            self.showingAlert = true
        }
    }
}
struct AlertTestView_Previews: PreviewProvider {
    static var previews: some View {
        AlertTestView()
    }
}
