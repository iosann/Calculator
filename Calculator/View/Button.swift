//
//  Button.swift
//  Calculator
//
//  Created by Anna Belousova on 31.05.2021.
//

import UIKit

class Button: UIButton {

	private(set) var buttonArray = [UIButton]()
	private let symbolArray =
		["0", ",", "=", "1", "2", "3", "+", "4", "5", "6", "-", "7", "8", "9", "×", "AC", "⁺∕₋", "%", "÷"]

	init() {
		super.init(frame: .zero)
		createArray()
		colorButton()
		setTitle()
		setTitleForACButton("AC")
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func createArray() {
		for _ in 1...symbolArray.count {
			let button = UIButton()
			button.showsTouchWhenHighlighted = true
			buttonArray.append(button)
			addSubview(button)
		}
	}

	private func colorButton() {
		for (index, button) in buttonArray.enumerated() {
			switch index {
			case 0, 1, 3, 4, 5, 7, 8, 9, 11, 12, 13:
				button.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
				button.setTitleColor(.white, for: .normal)
				button.titleLabel?.font = UIFont(name: "FiraSans-Regular", size: 36)
			case 2, 6, 10, 14, 18:
				button.backgroundColor = UIColor(red: 1, green: 0.584, blue: 0, alpha: 1)
				button.setTitleColor(.white, for: .normal)
				button.titleLabel?.font = UIFont(name: "FiraSans-Regular", size: 50)
			case 15, 16, 17:
				button.backgroundColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1)
				button.setTitleColor(.black, for: .normal)
				button.titleLabel?.font = UIFont(name: "FiraSans-Regular", size: 36)
			default: break
			}
		}
	}

	private func setTitle() {
		for (button, symbol) in zip(buttonArray, symbolArray) {
			button.setTitle(symbol, for: .normal)
		}
	}

	func setTitleForACButton(_ title: String) {
		buttonArray[15].setTitle(title, for: .normal)
	}
}
