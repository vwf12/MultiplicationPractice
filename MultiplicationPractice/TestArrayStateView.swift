////
////  TestArrayStateView.swift
////  MultiplicationPractice
////
////  Created by FARIT GATIATULLIN on 02.04.2021.
////
//
//import SwiftUI
//
//
//
//struct CContentView: View {
//    @State private var showingAlert = false
//    @State private var activeAlert: ActiveAlert = .first
//
//    var body: some View {
//        Button(action: {
//            self.showAlert(.first)
//        }, label: {
//            Text("button")
//            .alert(isPresented: $showingAlert) {
//                switch activeAlert {
//                    case .first:
//                        return Alert(title: Text("First Alert"), dismissButton: .default(Text("Next"), action: {
//                            self.showAlert(.second)
//                        }))
//                    case .second:
//                        return Alert(title: Text("Second Alert"), dismissButton: .default(Text("Next"), action: {
//                            self.showAlert(.third)
//                        }))
//                    case .third:
//                        return Alert(title: Text("Third Alert"), dismissButton: .default(Text("Ok"), action: {
//                            //...
//                        }))
//                }
//            }
//        })
//    }
//
//    func showAlert(_ active: ActiveAlert) -> Void {
//        DispatchQueue.global().async {
//            self.activeAlert = active
//            self.showingAlert = true
//        }
//    }
//}
//struct TestArrayStateView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestArrayStateView()
//    }
//}
