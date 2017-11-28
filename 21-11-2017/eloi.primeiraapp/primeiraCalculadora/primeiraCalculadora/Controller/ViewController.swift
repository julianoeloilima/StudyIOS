//
//  ViewController.swift
//  primeiraCalculadora
//
//  Created by Aloc SP08608 on 21/11/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var labelResultado: DesignableLabel!
    @IBOutlet weak var btnClean: DesignableButton!
    
    var manager = CalculatorManager()
    
    @IBAction func clickExecuteCalc(_ sender: UIButton) {
        executeCalc()
    }
    
    @IBAction func clickPercent(_ sender: UIButton) {
        manager.setSymbolOperation("%")
 //       operation = "%"
        executeCalc()
    }
    
    @IBAction func clickChangeSignal(_ sender: UIButton) {
        changeSignal()
    }
    
    @IBAction func clickOperation(_ sender: UIButton) {
        verifyContinueOperation()
        if (!"".elementsEqual(firstNumber)) {
            
            if (secondNumber.count > 0) {
                executeCalc()
                firstNumber = resultCalc
                resultCalc = ""
                secondNumber = ""
                operation = sender.currentTitle!.description
                if (!"√".elementsEqual(operation)) {
                    showCalc()
                }
                else {
                    executeCalc()
                }
            }
            else {
                operation = sender.currentTitle!.description
                if (!"√".elementsEqual(operation)) {
                    showCalc()
                }
                else {
                    executeCalc()
                }
            }
        }
    }

    func verifyContinueOperation() {
        if (resultCalc.count > 0) {
            firstNumber = resultCalc
            secondNumber = ""
            resultCalc = ""
            operation = ""
        }
    }
    
    @IBAction func clickClean(_ sender: UIButton) {
        clean()
        showCalc()
    }
    
    @IBAction func clickPoint(_ sender: UIButton) {
        writePointer()
    }
    
    @IBAction func numberClick(_ sender: UIButton) {
        let number : String = sender.currentTitle!.description
        writeNumber(number)
    }

    var firstNumber : String = "0";
    var secondNumber : String = "";
    //var operation : String = "";
    var resultCalc : String = "";

    func writeNumber(_ digito : String) {
        verifyClean()
        if (operation.elementsEqual("")) {
            if (firstNumber.elementsEqual("0")) {
                if (!digito.elementsEqual("0")) {
                    firstNumber = digito
                }
            }
            else {
                firstNumber += digito
            }
            manager.setFirstNumber(Double(firstNumber)!)
        }
        else {
            if (secondNumber.elementsEqual("0") && (!digito.elementsEqual("0"))) {
                if (!digito.elementsEqual("0")) {
                    secondNumber = digito
                    btnClean.setTitle("C", for: UIControlState.normal)
                }
            }
            else {
                secondNumber += digito
                btnClean.setTitle("C", for: UIControlState.normal)
            }
            manager.setSecondNumber(Double(secondNumber)!)
        }
        showCalc()
    }

    func verifyClean() {
        //if (resultCalc.count > 0) {
        if manager.result != nil {
            clean()
        }
    }
    
    func writePointer() {
        verifyClean()
        if (operation.elementsEqual("")) {
            if (!firstNumber.contains(".")) {
                if (firstNumber.elementsEqual("")) {
                    firstNumber += "0."
                }
                else if (firstNumber.elementsEqual("-")) {
                    firstNumber += "-0."
                }
                else {
                    firstNumber += "."
                }
            }
        }
        else {
            if (!secondNumber.contains(".")) {
                if (secondNumber.elementsEqual("")) {
                    secondNumber = "0."
                }
                else if (secondNumber.elementsEqual("-")) {
                    secondNumber = "-0."
                }
                else {
                    secondNumber += "."
                }
            }
        }
        showCalc()
    }

    func removeFirstCharacter(_ str : String) -> String {
        if (str.count == 0) {
            return "";
        }
        
        return String(str[str.index(str.startIndex, offsetBy: 1) ..< str.endIndex])
    }

    func removeTwoLastCharacters(_ str : String) -> String {
        if (str.count < 2) {
            return "";
        }
        
        return String(str[str.startIndex ..< str.index(str.endIndex, offsetBy: -2)])
    }

    func changeSignal() {
        verifyContinueOperation()
        if (operation.elementsEqual("")) {
            if (!firstNumber.starts(with: "-")) {
                firstNumber = "-" + firstNumber
            }
            else {
                firstNumber = removeFirstCharacter(firstNumber)
            }
        }
        else {
            if (!secondNumber.starts(with: "-")) {
                secondNumber = "-" + secondNumber
            }
            else {
                secondNumber = removeFirstCharacter(secondNumber)
            }
        }
        showCalc()
    }

    func showCalc() {
        if (resultCalc.count == 0) {
            labelResultado.text = "\(firstNumber) \(manager.) \(secondNumber)"
        }
        else {
            labelResultado.text = "\(firstNumber) \(operation) \(secondNumber) = \(resultCalc)"
        }
    }
    
    func executeCalc() {
//        if (resultCalc.count > 0) {
//            firstNumber = resultCalc
//        }
        

        manager.performOperation()
        
        /*
        var result : Double? = nil
        
        
        
        switch operation {
        case "+":
            result = Double(firstNumber)! + Double(secondNumber)!
            break;
        case "-":
            result = Double(firstNumber)! - Double(secondNumber)!
            break;
        case "x":
            result = Double(firstNumber)! * Double(secondNumber)!
            break;
        case "÷":
            result = Double(firstNumber)! / Double(secondNumber)!
            break;
        case "√":
            result = sqrt(Double(firstNumber)!)
            break;
        case "%":
            if (secondNumber.count > 0) {
                result = Double(firstNumber)! * Double(secondNumber)! / 100.0
            }
            else {
                result = Double(firstNumber)! / 100.0
            }
            break;
        default:
            break
        }
        
        */
        
        if let value = manager.result {
            let strVal = "\(value)"
            if (strVal.hasSuffix(".0")) {
                resultCalc = removeTwoLastCharacters(strVal)
            }
            else {
                resultCalc = "\(value)"
            }
            showCalc()
        }
    }

    func clean() {
        manager.clean();
        if manager.isCleanAC {
            btnClean.setTitle("AC", for: UIControlState.normal)
        }
        else {
            btnClean.setTitle("C", for: UIControlState.normal)
        }
    }

}

