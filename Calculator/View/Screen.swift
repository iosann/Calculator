//
//  Screen.swift
//  Calculator
//
//  Created by Anna Belousova on 31.05.2021.
//

import UIKit
import SnapKit

class Screen: UIView {

	private(set) var button = Button()

	private lazy var bottomStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews:
			[button.buttonArray[0], button.buttonArray[1], button.buttonArray[2]])
		configureStackView(stackView)
		stackView.distribution = .fillProportionally
		return stackView
	}()

	private lazy var secondStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews:
			[button.buttonArray[3], button.buttonArray[4], button.buttonArray[5], button.buttonArray[6]])
		configureStackView(stackView)
		return stackView
	}()

	private lazy var thirdStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews:
			[button.buttonArray[7], button.buttonArray[8], button.buttonArray[9], button.buttonArray[10]])
		configureStackView(stackView)
		return stackView
	}()

	private lazy var fourthStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews:
			[button.buttonArray[11], button.buttonArray[12], button.buttonArray[13], button.buttonArray[14]])
		configureStackView(stackView)
		return stackView
	}()

	private lazy var fifthStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews:
			[button.buttonArray[15], button.buttonArray[16], button.buttonArray[17], button.buttonArray[18]])
		configureStackView(stackView)
		return stackView
	}()

	private lazy var allButtonsStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews:
			[fifthStackView, fourthStackView, thirdStackView, secondStackView, bottomStackView])
		configureStackView(stackView)
		stackView.axis = .vertical
		return stackView
	}()

	var windowLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.backgroundColor = .black
		label.textAlignment = .right
		label.textColor = .white
		label.font = UIFont(name: "FiraSans-Light", size: 94)
		label.text = "0"
		label.numberOfLines = 1
		label.adjustsFontSizeToFitWidth = true
		return label
	}()

	init() {
		super.init(frame: .zero)
		backgroundColor = .black
		addSubview(windowLabel)
		addSubview(allButtonsStackView)
		makeConstraints()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		for button in button.buttonArray {
			button.layer.cornerRadius = button.bounds.height / 2
		}
		button.buttonArray[0].contentHorizontalAlignment = .left
		button.buttonArray[0].contentEdgeInsets = UIEdgeInsets(
			top: 0, left: button.buttonArray[0].bounds.size.height / 2 - 7, bottom: 0, right: 0)
	}

	private func configureStackView(_ stackView: UIStackView) {
		stackView.axis = .horizontal
		stackView.alignment = .fill
		stackView.spacing = 14
		stackView.distribution = .fill
	}

	private func makeConstraints() {

		for (index, button) in button.buttonArray.enumerated() {
			switch index {
			case 0:
				button.snp.makeConstraints { make in
				make.width.greaterThanOrEqualTo(164).priority(999)
				make.height.greaterThanOrEqualTo(75)
				}
			default:
				button.snp.makeConstraints { make in
				make.width.greaterThanOrEqualTo(75).priority(999)
				make.height.equalTo(button.snp.width)
				}
			}
		}

		allButtonsStackView.snp.makeConstraints { make in
			if #available(iOS 11.0, *) {
				make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).inset(16)
				make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(16)
				make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).inset(17).priority(999)
			}
			else {
				make.leading.bottom.equalToSuperview().inset(16)
				make.trailing.equalToSuperview().inset(17)
			}
		}

		bottomStackView.snp.makeConstraints { make in
			make.height.equalTo(secondStackView.snp.height)
		}

		windowLabel.snp.makeConstraints { make in
			if #available(iOS 11.0, *) {
				make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).inset(15)
				make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).inset(17).priority(999)
			}
			else {
				make.leading.equalToSuperview().inset(15)
				make.trailing.equalToSuperview().inset(17).priority(999)
			}
			make.bottom.equalTo(allButtonsStackView.snp.top).inset(-8)
		}
	}
}
