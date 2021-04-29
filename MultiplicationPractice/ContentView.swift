//
//  ContentView.swift
//  MultiplicationPractice
//
//  Created by FARIT GATIATULLIN on 29.03.2021.
//

import SwiftUI

enum ActiveAlert {
    case first, second
}

struct Question {
    var firstNum: Int = 0
    var secondNum: Int = 0
    var correctAnswer: Int {
        return firstNum * secondNum
    }
}

struct Game {
    var multiplicators = [2, 3, 4, 5, 6, 7, 8, 9]
    var rounds = ["5", "10", "20", "All"]
    var currentRound = 2
    
    var numberOfRounds = 0
    var maximumMultiplicator = 0
    
    mutating func reset() {
        self.numberOfRounds = 0
        self.maximumMultiplicator = 0
        self.currentRound = 0
    }
    
}

struct ContentView: View {
    @State private var gameStarted = false
    @State private var showingScore = false
    @State private var gameEnded = false
    @State private var activeAlert: ActiveAlert = .first
    @State private var showingAlert = false
    
    @State var scale: CGFloat = 1
    @State private var question = Question()
    @State private var game = Game()
    @State var questions: [Question] = []
    @State var userAnswer = ""
    @State var alertTitle = ""
    @State var alertText = ""
    @State var userScore = 0
    
    func generateQuestions(_ maxMultiplicator: Int) -> [Question] {
        var questions:[Question] = []
        print("Max multiplicator = \(game.multiplicators[maxMultiplicator])")
        for num in 2...game.multiplicators[maxMultiplicator] {
            let firstNum = num
            for secondNum in 2...game.multiplicators[maxMultiplicator] {
                let secondNum = secondNum
                let question = Question(firstNum: firstNum, secondNum: secondNum)
                questions.append(question)
            }
        }
        questions.shuffle()
        print("QQ: \(questions.count)")
        return questions
    }
    
    func startGame() {
        game.currentRound = 1
        gameEnded = false
        activeAlert = .first
        questions = generateQuestions(game.maximumMultiplicator)
        
        print("Questions list: \(questions)")
        print("Questions count: \(questions.count)")
        print("Number of rounds: \(game.numberOfRounds)")
        gameStarted.toggle()
        question = questions.first ?? Question()
    }
    
    func buttonTapped() {
        if Int(userAnswer) == question.correctAnswer {
            userScore += 1
            alertTitle = "Correct"
            alertText = "Your score is \(userScore)"
        } else {
            alertTitle = "Incorrect"
            alertText = "Your score is \(userScore)"
        }
        showingScore = true
        
    }
    
    func askQuestion() {
        userAnswer = ""
        
        questions.remove(at: 0)
        if questions.count > 0 && game.currentRound <= (Int(game.rounds[game.numberOfRounds]) ?? questions.count) {
        question = questions.first ?? Question()
        }
    }
    
    func showAlert(_ active: ActiveAlert) -> Void {
            DispatchQueue.global().async {
                self.activeAlert = active
                self.showingAlert = true
            }
        }
    
    
    var body: some View {
        ZStack {
            BackgroundView()
            switch gameStarted {
            case false:
            Group {
                ZStack {
                    VStack {
                        VStack {
                            
                            Section(header: Text("Choose maximum multiplicator"
                            )
                            .padding()
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .foregroundColor(.white)
                            .accentColor(.blue)
                            .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.white, lineWidth: 1))
                            ) {
                                Picker("Maxmum multiplicator", selection: $game.maximumMultiplicator) {
                                    ForEach(0..<game.multiplicators.count) {
                                        Text("\(self.game.multiplicators[$0])")
                                            .fontWeight(.bold)
                                        .foregroundColor(.red)
                                        .accentColor(.white)
                                        .foregroundColor(.white)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .accentColor(.white)
                                .foregroundColor(.white)
                                }
                            Section(header: Text("Choose number of rounds").padding()
                                        .clipShape(RoundedRectangle(cornerRadius: 30))
                                        .foregroundColor(.white)
                                        .accentColor(.blue)
                                        .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.white, lineWidth: 1))) {
                                Picker("Number of rounds", selection: $game.numberOfRounds) {
                                    ForEach(0..<game.rounds.count) {
                                        Text("\(self.game.rounds[$0])")
                                            .fontWeight(.bold)
                                        .foregroundColor(.red)
                                        .accentColor(.white)
                                        .foregroundColor(.white)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                }
                            }
                        .padding()
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.white, lineWidth: 1))
                        .shadow(color: .white, radius: 10)
                        
                        .padding()
                        .shadow(color: Color.blue.opacity(0.5), radius: 5)
                        
                            
                        Spacer()
                        Button(action: {
                           questions = generateQuestions(game.maximumMultiplicator)
                            startGame()
                        }, label: {
                            Text("""
        Start
        Game
        """)
                                .multilineTextAlignment(.center)
                                .font(.largeTitle)
                        })
                        .frame(width: 200, height: 200)
                                        .foregroundColor(Color.white)
                        .background(Color.green.opacity(0.5))
                                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white.opacity(0.5), lineWidth: 3))
                        .shadow(color: .white, radius: 10)
                        .shadow(color: Color.blue.opacity(0.5), radius: 5)
                        .scaleEffect(scale)
                        .onAppear {
                                       let baseAnimation = Animation.easeInOut(duration: 1)
                                       let repeated = baseAnimation.repeatForever(autoreverses: true)
                                       withAnimation(repeated) {
                                           scale = 1.1
                                       }
                                   }
                        Spacer()
                    }
                    
                }
            } //SettingsView


            case true:
                Group {
                    VStack(spacing: 10) {
                        Text("How much will be")
                            .shadow(color: .white, radius: 5)
                            .font(.largeTitle)
                            .padding()
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .foregroundColor(.white)
                            .accentColor(.blue)
                            .animation(.easeInOut)
                        HStack {
                            Text("\(question.firstNum)")
                                .font(.system(size: 100))
                                .foregroundColor(.white)
                                .padding()
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                                .foregroundColor(.blue)
                                .accentColor(.blue)
                                .background(RoundedRectangle(cornerRadius: 30).foregroundColor(.black).opacity(0.1))
                                .animation(.easeInOut)
                                .shadow(radius: 10)
                            Text("X")
                                .shadow(color: .white, radius: 5)
                                .font(.largeTitle)
                                .padding()
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                                .foregroundColor(.white)
                                .accentColor(.blue)
                                .animation(.easeInOut)
                            Text("\(question.secondNum)")
                                .font(.system(size: 100))
                                .foregroundColor(.white)
                                .padding()
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                                .foregroundColor(.blue)
                                .accentColor(.blue)
                                .background(RoundedRectangle(cornerRadius: 30).foregroundColor(.black).opacity(0.1))
                                .animation(.easeInOut)
                                .shadow(radius: 10)
                            VStack {
                            }
                        }
                        Text("?")
                            .shadow(color: .white, radius: 5)
                            .font(.system(size: 50))
                            .padding()
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .foregroundColor(.white)
                            .accentColor(.blue)
                            .animation(.easeInOut)
                        HStack {
                            TextField("Enter answer", text: $userAnswer, onCommit: {
                                self.showingScore.toggle()
                                print("Showing score toggled")
                            })
                                .padding()
                                .keyboardType(.numberPad)
                                .foregroundColor(.white)
                                .padding()
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                                .foregroundColor(.blue)
                                .accentColor(.blue)
                                .background(RoundedRectangle(cornerRadius: 30).foregroundColor(.white).opacity(0.3))
                                .animation(.easeInOut)
                                .shadow(radius: 10)
                            .padding()

                            Button(action: {
                                hideKeyboard()
                                buttonTapped()
                                
                            }) {
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .colorInvert()
                            }
                            .frame(width: 70, height: 70, alignment: .center)
                            .buttonStyle(NeumorphicButtonStyle(bgColor: Color.white.opacity(0.0)))
                            .padding()
                    }
                        .animation(.easeInOut)
                    }
                    .alert(isPresented: $showingScore) {
                        switch activeAlert {
                        case .first:
                            return Alert(title: Text(alertTitle), message: Text(alertText), dismissButton: .default(Text("Continue"), action: {
                                game.currentRound += 1
                                print("Questions count from button: \(questions.count)")
                                print("Current round: \(game.currentRound)")
                                print(String(game.rounds[game.numberOfRounds]) )
                                if (game.currentRound >= (Int(game.rounds[game.numberOfRounds]) ?? questions.count)) || (game.currentRound >= questions.count) {

                                    self.askQuestion()
                                    self.showAlert(.second)
                                } else {
                                    self.askQuestion()
                                }
                            }))
                        case .second:
                            return Alert(title: Text(alertTitle), message: Text("Game over. Your total score is \(userScore)"),  dismissButton: .default(Text("Play Again"), action: {
                                game.reset()
                                userScore = 0
                                gameStarted = false
                            }))
                        }
                    }
            }
        }
    }
}
}

struct BackgroundView: View {
    @State var switchColor = false
    var body: some View {
           ZStack {
               RoundedRectangle(cornerRadius: 0)
                   .fill(switchColor ? Color.purple : Color.green)
                .edgesIgnoringSafeArea(.all)
               ZStack {
                   RoundedRectangle(cornerRadius: 0)
                       .fill(switchColor ? Color.white : Color.yellow)
                    .edgesIgnoringSafeArea(.all)
               }
               .edgesIgnoringSafeArea(.all)
               .mask(LinearGradient(gradient: Gradient(colors: [.clear,.black]), startPoint: .top, endPoint: .bottom))

           }
           .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
           .edgesIgnoringSafeArea(.all)
           .onAppear {
               withAnimation(Animation.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
                   switchColor.toggle()
               }
           }
           
       }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct NeumorphicButtonStyle: ButtonStyle {
    var bgColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(20)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .shadow(color: Color.white.opacity(0.5), radius: configuration.isPressed ? 7: 10, x: configuration.isPressed ? -5: -15, y: configuration.isPressed ? -5: -15)
                        .shadow(color: .black, radius: configuration.isPressed ? 7: 10, x: configuration.isPressed ? 5: 15, y: configuration.isPressed ? 5: 15)
                        .blendMode(.overlay)
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(bgColor)
                }
        )
            .scaleEffect(configuration.isPressed ? 0.95: 1)
            .foregroundColor(.primary)
            .animation(.spring())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
