//
//  CalculatorVC.swift
//  CalculatorApp
//
//  Created by Dawid Grazawski on 11/06/2025.
//

import UIKit

class CalculatorVC: UIViewController {
    
    private enum CalcState {
        case clear
        case fill
    }
    
    private enum CalcSign {
        case add
        case divide
        case multiply
        case subtract
        case none
    }
    
    private enum CalcError: Error {
        case dividedByZero
    }
    
    private let calcDisplayLabel = {
        let labelSize = CGRect(x: 20, y: 80, width: 350, height: 100)
        let label = UILabel(frame: labelSize)
        label.text = "0"
        label.font = .systemFont(ofSize: 50, weight: .bold)
        label.textAlignment = .right
        label.backgroundColor = .white
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        return label
    }()
    
    private var calcState = CalcState.clear
    private var calcSign: CalcSign = .none
    private var memory: Double?
    private var currentValue: Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(calcDisplayLabel)
        setup()
        
    }
    
    private func createButton(label: String, frame: CGRect) -> UIButton {
        let button = UIButton(frame: frame)
        button.setTitle(label, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 50, weight: .bold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return button
    }
    
    private func setup(){
        let buttonTitles = ["7", "8", "9", "/",
                            "4", "5", "6", "*",
                            "1", "2", "3", "-",
                            "AC", "0", "=", "+"]
        let buttonSize: CGFloat = 80
        let buttonsPerRow = 4
        let spacing: CGFloat = 8
        let startX: CGFloat = 20
        let startY: CGFloat = 200
        
        for i in 0..<buttonTitles.count {
            let row = i / buttonsPerRow
            let col = i % buttonsPerRow
            let x = startX + CGFloat(col) * (buttonSize + spacing)
            let y = startY + CGFloat(row) * (buttonSize + spacing)
            let frame = CGRect(x: x, y: y, width: buttonSize, height: buttonSize)
            let button = createButton(label: buttonTitles[i], frame: frame)
            view.addSubview(button)
        }
    }
    
    @objc private func pressButton(_ sender: UIButton) {
        guard let labelValue = sender.titleLabel?.text else { return }
        switch labelValue {
            
        case "0"..."9":
            if calcState == .clear {
                calcDisplayLabel.text = labelValue
                currentValue = Double(calcDisplayLabel.text ?? "")
                calcState = .fill
            } else {
                calcDisplayLabel.text = (calcDisplayLabel.text ?? "") + labelValue
                currentValue = Double(calcDisplayLabel.text ?? "")
            }
            
        case "AC":
            calcDisplayLabel.text = "0"
            calcState = .clear
            calcSign = .none
            memory = nil
            currentValue = nil
            
            
        case "+":
            memory = Double(calcDisplayLabel.text ?? "0")
            calcSign = .add
            calcState = .clear
        case "-":
            memory = Double(calcDisplayLabel.text ?? "0")
            calcSign = .subtract
            calcState = .clear
        case "*":
            memory = Double(calcDisplayLabel.text ?? "0")
            calcSign = .multiply
            calcState = .clear
        case "/":
            memory = Double(calcDisplayLabel.text ?? "0")
            calcSign = .divide
            calcState = .clear
        case "=":
            do {
                guard let firstNumber = memory else { return }
                guard let valueOnDisplay = currentValue else { return }
                
                switch calcSign {
                case .add:
                    memory = firstNumber + valueOnDisplay
                    if memory == floor(memory ?? 0.0) {
                        calcDisplayLabel.text = String(format: "%.0f",memory ?? 0.0)
                    } else {
                        calcDisplayLabel.text = String(memory ?? 0.0)
                    }
                    
                case .divide:
                    if valueOnDisplay == 0 {
                        throw CalcError.dividedByZero
                    }
                    memory = firstNumber / valueOnDisplay
                    if memory == floor(memory ?? 0.0) {
                        calcDisplayLabel.text = String(format: "%.0f",memory ?? 0.0)
                    } else {
                        calcDisplayLabel.text = String(memory ?? 0.0)
                    }
                case .multiply:
                    memory = firstNumber * valueOnDisplay
                    if memory == floor(memory ?? 0.0) {
                        calcDisplayLabel.text = String(format: "%.0f",memory ?? 0.0)
                    } else {
                        calcDisplayLabel.text = String(memory ?? 0.0)
                    }
                case .subtract:
                    memory = firstNumber - valueOnDisplay
                    if memory == floor(memory ?? 0.0) {
                        calcDisplayLabel.text = String(format: "%.0f",memory ?? 0.0)
                    } else {
                        calcDisplayLabel.text = String(memory ?? 0.0)
                    }
                default:
                    return
                }
            } catch {
                print("Dividing by 0 not allowed!")
                calcDisplayLabel.text = "ERROR!!!"
            }
            
        default:
            return
        }
    }

}

