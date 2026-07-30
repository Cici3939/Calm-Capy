//
//  AudioClassifierViewModel.swift
//  Calm Capy
//
//  Created by Cici Xing on 7/21/24.
//

import SwiftUI
import AVFoundation
import SoundAnalysis

class AudioClassifierViewModel: ObservableObject, MoodClassifierDelegate {
    @Published var result: String = ""
    private var audioEngine: AVAudioEngine
    private var inputBus: AVAudioNodeBus
    private var inputFormat: AVAudioFormat!
    private var analyzer: SNAudioStreamAnalyzer!
    private let analysisQueue = DispatchQueue(label: "com.example.AnalysisQueue")
    var observer: ResultsObserver
    
    init() {
        self.audioEngine = AVAudioEngine()
        self.inputBus = 0
        self.observer = ResultsObserver()
        self.observer.delegate = self
        
        configureAudioSession()
    }
    
    private func configureAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try audioSession.setActive(true)
        } catch {
            print("Failed to configure audio session: \(error.localizedDescription)")
        }
    }
    
    func requestMicrophoneAccess() {
        if #available(iOS 17.0, *) {
            AVAudioApplication.requestRecordPermission(completionHandler:) { granted in
                DispatchQueue.main.async {
                    if granted {
                        print("Microphone access granted")
                    } else {
                        print("Microphone access denied")
                    }
                }
            }
        } else {
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                DispatchQueue.main.async {
                    if granted {
                        print("Microphone access granted")
                    } else {
                        print("Microphone access denied")
                    }
                }
            }
        }
    }
    
    func startAudioEngine() {
        print("Starting audio engine...")
        
        let inputNode = audioEngine.inputNode
        inputFormat = inputNode.inputFormat(forBus: inputBus)
        
        guard inputFormat.sampleRate > 0, inputFormat.channelCount > 0 else {
            print("Invalid input format: \(inputFormat)")
            return
        }
        
        installAudioTap()
        
        do {
            try audioEngine.start()
            print("Audio engine started successfully.")
        } catch {
            print("Unable to start AVAudioEngine: \(error.localizedDescription)")
        }
    }
    
    func stopAudioEngine() -> String {
        print("Stopping audio engine...")
        
        let moodDetected: String
        let happy = observer.happy
        let sad = observer.sad
        let fearful = observer.fearful
        let angry = observer.angry
        let neutral = observer.neutral
        
        let moodCountMost = max(happy, max(sad, max(fearful, max(angry, neutral))))
        
        switch moodCountMost {
        case happy:
            moodDetected = "Happy"
        case sad:
            moodDetected = "Sad"
        case fearful:
            moodDetected = "Fearful"
        case angry:
            moodDetected = "Angry"
        case neutral:
            moodDetected = "Neutral"
        default:
            moodDetected = "Unknown"
        }
        
        audioEngine.inputNode.removeTap(onBus: inputBus)
        audioEngine.stop()
        
        print("Audio engine stopped.")
        
        return moodDetected
    }
    
    func classifySound() {
        print("Setting up sound classification...")
        analyzer = SNAudioStreamAnalyzer(format: inputFormat)
        let soundClassifier = try! MoodClassifierNew()
        let classifySoundRequest = try! SNClassifySoundRequest(mlModel: soundClassifier.model)
        
        do {
            try analyzer.add(classifySoundRequest, withObserver: observer)
            print("Classification request added successfully.")
        } catch {
            print("Error in setting up classification: \(error.localizedDescription)")
        }
    }
    
    private func installAudioTap() {
        print("Installing audio tap...")
        let inputNode = audioEngine.inputNode
        
        inputNode.installTap(onBus: inputBus, bufferSize: 8192, format: inputFormat) { buffer, time in
            self.analysisQueue.async {
                self.analyzer.analyze(buffer, atAudioFramePosition: time.sampleTime)
                print("Analyzing buffer at time: \(time.sampleTime)")
            }
        }
    }
    
    func clearResults() {
        result = ""
    }
    
    func displayPredictionResult(identifier: String, confidence: Int) {
        DispatchQueue.main.async {
            self.result = "Recognition: \(identifier)\nConfidence: \(confidence)"
            print("Prediction Result: \(identifier) with confidence: \(confidence)")
        }
    }
}

class ResultsObserver: NSObject, ObservableObject, SNResultsObserving {
    var happy: Int = 0
    var sad: Int = 0
    var fearful: Int = 0
    var angry: Int = 0
    var neutral: Int = 0
    
    weak var delegate: MoodClassifierDelegate?
    
    func request(_ request: SNRequest, didProduce result: SNResult) {
        guard let result = result as? SNClassificationResult,
              let classification = result.classifications.first else { return }
        
        if classification.identifier == "Happy" {
            happy += 1
        }
        if classification.identifier == "Sad" {
            sad += 1
        }
        if classification.identifier == "Fearful" {
            fearful += 1
        }
        if classification.identifier == "Angry" {
            angry += 1
        }
        if classification.identifier == "Neutral" {
            neutral += 1
        }
        
        let confidence: Int = Int(classification.confidence * 100.0)
        delegate?.displayPredictionResult(identifier: classification.identifier, confidence: confidence)
    }
    
    func request(_ request: SNRequest, didFailWithError error: Error) {
        print("The analysis failed: \(error.localizedDescription)")
    }
    
    func requestDidComplete(_ request: SNRequest) {
        print("The request completed successfully!")
    }
}

protocol MoodClassifierDelegate: AnyObject {
    func displayPredictionResult(identifier: String, confidence: Int)
}
