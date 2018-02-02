//
//  ViewController.swift
//  simple-calc-iOS
//
//  Created by Keertana Chandar on 1/30/18.
//  Copyright © 2018 Keertana Chandar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var output: UILabel!
    
    var numberOnScreen:Int = 0
    var previousNumber:Int = 0
    var op:String = ""
    var operating:Bool = false
    var count:Int = 0
    var total:Int = 0
    var history:[String] = []
    var current:String = ""
    
    @IBAction func numbers(_ sender: UIButton) {
        if operating {
            output.text = String(sender.tag - 1)
            numberOnScreen = Int(output.text!)!
            operating = false
        } else {
            output.text = output.text! + String(sender.tag - 1)
            numberOnScreen = Int(output.text!)!
        }
        current += String(sender.tag - 1)
    }
    
    
    @IBAction func operators(_ sender: UIButton) {
        if output.text != "" {
            previousNumber = numberOnScreen
            current = String(previousNumber)
            switch(sender.tag) {
            case 13:
                output.text = "+"
                op = "+"
                current += "+"
            case 12:
                output.text = "-"
                op = "-"
                current += "-"
            case 11:
                output.text = "x"
                op = "x"
                current += "x"
            case 20:
                output.text = "/"
                op = "/"
                current += "/"
            case 17:
                output.text = "count"
                op = "count"
                count += 1
                current += "count"
            case 18:
                output.text = "avg"
                op = "avg"
                total += numberOnScreen
                count += 1
                current += "avg"
            case 14:
                output.text = "%"
                op = "%"
                current += "%"
            default:
                break
            }
            operating = true
        }
    }
    
    
    @IBAction func equals(_ sender: UIButton) {
        switch(op) {
        case "+":
            total = previousNumber + numberOnScreen
        case "-":
            total = previousNumber - numberOnScreen
        case "x":
            total = previousNumber * numberOnScreen
        case "/":
            if(numberOnScreen == 0) {
                total = 0
            } else {
                total = previousNumber / numberOnScreen
            }
        case "count":
            count += 1
            total = count
            count = 0
        case "avg":
            count += 1
            total = (total + numberOnScreen) / count
            count = 0
        case "%":
            if numberOnScreen != 0 && previousNumber >= numberOnScreen {
                let mult = previousNumber / numberOnScreen
                total = previousNumber - (numberOnScreen * mult)
            } else {
                total = previousNumber
            }
        default:
            break
        }
        current += "=" + String(total)
        history.append(current)
        operating = true
        output.text = String(total)
        numberOnScreen = Int(output.text!)!
        previousNumber = total
    }
    
    
    
    @IBAction func factorial(_ sender: UIButton) {
        var fact:Int = 1
        if(numberOnScreen == 0) {
            fact = 1
        } else {
            for i in 1...numberOnScreen {
                fact *= i
            }
        }
        total = fact
        output.text = String(total)
        numberOnScreen = Int(output.text!)!
        previousNumber = total
        operating = true
    }
    
    func getHistoryArray() -> [String] {
        return history
    }
    
    @IBAction func showHistory(_ sender: UIButton) {
        let historyPopUp = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID") as! HistoryViewController;
        self.addChildViewController(historyPopUp)
        historyPopUp.view.frame = self.view.frame
        self.view.addSubview(historyPopUp.view)
        historyPopUp.didMove(toParentViewController: self)
        let scrollView = historyPopUp.scrollView!
        for index in 0..<history.count {
            let label = UILabel(frame: CGRect(x: 50, y: index * 25 + 50, width: 300, height: 40))
            label.text = history[index]
            scrollView.addSubview(label)
        }
    }
    
    @IBAction func reset(_ sender: UIButton) {
        previousNumber = 0
        numberOnScreen = 0
        operating = false
        output.text = ""
        count = 0
        total = 0
        op = ""
        current = ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

