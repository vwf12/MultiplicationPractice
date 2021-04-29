
import SwiftUI

struct SwiftUIView: View {
    @State private var multiplicator = 1
    @State private var questionCountSelector = 0
    let questionCount = ["5","10","20"]
    @State private var gameStarted = false

    @State private var questionTable:[String] = []
    @State private var questionCounter = 1
    @State private var userAnswer = ""
    @State private var message = ""
    @State private var showAlert = false
    @State private var selectedQuestion = ""

    var body: some View {
        VStack(alignment: .center){
            Group{
                if !gameStarted{
                    Form{
                        Section(header: Text("Choose Multiplicator")
                            .padding(.leading, 100)
                            .font(.headline)){
                                HStack{
                                    Stepper("Choose multiplicator", value: $multiplicator, in: 1...12)
                                        .labelsHidden()
                                    Text("up to \(multiplicator) `s  table")
                                }.padding(.leading, 80)
                        }

                        Section(header: Text("Select Questions")
                            .padding(.leading, 100)
                            .font(.headline)){
                                Picker("Select Questions", selection: $questionCountSelector){
                                    ForEach(0..<questionCount.count){
                                        Text(self.questionCount[$0])
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .labelsHidden()
                        }
                        HStack{
                            Spacer()
                            Button(action: {
                                self.start()
                            }){
                                Text(gameStarted ? "Start" : "Start Over")
                                    .background(Color.blue)
                                    .foregroundColor(Color.white)
                                    .clipShape(Capsule())
                                    .font(.headline)

                            }
                            .shadow(radius: 7)
                            Spacer()
                        }
                    }
                }
            }

            if gameStarted && questionCounter < Int(questionCount[questionCountSelector])!{
                Form{
                    HStack{
                        Spacer()
                        Text("Question \(questionCounter)")
                        Spacer()
                    }
                    HStack{

                        Text(selectedQuestion)
                        TextField("your answer", text: $userAnswer)
                            .keyboardType(.numberPad)

                    }.padding(.leading,120)
                    HStack{
                        Spacer()
                        Button(action: {
                            self.answerChecker()
                            self.questionCounter += 1
                        }){
                            Text("Submit")
                                .background(Color.blue)
                                .foregroundColor(Color.white)
                                .clipShape(Capsule())
                                .font(.headline)
                        }
                        Spacer()
                    }
                }
            }
        }.alert(isPresented: $showAlert){
            Alert(title: Text("hey"), message: Text(message), dismissButton: .default(Text("OK"))
            {
                self.selectedQuestion = self.questionTable.shuffled()[0]
                })
        }
    }
    func start(){
        questionTable.removeAll()
        var counter = 0
        while(counter < multiplicator){
            for number in 1...12{
                questionTable.append("\(multiplicator) * \(number)")
            }
            counter += 1
        }
        selectedQuestion = questionTable.shuffled()[0]
        gameStarted = true
        questionCounter = 1
    }

    func answerChecker() {
        guard Int(userAnswer) != nil else {
            return
        }

        let b = Int(String(selectedQuestion.first ?? "0"))!
        var c = ""

        for letter in selectedQuestion.reversed(){
            if letter.isNumber {
                c.append(String(letter))
            }
            else {
                break
            }
        }
        let d = String(c.reversed())

        let correctAnswer = b * Int(d)!

        if Int(userAnswer) == correctAnswer {
            message = "Bingo"
        }
        else {
            message = "Wrong"
        }
        self.showAlert = true
    }

}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
     
