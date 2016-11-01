//
//  ViewController.swift
//  simple-calc
//
//  Created by Just on 16/10/25.
//  Copyright © 2016年 Just. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//code start here
    var inputs : [String] = []
    var numbers : [Double] = []
    var op : String = ""
    var result : Double = 0
    var input: String = ""
    
//need to add decimal support
    // when user didn't enter number but pressed count, num appended to numbers will be 0.0
    // need to add mod
    // need to add RPN support
    
    func getNumber(inputs: [String])->Double{
        var numericalResult : Double = 0
        let totalIndex: Int = inputs.count - 1
        var power : Int
        if totalIndex != 0 {//mutiple digits
            var i = 0
            power = 1
            while i < totalIndex {
                power = power * 10
                i = i + 1
            }
            i=0
            while i <= totalIndex {
                let digit: Int = Int(inputs[i])!
                numericalResult = numericalResult + Double(power * digit)
                power = power / 10
                i += 1
            }
        }else{
            numericalResult = Double(inputs[0])!
        }
        return numericalResult
    }

//the label used to show result
    @IBOutlet weak var resultText: UILabel!

//the label used to show current input
    @IBOutlet weak var inputText: UILabel!
    //MARK: Actions
    
    @IBAction func btn1(_ sender: AnyObject) {
        inputs.append("1")
        let text = getNumber(inputs:inputs)
        inputText.text=String(text)
    }
    
    @IBAction func btn2(_ sender: AnyObject) {
        inputs.append("2")
        let text = getNumber(inputs:inputs)
        inputText.text=String(text)
    }
    
    @IBAction func btn3(_ sender: AnyObject) {
        inputs.append("3")
        let text = getNumber(inputs:inputs)
        inputText.text=String(text)
    }
    @IBAction func btn4(_ sender: AnyObject) {
        inputs.append("4")
        let text = getNumber(inputs:inputs)
        inputText.text=String(text)
    }
    @IBAction func btn5(_ sender: AnyObject) {
        inputs.append("5")
        let text = getNumber(inputs:inputs)
        inputText.text=String(text)
    }
    @IBAction func btn6(_ sender: AnyObject) {
        inputs.append("6")
        let text = getNumber(inputs:inputs)
        inputText.text=String(text)
    }
    @IBAction func btn7(_ sender: AnyObject) {
        inputs.append("7")
        let text = getNumber(inputs:inputs)
        inputText.text=String(text)
    }
    @IBAction func btn8(_ sender: AnyObject) {
        inputs.append("8")
        let text = getNumber(inputs:inputs)
        inputText.text=String(text)
    }
    @IBAction func btn9(_ sender: AnyObject) {
        inputs.append("9")
        let text = getNumber(inputs:inputs)
        inputText.text=String(text)
    }
    @IBAction func btn0(_ sender: AnyObject) {
        inputs.append("0")
        let text = getNumber(inputs:inputs)
        inputText.text=String(text)
    }
    @IBAction func btnDot(_ sender: AnyObject) {
//        inputs.append(".")
//        let text = getNumber(inputs:inputs)
//        inputText.text=String(text)
           }
    @IBAction func btnAdd(_ sender: AnyObject) {
        let num :Double = getNumber(inputs: inputs)
        op = "+"
        numbers.append(num)
        inputs = []
    }
    @IBAction func btnSubtract(_ sender: AnyObject) {
        let num :Double = getNumber(inputs: inputs)
        op = "-"
        numbers.append(num)
        inputs = []
    }
    @IBAction func btnMultiply(_ sender: AnyObject) {
        let num :Double = getNumber(inputs: inputs)
        op = "*"
        numbers.append(num)
        inputs = []
    }
    @IBAction func btnDivide(_ sender: AnyObject) {
        let num :Double = getNumber(inputs: inputs)
        op = "/"
        numbers.append(num)
        inputs = []
    }
    @IBAction func btnFact(_ sender: AnyObject) {
        let num :Double = getNumber(inputs: inputs)
        op = "fact"
        numbers.append(num)
        inputs = []
    }
    @IBAction func btnAverage(_ sender: AnyObject) {
        let num :Double = getNumber(inputs: inputs)
        op = "avg"
        numbers.append(num)
        inputs = []
    }
    
    @IBAction func btnCount(_ sender: AnyObject) {
        let num :Double = getNumber(inputs: inputs)
        op = "count"
        if inputs != []{
            numbers.append(num)
            inputs = []
        }
    }
    @IBAction func btnClear(_ sender: AnyObject) {
        resultText.text=""
        inputs=[]
        inputText.text=""
    }
    @IBAction func resultBtn(_ sender: AnyObject) {
        let num :Double? = getNumber(inputs: inputs)
        if num != nil {
            numbers.append(num!)
            switch op{
            case "+":
                result = numbers.reduce(0,+)
            case "-":
                result = 2*numbers[0]-numbers.reduce(0,+)
            case "*":
                result = numbers.reduce(1,*)
            case "/":
                result = numbers[0]*numbers[0]/numbers.reduce(1,*)
            case "%":
                let num1 = numbers[0]
                let num2 = numbers[1]
                result = num1.truncatingRemainder(dividingBy: num2)
            case "fact":
                var tempResult : Double = 1
                var num = numbers[0]
                while num >= 1 {
                    tempResult = tempResult * num
                    num -= 1
                }
                result = tempResult
            case "avg":
                let total : Double = numbers.reduce(0,+)
                let count : Double = Double(numbers.count)
                result = total/count
            case "count":
                result = Double(numbers.count)
            default:
                result = numbers[0]
            }
            resultText.text = String(result)
        }else{
            resultText.text = "ERROR"
        }
        
        numbers = []
        result = 0
        inputs = []
    }
}

