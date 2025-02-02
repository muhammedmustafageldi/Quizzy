import Foundation

struct QuizBrain {
    
    private var questions = [Question]()
    private(set) var questionNumber = 0
    private(set) var correctNumber = 0
    private(set) var wrongNumber = 0
    var questionCount: Int {
        return questions.count
    }
    var isTestFinished: Bool {
        return questionNumber + 1 == questions.count
    }
    
    
    init () {
        loadQuestions()
        shuffleQuestions()
    }
    
    mutating func loadQuestions() {
        questions.append(Question(q: "The sky is green.", a: "False"))
        questions.append(Question(q: "Penguins can fly.", a: "False"))
        questions.append(Question(q: "Water boils at 100°C.", a: "True"))
        questions.append(Question(q: "The capital of France is Paris.", a: "True"))
        questions.append(Question(q: "Humans have three hearts.", a: "False"))
        questions.append(Question(q: "Bananas are berries.", a: "True"))
        questions.append(Question(q: "The Great Wall of China is visible from space.", a: "False"))
        questions.append(Question(q: "An octopus has eight legs.", a: "True"))
        questions.append(Question(q: "The sun is a star.", a: "True"))
        questions.append(Question(q: "Chocolate grows on trees.", a: "True"))
        questions.append(Question(q: "The Earth is flat.", a: "False"))
        questions.append(Question(q: "Honey never spoils.", a: "True"))
        questions.append(Question(q: "The Eiffel Tower is in London.", a: "False"))
        questions.append(Question(q: "Sharks are mammals.", a: "False"))
        questions.append(Question(q: "The moon is made of cheese.", a: "False"))
        questions.append(Question(q: "A group of crows is called a murder.", a: "True"))
        questions.append(Question(q: "Australia is both a country and a continent.", a: "True"))
        questions.append(Question(q: "Goldfish have a memory span of 3 seconds.", a: "False"))
        questions.append(Question(q: "The tallest mountain on Earth is Mount Everest.", a: "True"))
        questions.append(Question(q: "Napoleon Bonaparte was short.", a: "False"))
    }
    
    mutating func shuffleQuestions() {
        questions.shuffle()
    }
    
    func getQuestion() -> String {
        return questions[questionNumber].question
    }
    
    mutating func checkAnswer(_ userAnswer: String) -> Bool {
        if userAnswer == questions[questionNumber].answer {
            // Answer is correct
            correctNumber += 1
            return true
        } else {
            // Answer is wrong
            wrongNumber += 1
            return false
        }
    }
    
    mutating func nextQuestion() {
        if questionNumber < questions.count {
            questionNumber += 1
        }
    }
    
    mutating func startGame() {
        // Reset correct and wrong value
        correctNumber = 0
        wrongNumber = 0
        questionNumber = 0
    }
}
