//
//  ViewController.swift
//  Calculator
//
//  Created by Anna Belousova on 25.05.2021.
//

import UIKit

class CalculatorViewController: UIViewController {

	private let screen = Screen()

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
		guard let title = sender.titleLabel?.text else { return }
			switch title {
			case "1", "2", "3", "4", "5", "6", "7", "8", "9":
				screen.button.setTitleForACButton("C")
			case ",":
				screen.button.setTitleForACButton("C")
			case "C":
				screen.button.setTitleForACButton("AC")
			default:
				break
		}
	}

	private func addGestureRecognizer() {
		let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeLabel))
		swipe.direction = [.left, .right]
		screen.windowLabel.isUserInteractionEnabled = true
		screen.windowLabel.addGestureRecognizer(swipe)
	}

	@objc private func swipeLabel() {
		if screen.windowLabel.text != "0" {
			screen.windowLabel.text?.removeLast()
		}
	}
}

