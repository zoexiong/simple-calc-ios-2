//
//  ViewController.swift
//  simple-calc
//
//  Created by Just on 16/10/25.
//  Copyright © 2016年 Just. All rights reserved.
//

import UIKit


public var history_list:[String]=[]
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
    var op0 : String = ""
    var op : String = ""
    var result : Double = 0
    var input: String = ""
    var tempResult: Double? = nil
    var temps: [Double] = []
    var index1: Int = -1
    var index2: Int = -1
    var num1: Double = 0
    var num2: Double = 0
    var history_left=""
    var displayText: String = ""
    var tempOp: String = ""

    
    // when user didn't enter number but pressed count, num appended to numbers will be 0.0
    // need to add mod
    // need to add RPN support
    
    func getNumber(inputs: [String])->Double{
        
        var beforeDecimalResult : Double = 0
        var afterDecimalResult : Double = 0
        var beforeDecimalIndex: Int
        var afterDecimalNumber: Int
        var numericalResult: Double = 0
        var power : Double
        var i:Int = 0
        
        
        
        let decimalIndex = inputs.index(of: ".")
        if decimalIndex == nil{
            // index of digit right before decimal point
            beforeDecimalIndex = inputs.count - 1
            // number of digits after decimal point
            afterDecimalNumber = -1
        }
        else {
            beforeDecimalIndex = decimalIndex! - 1
            afterDecimalNumber = inputs.count - 1 - decimalIndex!
        }
        
        // get the value of digits before decimal point
        if beforeDecimalIndex > 0 {//mutiple digits
            i = 0
            power = 1
            while i < beforeDecimalIndex { //        get the number of 0 following the first digit
                power = power * 10
                i = i + 1
            }
            i=0
            while i <= beforeDecimalIndex {
                let digit: Int = Int(inputs[i])!
                beforeDecimalResult = beforeDecimalResult + power * Double(digit)
                power = power / 10
                i += 1
            }
        }
        else if beforeDecimalIndex == 0{
            beforeDecimalResult = Double(inputs[0])!
        }
        else{
            beforeDecimalResult = 0
        }
        
        // get the value of digits after decimal point
        if afterDecimalNumber > 0{
            i = 0
            power = 1
            while i < afterDecimalNumber { //        get the number of 0 following the first digit
                power = power / 10
                i += 1
                let indexDigit:Int = i + decimalIndex!
                let digit: Int = Int(inputs[indexDigit])!
                afterDecimalResult = afterDecimalResult + power * Double(digit)
            }
        }
        else{
            afterDecimalResult = 0}
        
        numericalResult = beforeDecimalResult + afterDecimalResult
        return numericalResult
    }
    
    
    
    func getTempResult(op:String,temps:[Double]) -> Double {
        //for getTempResult()
        var result: Double = 0
        num1 = temps[0]
        num2 = temps[1]
        switch op{
        case "+":
            result = num1+num2
        case "-":
            result = num1-num2
        case "*":
            result = num1*num2
        case "/":
            result = num1/num2
        case "%":
            result = num1.truncatingRemainder(dividingBy: num2)
        default:
            result = 0
        }
        return result
    }
    
    func getInputText(){
        let text = getNumber(inputs:inputs)
        if (op != "avg" && op != "count" && op != "fact"){
            if numbers.count > 1{
                displayText = String(tempResult!) + op + String(text)
            }
            else if numbers.count == 1 {
                displayText = String(numbers[0]) + op + String(text)
            } else {
                displayText = String(text)
            }
        }else{
            displayText = String(text)
        }
        inputText.text = displayText
    }
    
    //in case user consecutively enter multiple operators to correct their mistaken input, added func to handle it
    func opAction(tempOp:String){
        if inputs != []{
            let num :Double = getNumber(inputs: inputs)
            numbers.append(num)
            if op == "" {
                op = tempOp
            }
            else{
                op0 = op
                op = tempOp
            }
            if op0 != "" {
                if tempResult == nil{
                    temps=numbers
                } else{
                    temps.append(tempResult!)
                    temps.append(numbers[numbers.count-1])
                }
                tempResult = getTempResult(op: op0, temps: temps)
                displayText = String(tempResult!)+op
                history_left = history_left + String(num) + tempOp
                displayText = String(tempResult!) + tempOp
                temps=[]
            }else{
                history_left = String(num) + tempOp
                displayText = String(num) + tempOp
            }
        }
        else {
            op=tempOp
            displayText = String(displayText.characters.dropLast(1)) + op
        }
        inputText.text = displayText
        inputs = []
    }
    
    //the label used to show result
    @IBOutlet weak var resultText: UILabel!
    
    //the label used to show current input
    @IBOutlet weak var inputText: UILabel!
    //MARK: Actions
    
    @IBAction func btn1(_ sender: AnyObject) {
        inputs.append("1")
        getInputText()
    }
    
    @IBAction func btn2(_ sender: AnyObject) {
        inputs.append("2")
        getInputText()
    }
    
    @IBAction func btn3(_ sender: AnyObject) {
        inputs.append("3")
        getInputText()
    }
    
    @IBAction func btn4(_ sender: AnyObject) {
        inputs.append("4")
        getInputText()
    }
    
    @IBAction func btn5(_ sender: AnyObject) {
        inputs.append("5")
        getInputText()
    }
    
    @IBAction func btn6(_ sender: AnyObject) {
        inputs.append("6")
        getInputText()
    }
    
    @IBAction func btn7(_ sender: AnyObject) {
        inputs.append("7")
        getInputText()
    }
    
    @IBAction func btn8(_ sender: AnyObject) {
        inputs.append("8")
        getInputText()
    }
    
    @IBAction func btn9(_ sender: AnyObject) {
        inputs.append("9")
        getInputText()
    }
    
    @IBAction func btn0(_ sender: AnyObject) {
        inputs.append("0")
        getInputText()
    }
    
    @IBAction func btnDot(_ sender: AnyObject) {
        inputs.append(".")
        getInputText()
    }
    
    @IBAction func btnAdd(_ sender: AnyObject) {
        tempOp = "+"
        opAction(tempOp:tempOp)
    }
    
    @IBAction func btnSubtract(_ sender: AnyObject) {
        tempOp = "-"
        opAction(tempOp:tempOp)
    }
    
    @IBAction func btnMultiply(_ sender: AnyObject) {
        tempOp = "*"
        opAction(tempOp:tempOp)
    }
    
    @IBAction func btnDivide(_ sender: AnyObject) {
        tempOp = "/"
        opAction(tempOp:tempOp)
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
        inputText.text=""
        displayText = ""
        numbers = []
        result = 0
        inputs = []
        history_left=""
        tempResult = nil
        op=""
        op0=""
    }
    
    // when user didn't enter number but pressed count, num appended to numbers will be 0.0
    
    @IBAction func resultBtn(_ sender: AnyObject) {
        let num :Double? = getNumber(inputs: inputs)
        if num != nil {
            numbers.append(num!)
            //in case tempResult doesn't exist
            if tempResult == nil{
                if numbers.count > 1{
                    tempResult = numbers[0]
                }else {
                    tempResult = 0
                }
            }
            switch op{
            case "+":
                result = tempResult! + num!
                inputText.text=String(tempResult!) + "+" + String(getNumber(inputs: inputs))
            case "-":
                result = tempResult! - num!
                inputText.text=String(tempResult!) + "-" + String(getNumber(inputs: inputs))
            case "*":
                result = tempResult! * num!
            case "/":
                result = tempResult! / num!
            case "%":
                let num1 = numbers[0]
                let num2 = numbers[1]
                result = num1.truncatingRemainder(dividingBy: num2)
            case "fact":
                result = 1
                var num = numbers[0]
                while num >= 1 {
                    result = result * num
                    num -= 1
                }
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
            let history_item = history_left + String(getNumber(inputs: inputs)) + "=" + String(result)
            history_list.append(history_item)
            print(history_list)
        }else{
            resultText.text = "ERROR"
        }
        
        numbers = []
        //        var historyResult: Double = result
        result = 0
        inputs = []
        history_left=""
        tempResult = nil
        op=""
        op0=""
    }
}

