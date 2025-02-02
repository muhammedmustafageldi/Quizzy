import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var correctNumberText: UILabel!
    @IBOutlet weak var questionNumberText: UILabel!
    @IBOutlet weak var wrongNumberText: UILabel!
    
    private var timer: Timer?
    private var player: AVAudioPlayer?
    private var totalTime = 20.0
    private var passedTime = 0.0
    
    private var quizBrain: QuizBrain!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.,
        quizBrain = QuizBrain()
        startGame()
    }

    @IBAction func answerButtonPressed(_ sender: UIButton) {
        let userAnswer = sender.currentTitle!
        
        let result = quizBrain.checkAnswer(userAnswer)
        answerIsCorrect(result)
        
        if quizBrain.isTestFinished {
            finishTest()
        } else {
            quizBrain.nextQuestion()
            getQuestion()
        }
    }
    
    @IBAction func tryAgainPressed(_ sender: UIButton) {
        startGame()
    }
    
    private func startGame() {
        tryAgainButton.isHidden = true
        trueButton.isHidden = false
        falseButton.isHidden = false
        progressBar.isHidden = false
        questionNumberText.isHidden = false
       
        // Start game by quizbrain
        quizBrain.startGame()
        
        correctNumberText.text = "Correct: 0"
        wrongNumberText.text = "Wrong: 0"
        // Show first question
        getQuestion()
        // Start timer
        startTimer()
    }
    
    private func getQuestion() {
        let question = quizBrain.getQuestion()
        questionLabel.text = question
        questionNumberText.text = "\(quizBrain.questionNumber + 1)/\(quizBrain.questionCount)"
    }
    
    private func answerIsCorrect(_ isCorrect: Bool) {
        if isCorrect {
            // Answer is correct
            playSound("True")
            correctNumberText.text = "Correct: \(quizBrain.correctNumber)"
        } else {
            // Answer is wrong
            playSound("False")
            wrongNumberText.text = "Wrong: \(quizBrain.wrongNumber)"
        }
    }
    
    
    private func finishTest() {
        questionLabel.text = "Test finished!"
        trueButton.isHidden = true
        falseButton.isHidden = true
        tryAgainButton.isHidden = false
        progressBar.isHidden = true
        questionNumberText.isHidden = true
        timer?.invalidate()
        passedTime = 0
        progressBar.progress = 0
    }

    
    private func playSound(_ soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error playing sound: \(error)")
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        if  passedTime < totalTime {
            passedTime += 0.01
            // Update progress
            progressBar.progress = calculatePercentage(passedTime)
        } else {
            finishTest()
        }
    }
    
    private func calculatePercentage(_ secondsPassed: Double) -> Float {
            return Float(secondsPassed) / Float(totalTime)
    }
    
}
