//
//  SubscribeView.swift
//  CreateAIVideo
//
//  Created by Vasiliy Vygnych on 15.10.2024.
//

import UIKit
import SnapKit

final class SubscribeView: UIView {
    
    var viewModel: MainViewModelProtocol?
    var modeShow = ModeShowSubscription.none
    var modeSubscription = SubscriptionMode.none
    var selectMode = SelectSubscription.plus
    weak var delegate: SubscriptionDelegalate?
    
    var plusModel = [Constants.TextPaywall.firstInfo.localized(LanguageConstant.appLaunguage),
                     Constants.TextPaywall.secondInfo.localized(LanguageConstant.appLaunguage),
                     Constants.TextPaywall.thirdInfo.localized(LanguageConstant.appLaunguage),
                     Constants.TextPaywall.fourthInfo.localized(LanguageConstant.appLaunguage),
                     Constants.TextPaywall.fifthInfo.localized(LanguageConstant.appLaunguage)]
    
    var ultraModel = [Constants.TextPaywall.firstUltraInfo.localized(LanguageConstant.appLaunguage),
                      Constants.TextPaywall.secondUltraInfo.localized(LanguageConstant.appLaunguage),
                      Constants.TextPaywall.thirdUltraInfo.localized(LanguageConstant.appLaunguage),
                      Constants.TextPaywall.fourthUltraInfo.localized(LanguageConstant.appLaunguage),
                     Constants.TextPaywall.fifthInfo.localized(LanguageConstant.appLaunguage)]
    
    var freeModel = [Constants.TextPaywall.firstFreeInfo.localized(LanguageConstant.appLaunguage),
                     Constants.TextPaywall.secondFreeInfo.localized(LanguageConstant.appLaunguage),
                     Constants.TextPaywall.thirdFreeInfo.localized(LanguageConstant.appLaunguage),
                     Constants.TextPaywall.fourthFreeInfo.localized(LanguageConstant.appLaunguage),
                     Constants.TextPaywall.fifthInfo.localized(LanguageConstant.appLaunguage)]
    
    var priceTitle: [String]?
    
    private var popularView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        return view
    }()
    private var popularViewTitle: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 15,
                                weight: .bold)
        view.textAlignment = .right
        view.textColor = .black
        return view
    }()
    private var popularViewImage: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private var subscribePlus: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = 1
        view.layer.cornerRadius = 12
        return view
    }()
    private var titleButtonPlus: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 17,
                                weight: .bold)
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    private var subtitleButtonPlus: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 13,
                                weight: .medium)
        view.textAlignment = .center
        return view
    }()
    private var pricePlusTitle: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 26,
                                weight: .bold)
        view.textAlignment = .right
        view.textColor = .white
        return view
    }()
    private var infoPlusTitle: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 12,
                                weight: .medium)
        view.textAlignment = .right
        return view
    }()
    
    private var subscribeUltra: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = 2
        view.layer.cornerRadius = 12
        return view
    }()
    private var titleButtonUltra: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 17,
                                weight: .bold)
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    private var subtitleButtonUltra: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 13,
                                weight: .medium)
        view.textAlignment = .center
        return view
    }()
    private var priceUltraTitle: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 26,
                                weight: .bold)
        view.textAlignment = .right
        view.textColor = .white
        return view
    }()
    private var infoUltraTitle: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 12,
                                weight: .medium)
        view.textAlignment = .right
        return view
    }()
    
    private var buttonEree: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = 3
        view.layer.cornerRadius = 12
        return view
    }()
    private var titleButtonFree: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 17,
                                weight: .bold)
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    private var subtitleButtonFree: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 13,
                                weight: .medium)
        view.textAlignment = .center
        return view
    }()
    private var priceFreeTitle: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 26,
                                weight: .bold)
        view.textAlignment = .right
        view.textColor = .white
        return view
    }()
    private var infoFreeTitle: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 12,
                                weight: .medium)
        view.textAlignment = .right
        return view
    }()
    private var currentPlanTitle: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 12,
                                weight: .medium)
        view.textAlignment = .right
        return view
    }()
    private var infoPlanStackView: UIStackView = {
       let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fillEqually
        view.backgroundColor = .clear
        view.axis = .vertical
        return view
    }()
    private var infoUltraStackView: UIStackView = {
       let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fillEqually
        view.backgroundColor = .clear
        view.axis = .vertical
        return view
    }()
    private var infoFreeStackView: UIStackView = {
       let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fillEqually
        view.backgroundColor = .clear
        view.axis = .vertical
        return view
    }()
    init() {
        super.init(frame: .zero)
        setupeColor()
        setupeMode(.none)
        setupeView()
        setupeButton()
        setupeData()
        setupeConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func checkAssets(model: AppData) {
        isEnabledPlusSubscripe(model.plusIsActive)
        isEnabledUltraSubscripe(model.ultraIsActive)
        isEnabledFreeSubscripe(model.freeIsActive)
    }
    func isEnabledPlusSubscripe(_ bool: Bool) {
        subscribePlus.isEnabled = bool
        titleButtonPlus.alpha = bool ? 1 : 0.3
        subtitleButtonPlus.alpha = bool ? 1 : 0.3
        infoPlusTitle.alpha = bool ? 1 : 0.3
        pricePlusTitle.alpha = bool ? 1 : 0.3
        popularView.alpha = bool ? 1 : 0.3
    }
    func isEnabledUltraSubscripe(_ bool: Bool) {
        subscribeUltra.isEnabled = bool
        titleButtonUltra.alpha = bool ? 1 : 0.3
        subtitleButtonUltra.alpha = bool ? 1 : 0.3
        infoUltraTitle.alpha = bool ? 1 : 0.3
        priceUltraTitle.alpha = bool ? 1 : 0.3
        
    }
    func isEnabledFreeSubscripe(_ bool: Bool) {
        buttonEree.isEnabled = bool
        titleButtonFree.alpha = bool ? 1 : 0.3
        subtitleButtonFree.alpha = bool ? 1 : 0.3
        infoFreeTitle.alpha = bool ? 1 : 0.3
        priceFreeTitle.alpha = bool ? 1 : 0.3
    }
    func setupeMode(_ model: ModeShowSubscription) {
        setupeData()
        switch model {
        case .monthly:
            setupeTextForMonthly()
            modeShow = .monthly
            selectSubscription(selectMode,
                               show: .monthly)
            ultraInfo()
        
            subscribePlus.layer.borderWidth = 0
            subscribeUltra.layer.borderWidth = 0
            buttonEree.layer.borderWidth = 0
            
        case .yearly:
            setupeTextForYearly()
            modeShow = .yearly
            selectSubscription(selectMode,
                               show: .yearly)
        case .none:
            setupeTextForMonthly()
        }
    }
    func selectSubscription(_ mode: SelectSubscription,
                            show: ModeShowSubscription) {
        switch mode {
        case .plus:
            selectMode = .plus
            if show == .monthly {
                delegate?.subscriptionSelected(.monthlyPlus)
                modeSubscription = .monthlyPlus
            }
            if show == .yearly {
                delegate?.subscriptionSelected(.yearlyPlus)
                modeSubscription = .yearlyPlus
            }
        case .ultra:
            selectMode = .ultra
            if show == .monthly {
                delegate?.subscriptionSelected(.monthlyUltra)
                modeSubscription = .monthlyUltra
            }
            if show == .yearly {
                delegate?.subscriptionSelected(.yearlyUltra)
                modeSubscription = .yearlyUltra
            }
        case .free:
            selectMode = .free
            delegate?.subscriptionSelected(.free)
        }
    }
    private func showDescription(_ mode: SelectSubscription) {
        switch mode {
        case .plus:
            selectSubscription(.plus,
                               show: modeShow)
            plusInfo()
        case .ultra:
            selectSubscription(.ultra,
                               show: modeShow)
            ultraInfo()
        case .free:
            selectSubscription(.free,
                               show: modeShow)
            freeInfo()
        }
    }
    func plusInfo() {
        infoPlanStackView.isHidden = false
        infoUltraStackView.isHidden = true
        infoFreeStackView.isHidden = true
    }
    func ultraInfo() {
        infoUltraStackView.isHidden = false
        infoPlanStackView.isHidden = true
        infoFreeStackView.isHidden = true
    }
    func freeInfo() {
        infoFreeStackView.isHidden = false
        infoUltraStackView.isHidden = true
        infoPlanStackView.isHidden = true
    }
    private func setupeView() {
        addSubview(subscribePlus)
        subscribePlus.addSubview(titleButtonPlus)
        subscribePlus.addSubview(subtitleButtonPlus)
        subscribePlus.addSubview(infoPlusTitle)
        subscribePlus.addSubview(pricePlusTitle)
        
        addSubview(popularView)
        popularView.addSubview(popularViewTitle)
        popularView.addSubview(popularViewImage)
        
        addSubview(subscribeUltra)
        subscribeUltra.addSubview(titleButtonUltra)
        subscribeUltra.addSubview(subtitleButtonUltra)
        subscribeUltra.addSubview(infoUltraTitle)
        subscribeUltra.addSubview(priceUltraTitle)
        
        addSubview(buttonEree)
        buttonEree.addSubview(titleButtonFree)
        buttonEree.addSubview(subtitleButtonFree)
        buttonEree.addSubview(infoFreeTitle)
        buttonEree.addSubview(priceFreeTitle)
        buttonEree.addSubview(currentPlanTitle)
        
        addSubview(infoPlanStackView)
        addSubview(infoUltraStackView)
        addSubview(infoFreeStackView)
    }
    func setupeData() {
        setupePlusInfo()
        setupeUltraInfo()
        setupeFreeInfo()
    }
    func setupePlusInfo() {
        infoPlanStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        popularViewImage.image = Constants.ImagePaywall.crownImage
        let absentPlus = [4]
        plusModel.enumerated().forEach { index, name in
            let view = InfoView()
            view.configure(name: name,
                           index: index,
                           absent: absentPlus)
            infoPlanStackView.addArrangedSubview(view)
        }
    }
    func setupeUltraInfo() {
        infoUltraStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        ultraModel.enumerated().forEach { index, name in
            let view = InfoView()
            view.configure(name: name,
                           index: index,
                           absent: nil)
            infoUltraStackView.addArrangedSubview(view)
        }
    }
    func setupeFreeInfo() {
        infoFreeStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let absentFree = [1, 2, 4]
        freeModel.enumerated().forEach { index, name in
            let view = InfoView()
            view.configure(name: name,
                           index: index,
                           absent: absentFree)
            infoFreeStackView.addArrangedSubview(view)
        }
    }
    
    
    func setupeTextForMonthly() {
        titleButtonPlus.text = Constants.TextPaywall.titleButtonPlus.localized(LanguageConstant.appLaunguage)
        subtitleButtonPlus.text = Constants.TextPaywall.subtitleButtonPlus.localized(LanguageConstant.appLaunguage)
        
        infoPlusTitle.text = Constants.TextPaywall.infoPriceMonth.localized(LanguageConstant.appLaunguage) //
        
        pricePlusTitle.text = correctPrice(priceTitle?[0])
        
        popularViewTitle.text = Constants.TextPaywall.popularViewTitle.localized(LanguageConstant.appLaunguage)
        
        titleButtonUltra.text = Constants.TextPaywall.titleButtonUltra.localized(LanguageConstant.appLaunguage)
        subtitleButtonUltra.text = Constants.TextPaywall.subtitleButtonUltra.localized(LanguageConstant.appLaunguage)
        
        infoUltraTitle.text = Constants.TextPaywall.infoPriceMonth.localized(LanguageConstant.appLaunguage) //
        
        priceUltraTitle.text = correctPrice(priceTitle?[1])
        
        titleButtonFree.text = Constants.TextPaywall.titleButtonFree.localized(LanguageConstant.appLaunguage)
        subtitleButtonFree.text = Constants.TextPaywall.subtitleButtonFree.localized(LanguageConstant.appLaunguage)
        
        infoFreeTitle.text = Constants.TextPaywall.infoPriceMonth.localized(LanguageConstant.appLaunguage) //
        
        
        if let currenc = viewModel?.currencPrice(from: correctPrice(priceTitle?[2])) {
            priceFreeTitle.text = "\(currenc)0"
        }
        currentPlanTitle.text = Constants.TextPaywall.currentPlanTitle.localized(LanguageConstant.appLaunguage)
    }
    private func setupeTextForYearly() {
        pricePlusTitle.text = correctPrice(priceTitle?[2])
        priceUltraTitle.text = correctPrice(priceTitle?[3])
        infoFreeTitle.text = Constants.TextPaywall.infoPriceYear.localized(LanguageConstant.appLaunguage)
        infoUltraTitle.text = Constants.TextPaywall.infoPriceYear.localized(LanguageConstant.appLaunguage)
        infoPlusTitle.text = Constants.TextPaywall.infoPriceYear.localized(LanguageConstant.appLaunguage)
    }
    func correctPrice(_ value: String?) -> String {
        guard let value else { return "" }
        if let index = value.firstIndex(of: ".") {
            let substring = value[value.index(after: index)...]
            if substring.allSatisfy({ $0 == "0" }) {
                return String(value[..<index])
            }
        }
        return value
    }
    private func setupeColor() {
        backgroundColor = Constants.ColorPaywall.viewBackgroundColor
    
        subscribePlus.backgroundColor = Constants.ColorPaywall.colorSubscribeButton
        subtitleButtonPlus.textColor = Constants.ColorPaywall.colorSubtitleButton
        infoPlusTitle.textColor = Constants.ColorPaywall.colorSubtitleButton
        
        subscribeUltra.backgroundColor = Constants.ColorPaywall.colorSubscribeButton
        subtitleButtonUltra.textColor = Constants.ColorPaywall.colorSubtitleButton
        infoUltraTitle.textColor = Constants.ColorPaywall.colorSubtitleButton
        
        buttonEree.backgroundColor = Constants.ColorPaywall.colorSubscribeButton
        subtitleButtonFree.textColor = Constants.ColorPaywall.colorSubtitleButton
        infoFreeTitle.textColor = Constants.ColorPaywall.colorSubtitleButton
        currentPlanTitle.textColor = Constants.ColorPaywall.colorWhite16
    }
    private func setupeButton() {
        subscribePlus.addTarget(self,
                                action: #selector(subscribeSelect),
                                for: .touchUpInside)
        subscribeUltra.addTarget(self,
                                 action: #selector(subscribeSelect),
                                 for: .touchUpInside)
        buttonEree.addTarget(self,
                             action: #selector(subscribeSelect),
                             for: .touchUpInside)
    }
    @objc func subscribeSelect(_ sender: UIButton) {
        delegate?.activeButton()
        switch sender.tag {
        case 1:
            viewModel?.viewAnimate(view: subscribePlus,
                                   duration: 0.2,
                                   scale: 0.98)
            viewModel?.viewAnimate(view: popularView,
                                   duration: 0.2,
                                   scale: 0.98)
            showDescription(.plus)
            subscribeUltra.layer.borderWidth = 0
            buttonEree.layer.borderWidth = 0
            subscribePlus.layer.borderWidth = 1
            subscribePlus.layer.borderColor = UIColor.white.cgColor
        case 2:
            viewModel?.viewAnimate(view: subscribeUltra,
                                   duration: 0.2,
                                   scale: 0.98)
            showDescription(.ultra)
            subscribePlus.layer.borderWidth = 0
            buttonEree.layer.borderWidth = 0
            subscribeUltra.layer.borderWidth = 1
            subscribeUltra.layer.borderColor = UIColor.white.cgColor
        case 3:
            viewModel?.viewAnimate(view: buttonEree,
                                   duration: 0.2,
                                   scale: 0.98)
            subscribePlus.layer.borderWidth = 0
            subscribeUltra.layer.borderWidth = 0
            buttonEree.layer.borderWidth = 1
            buttonEree.layer.borderColor = UIColor.white.cgColor
            showDescription(.free)
        default:
            break
        }
    }
    private func setupeConstraints() {
        subscribePlus.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.width.equalToSuperview().inset(20)
            make.left.equalTo(20)
            
            make.height.equalTo(69)
        }
        popularView.snp.makeConstraints { make in
            make.centerY.equalTo(subscribePlus.snp.top)
            make.centerX.equalToSuperview()
            make.height.equalTo(28)
        }
        popularViewTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-10)
            make.height.equalTo(20)
            make.width.lessThanOrEqualTo(150)
        }
        popularViewImage.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(19)
            make.right.equalTo(popularViewTitle.snp.left).inset(-10)
        }
        
        titleButtonPlus.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-10)
            make.left.equalTo(20)
            make.height.equalTo(23)
            make.width.lessThanOrEqualTo(100)
        }
        subtitleButtonPlus.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(15)
            make.left.equalTo(20)
            make.height.equalTo(23)
            make.width.lessThanOrEqualTo(200)
        }
        infoPlusTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-20)
            make.height.equalTo(15)
            make.width.lessThanOrEqualTo(80)
        }
        pricePlusTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(infoPlusTitle.snp.left).inset(-5)
            make.height.equalTo(35)
            make.width.lessThanOrEqualTo(100)
        }
 
        subscribeUltra.snp.makeConstraints { make in
            make.top.equalTo(subscribePlus.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(20)
            make.left.equalTo(20)
            
            make.height.equalTo(69)
        }
        titleButtonUltra.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-10)
            make.left.equalTo(20)
            make.height.equalTo(23)
            make.width.lessThanOrEqualTo(100)
        }
        subtitleButtonUltra.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(15)
            make.left.equalTo(20)
            make.height.equalTo(23)
            make.width.lessThanOrEqualTo(200)
        }
        infoUltraTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-20)
            make.height.equalTo(15)
            make.width.lessThanOrEqualTo(80)
        }
        priceUltraTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(infoUltraTitle.snp.left).inset(-5)
            make.height.equalTo(35)
            make.width.lessThanOrEqualTo(100)
        }
        
        buttonEree.snp.makeConstraints { make in
            make.top.equalTo(subscribeUltra.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(20)
            make.left.equalTo(20)
            
            make.height.equalTo(69)
        }
        titleButtonFree.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-10)
            make.left.equalTo(20)
            make.height.equalTo(23)
            make.width.lessThanOrEqualTo(100)
        }
        subtitleButtonFree.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(15)
            make.left.equalTo(20)
            make.height.equalTo(23)
            make.width.lessThanOrEqualTo(200)
        }
        infoFreeTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-20)
            make.height.equalTo(15)
            make.width.lessThanOrEqualTo(80)
        }
        priceFreeTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(infoFreeTitle.snp.left).inset(-5)
            make.height.equalTo(35)
            make.width.lessThanOrEqualTo(100)
        }
        currentPlanTitle.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.height.equalTo(15)
            make.width.lessThanOrEqualTo(100)
            make.bottom.equalToSuperview().inset(5)
        }
        
        infoPlanStackView.snp.makeConstraints { make in
            make.top.equalTo(subtitleButtonFree.snp.bottom).offset(30)
            make.width.equalToSuperview()
            make.height.equalTo(180)
        }
        infoUltraStackView.snp.makeConstraints { make in
            make.top.equalTo(subtitleButtonFree.snp.bottom).offset(30)
            make.width.equalToSuperview()
            make.height.equalTo(180)
        }
        infoFreeStackView.snp.makeConstraints { make in
            make.top.equalTo(subtitleButtonFree.snp.bottom).offset(30)
            make.width.equalToSuperview()
            make.height.equalTo(180)
        }
    }
}
