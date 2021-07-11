//
//  ViewController.swift
//  Calculator
//
//  Created by Anna Belousova on 25.05.2021.
//

import UIKit

class CalculatorViewController: UIViewController {

	private let screen = Screen()
	private var firstOperand = 0.0
	private var secondOperand = 0.0
	private var operatorSign = ""
	private var isPressedAcButton = false
	private var isTyping = false
	private var isFloatNumber = false

	var currentInput: Double {
		get {
			guard let text = screen.windowLabel.text?.replacingOccurrences(of: ",", with: ".") else { return 0 }
			return Double(text) ?? 0
		}
		set {
			let newValue = Double(round(100_000_000 * newValue) / 100_000_000)
			guard newValue.isInfinite == false else {
				screen.windowLabel.text = "Error"
				return
			}
			if String(newValue).hasSuffix(".0") {
				screen.windowLabel.text = String(String(newValue).dropLast(2)).replacingOccurrences(of: ".", with: ",")
			}
			else {
				screen.windowLabel.text = String(newValue).replacingOccurrences(of: ".", with: ",")
			}
		}
	}

	override func loadView() {
		self.view = screen
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		addTargets()
		addGestureRecognizer()
	}

	private func addTargets() {
		for button in screen.button.buttonArray {
			button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
		}
	}

	@objc private func buttonTapped(_ sender: UIButton) {
		guard let title = sender.currentTitle else { return }
			switch title {
			case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
				numberButtonPressed(with: title)
				screen.button.setTitleForACButton("C")
			case "+", "-", "×", "÷":
				operatorButtonPressed(with: title)
			case "⁺∕₋":
				negativeSwitchButtonPressed()
			case "=":
				equalButtonPressed()
			case ",":
				screen.button.setTitleForACButton("C")
				floatButtonPressed()
			case "%":
				percentButtonPressed()
			case "C":
				clearButtonPressed()
				screen.button.setTitleForACButton("AC")
			default:
				break
		}
	}

	private func numberButtonPressed(with title: String) {
		guard var displayText = screen.windowLabel.text else { return }
		if isTyping {
			if displayText.count < 9 {
				if displayText.hasPrefix("0") && displayText.hasPrefix("0,") == false {
					displayText = String(displayText.dropFirst())
				}
				screen.windowLabel.text = displayText + title
			}
		}
		else {
			screen.windowLabel.text = title
			isTyping = true
		}
	}

	private func operatorButtonPressed(with title: String) {
		operatorSign = title
		firstOperand = currentInput
		isTyping = false
		isFloatNumber = false
	}

	private func equalButtonPressed() {
		if isTyping { secondOperand = currentInput }
		switch operatorSign {
		case "+":
			currentInput = firstOperand + secondOperand
		case "-":
			currentInput = firstOperand - secondOperand
		case "×":
			currentInput = firstOperand * secondOperand
		case "÷":
			currentInput = firstOperand / secondOperand
		default: break
		}
		firstOperand = currentInput
		isTyping = true
		isFloatNumber = false
	}

	private func floatButtonPressed() {
		if isTyping && isFloatNumber == false {
			screen.windowLabel.text = (screen.windowLabel.text ?? "") + ","
			isFloatNumber = true
		} else if isTyping == false && isFloatNumber == false {
			currentInput = Double(screen.windowLabel.text ?? "") ?? 0.0
			screen.windowLabel.text = "0,"
			isFloatNumber = true
			isTyping = true
		}
	}

	private func negativeSwitchButtonPressed() {
			currentInput *= -1
	}

	private func percentButtonPressed() {
		currentInput /= 100
	}

	private func addGestureRecognizer() {
		let swipe = UISwipeGestureRecognizer(target: self, action: #selector(deleteSymbolFromLabel))
		swipe.direction = [.left, .right]
		screen.windowLabel.isUserInteractionEnabled = true
		screen.windowLabel.addGestureRecognizer(swipe)
	}

	@objc func deleteSymbolFromLabel() {
		guard isTyping, let labelText = screen.windowLabel.text else { return }
		let newText = String(labelText.dropLast())
		if newText.count > 0 {
			screen.windowLabel.text = newText
		} else {
			screen.windowLabel.text = "0"
			isTyping = false
		}
	}

	private func clearButtonPressed() {
		screen.windowLabel.text = "0"
		firstOperand = 0
		secondOperand = 0
		currentInput = 0
		isTyping = false
		operatorSign = ""
		isFloatNumber = false
	}
}

