//
//  InfoView.swift
//  CreateAIVideo
//
//  Created by Vasiliy Vygnych on 15.10.2024.
//

import UIKit
import SnapKit

class InfoView: UIView {
    
    private var nameTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = .systemFont(ofSize: 14,
                                weight: .medium)
        view.textAlignment = .center
        view.textColor = .white
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
         return view
    }()
    private var imageView: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var stackView: UIStackView = {
       let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.layer.cornerRadius = 21
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        view.backgroundColor = .clear
        return view
    }()
    init() {
        super.init(frame: .zero)
        addSubview()
        setupeConstraints()
        self.isUserInteractionEnabled = true
        imageView.image = Constants.ImagePaywall.included
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(name: String,
                   index: Int,
                   absent: [Int]?) {
        absent?.forEach { id in
            if index == id {
                imageView.image = Constants.ImagePaywall.notIncluded
                nameTitle.textColor = Constants.ColorPaywall.colorWhite24
                let attributedString = NSMutableAttributedString(string: name)
                attributedString.addAttribute(.strikethroughStyle,
                                              value: NSUnderlineStyle.single.rawValue,
                                              range: NSRange(location: 0,
                                                             length: name.count))
                nameTitle.attributedText = attributedString
            }
        }
        nameTitle.text = name.localized(LanguageConstant.appLaunguage)
    }
    private func addSubview() {
        self.addSubview(stackView)
        stackView.addSubview(nameTitle)
        stackView.addSubview(imageView)
    }
    private func setupeConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        nameTitle.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.lessThanOrEqualToSuperview().inset(35)
            make.height.equalTo(27)
        }
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(22)
            make.height.equalTo(23)
            make.right.equalTo(nameTitle.snp.left).inset(-10)
        }
    }
}
