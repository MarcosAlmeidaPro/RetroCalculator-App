//
//  ViewController.swift
//  RetroCalculator
//
//  Created by MK3 on 17/11/16.
//  Copyright © 2016 Nest Code. All rights reserved.
//

import UIKit
import AVFoundation

class RetroCalculatorVC: UIViewController {

    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        
    }
    var currentOperation = Operation.Empty
    var runningNumber = ""
    
    var leftValue = ""
    var rightValue = ""
    var result = ""
    
    @IBOutlet weak var lblResult: UILabel!
    
    
    @IBAction func btnClearPressed(_ sender: Any) {
        playAudio()
        result = ""
        currentOperation = Operation.Empty
        leftValue = ""
        rightValue = ""
        lblResult.text = "0"
        runningNumber = ""
        
    }
    
    @IBAction func btnPressed(_ sender: UIButton) {
        
        playAudio()
        
        if result == "" {
            currentOperation = Operation.Empty
        }
        
        runningNumber += "\(sender.tag)"
        result = runningNumber
        lblResult.text = result
        
        
        
    }
    
    @IBAction func onDividePressed(sender: UIButton){
        processOperation(operation: .Divide)
        
    }
    
    @IBAction func onMultiplyPressed(sender: UIButton){
        processOperation(operation: .Multiply)
        
    }

    @IBAction func onSubtractPressed(sender: UIButton){
        processOperation(operation: .Subtract)
        
    }
    
    @IBAction func onAddPressed(sender: UIButton){
        processOperation(operation: .Add)
        
    }
    
    @IBAction func onEqualPressed(sender: UIButton){
        processOperation(operation: currentOperation)
        
    }
    
    func playAudio () {
        
        if btnSound.isPlaying {
            
            btnSound.stop()
        }
        
        btnSound.play()
        
    }
    
    
    func processOperation(operation: Operation){
        
            playAudio()
        
            if currentOperation != Operation.Empty {
            
                if runningNumber != "" {
                    rightValue = runningNumber
                    runningNumber = ""
                
                    if currentOperation == Operation.Divide {
                        if Double(leftValue) == 0.0 || Double(rightValue) == 0.0 {
                            
                        } else {
                        
                        let divideResult = Double(leftValue)! / Double(rightValue)!
                        
                        if divideResult.remainder(dividingBy: Double(Int(divideResult))) == 0.0 {
                            result = "\(Int(divideResult))"
                        } else {
                            result = "\(divideResult)"
                        }
                        
                        }
                       
                        
                    } else if currentOperation == Operation.Multiply {
                        let multiplyResult = Double(leftValue)! * Double(rightValue)!
                        
                        if multiplyResult.remainder(dividingBy: Double(Int(multiplyResult))) == 0.0 || Double(leftValue) == 0.0 || Double(rightValue) == 0.0 {
                            result = "\(Int(multiplyResult))"
                        } else {
                            result = "\(multiplyResult)"
                        }
                        
                        
                    } else if currentOperation == Operation.Subtract {
                        let subtractResult = Double(leftValue)! - Double(rightValue)!
                        
                        if subtractResult.remainder(dividingBy: Double(Int(subtractResult))) == 0.0 {
                            result = "\(Int(subtractResult))"
                        } else {
                            result = "\(subtractResult)"
                        }
                    
                       
                    
                    } else if currentOperation == Operation.Add {
                        let addResult = Double(leftValue)! + Double(rightValue)!
                        if addResult.remainder(dividingBy: Double(Int(addResult))) == 0.0 {
                            result = "\(Int(addResult))"
                        } else {
                            result = "\(addResult)"
                        }
                    
                        
                    }
                        
                    leftValue = result
                    lblResult.text = result
                }
            
                currentOperation = operation
                
            
            } else {
            
                leftValue = runningNumber
                runningNumber = ""
                currentOperation = operation
            }
        
        
    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            
           try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
            
        } catch let err as NSError {
            
            print(err.debugDescription)
            
        }
        
        lblResult.text = "0"
        
    }



}

