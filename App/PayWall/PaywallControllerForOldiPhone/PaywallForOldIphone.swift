//
//  PaywallForOldIphone.swift
//  CreateAIVideo
//
//  Created by Vasiliy Vygnych on 19.12.2024.
//

import UIKit
import SnapKit

class PaywallForOldIphone: UIViewController {
    
    var viewModel: MainViewModelProtocol?
    var modeSubscription = SubscriptionMode.none
    private let subscribeView = SubscribeViewForOldIPhone()
    var isFirst = Bool()
    private var contentSize: CGSize {
        CGSize(width: view.frame.width,
               height: view.frame.height)
    }
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.alwaysBounceVertical = true
        view.backgroundColor = .clear
        view.contentSize = contentSize
        return view
    }()
    private var headerTitle: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 18,
                                weight: .bold)
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    private var closeButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var segmentedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        return view
    }()
    private var monthlyButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.setTitleColor(.black,
                           for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14,
                                            weight: .semibold)
        view.tag = 1
        return view
    }()
    private var yearlyButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = .clear
        view.tag = 2
        return view
    }()
    private var yearlyTitle: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 14,
                                weight: .semibold)
        view.textAlignment = .center
        view.textColor = .white
        return view
    }()
    
    private var subscribeButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.titleLabel?.font = .systemFont(ofSize: 15,
                                            weight: .bold)
        view.setTitleColor(.white,
                           for: .normal)
        return view
    }()
    private var restoreButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = 1
        view.titleLabel?.textAlignment = .center
        return view
    }()
    private var termsButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = 2
        view.titleLabel?.textAlignment = .center
        return view
    }()
    private var privacyButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = 3
        view.titleLabel?.textAlignment = .center
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
        setupeColor()
        setupeSubview()
        addConstraints()
        setupeButton()
        setupeText()
        setupeData()
        viewModel?.delegate(self)
        viewModel?.loadProducts()
        subscribeView.setupeMode(.monthly)
        setupeSubscribeView()
        setupeText()
    }
    func setupeSubscribeView() {
        let data = viewModel?.getAppData()
        data?.forEach({ model in
            subscribeView.checkAssets(model: model)
        })
    }
    private func setupeText() {
        headerTitle.text = Constants.TextPaywall.headerTitle.localized(LanguageConstant.appLaunguage)
        monthlyButton.setTitle(Constants.TextPaywall.firstSegmentText.localized(LanguageConstant.appLaunguage),
                               for: .normal)
        let text = Constants.TextPaywall.secondSegmentText.localized(LanguageConstant.appLaunguage)
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: Constants.TextPaywall.saveText.localized(LanguageConstant.appLaunguage))
        attributedString.addAttribute(.foregroundColor,
                                      value: Constants.ColorPaywall.customBlueColor as Any,
                                      range: range)
        yearlyTitle.attributedText = attributedString
        
        
        restoreButton.setTitle(Constants.TextPaywall.restoreButton.localized(LanguageConstant.appLaunguage),
                      for: .normal)
        restoreButton.titleLabel?.font = .systemFont(ofSize: 14,
                                                  weight: .medium)
        termsButton.setTitle(Constants.TextPaywall.termsButton.localized(LanguageConstant.appLaunguage),
                      for: .normal)
        termsButton.titleLabel?.font = .systemFont(ofSize: 14,
                                                  weight: .medium)
        privacyButton.setTitle(Constants.TextPaywall.privacyButton.localized(LanguageConstant.appLaunguage),
                      for: .normal)
        privacyButton.titleLabel?.font = .systemFont(ofSize: 14,
                                                  weight: .medium)
        
        subscribeButton.setTitle(Constants.TextPaywall.subscribeButtons.localized(LanguageConstant.appLaunguage),
                                 for: .normal)
    }
    private func setupeData() {
        closeButton.setBackgroundImage(Constants.ImagePaywall.closeButton,
                                       for: .normal)
    }
    private func setupeColor() {
        view.backgroundColor = Constants.ColorPaywall.viewBackgroundColor
        subscribeButton.backgroundColor = Constants.ColorPaywall.customBlueColor
        privacyButton.setTitleColor(Constants.ColorPaywall.colorWhite27,
                                    for: .normal)
        restoreButton.setTitleColor(Constants.ColorPaywall.colorWhite27,
                                 for: .normal)
        termsButton.setTitleColor(Constants.ColorPaywall.colorWhite27,
                                 for: .normal)
        segmentedView.backgroundColor = Constants.ColorPaywall.backgrounSegmentView
    }

    private func setupeSubview() {
        view.addSubview(scrollView)
        
        view.addSubview(headerTitle)
        view.addSubview(closeButton)

        scrollView.addSubview(segmentedView)
        segmentedView.addSubview(monthlyButton)
        segmentedView.addSubview(yearlyButton)
        yearlyButton.addSubview(yearlyTitle)

        scrollView.addSubview(subscribeView)
        subscribeView.viewModel = viewModel
        subscribeView.delegate = self

        scrollView.addSubview(subscribeButton)
        subscribeButton.isEnabled = false
        subscribeButton.alpha = 0.3
        view.addSubview(restoreButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)

        
        
        
        
        
//        view.addSubview(segmentedView)
//        segmentedView.addSubview(monthlyButton)
//        segmentedView.addSubview(yearlyButton)
//        yearlyButton.addSubview(yearlyTitle)
//        
//        view.addSubview(subscribeView)
//        subscribeView.viewModel = viewModel
//        subscribeView.delegate = self
//        
//        
//        view.addSubview(subscribeButton)
//        subscribeButton.isEnabled = false
//        subscribeButton.alpha = 0.3
//        view.addSubview(restoreButton)
//        view.addSubview(termsButton)
//        view.addSubview(privacyButton)
    }
    private func setupeButton() {
        subscribeButton.addTarget(self,
                                  action: #selector(subscribe),
                                  for: .touchUpInside)
        closeButton.addTarget(self,
                              action: #selector(tapClose),
                              for: .touchUpInside)
        monthlyButton.addTarget(self,
                                action: #selector(selectSegment),
                                for: .touchUpInside)
        yearlyButton.addTarget(self,
                               action: #selector(selectSegment),
                               for: .touchUpInside)
        
        restoreButton.addTarget(self,
                                action: #selector(pressingButton),
                                for: .touchUpInside)
        termsButton.addTarget(self,
                              action: #selector(pressingButton),
                              for: .touchUpInside)
        privacyButton.addTarget(self,
                                action: #selector(pressingButton),
                                for: .touchUpInside)
    }
    @objc func tapClose() {
        if isFirst == true {
            if viewModel?.getAppData()?.isEmpty == true {
                viewModel?.setMainModel(.free)
            }
            viewModel?.openTabBar()
        } else {
            navigationController?.popViewController(animated: true)
            tabBarController?.tabBar.isHidden = false
        }
    }
    @objc func subscribe() {
        viewModel?.viewAnimate(view: subscribeButton,
                               duration: 0.2,
                               scale: 0.95)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
            if self.modeSubscription == .free {
                viewModel?.setData(mode: .free)
                self.viewModel?.openTabBar()
            }
            self.viewModel?.setupSubscription(self.modeSubscription)
        }
    }
    @objc func selectSegment(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            selectMontly()
        case 2:
            selecYearly()
        default:
            break
        }
    }
    @objc func pressingButton(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            viewModel?.restoreSubscription()
        case 2:
            viewModel?.openWebViewController(title: Constants.TextPaywall.termsOfUse.localized(LanguageConstant.appLaunguage),
                                             mode: .termsOfUse)
        case 3:
            viewModel?.openWebViewController(title: Constants.TextPaywall.privacyPolicy.localized(LanguageConstant.appLaunguage),
                                             mode: .privacyPolicy)
        default:
            break
        }
    }
    func selectMontly() {
        subscribeView.setupeMode(.monthly)
        subscribeButton.alpha = 0.3
        subscribeButton.isEnabled = false
    
        monthlyButton.backgroundColor = .white
        monthlyButton.setTitleColor(.black, for: .normal)
        yearlyButton.backgroundColor = .clear
        yearlyTitle.textColor = .white
        let text = Constants.TextPaywall.secondSegmentText.localized(LanguageConstant.appLaunguage)
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: Constants.TextPaywall.saveText.localized(LanguageConstant.appLaunguage))
        attributedString.addAttribute(.foregroundColor,
                                      value: Constants.ColorPaywall.customBlueColor as Any,
                                      range: range)
        yearlyTitle.attributedText = attributedString
    }
    func selecYearly() {
        subscribeView.setupeMode(.yearly)
        yearlyButton.backgroundColor = .white
        monthlyButton.backgroundColor = .clear
        monthlyButton.setTitleColor(.white,
                                    for: .normal)
        yearlyTitle.textColor = .black
        let text = Constants.TextPaywall.secondSegmentText.localized(LanguageConstant.appLaunguage)
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: Constants.TextPaywall.saveText.localized(LanguageConstant.appLaunguage))
        attributedString.addAttribute(.foregroundColor,
                                      value: Constants.ColorPaywall.customBlueColor as Any,
                                      range: range)
        yearlyTitle.attributedText = attributedString
    }
    private func addConstraints() {
        headerTitle.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
        closeButton.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().inset(10)
            make.left.equalTo(20)
            make.width.height.equalTo(28)
        }
    
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerTitle.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(termsButton.snp.top).inset(-15)
        }
        
        segmentedView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(46)
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(260)
        }
        monthlyButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(5)
            make.height.equalTo(35)
            make.width.equalTo(100)
        }
        yearlyButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(monthlyButton.snp.right).inset(-5)
            make.height.equalTo(35)
            make.right.equalTo(-5)
        }
        yearlyTitle.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }

        subscribeView.snp.makeConstraints { make in
            make.top.equalTo(segmentedView.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalToSuperview().inset(65)
            make.bottom.equalTo(subscribeButton.snp.top).inset(-20)
        }
        subscribeButton.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(20)
            make.left.equalTo(20)
            make.height.equalTo(58)
            make.bottom.equalToSuperview()
        }

        restoreButton.snp.makeConstraints { make in
            make.right.equalTo(termsButton.snp.left).inset(-5)
            make.left.equalTo(30)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().inset(20)
        }
        termsButton.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
            make.bottom.equalToSuperview().inset(20)
        }
        privacyButton.snp.makeConstraints { make in
            make.left.equalTo(termsButton.snp.right).inset(-5)
            make.right.equalTo(-30)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().inset(20)
        }
    }
}
extension PaywallForOldIphone: SubscriptionDelegalate {
    func subscriptionSelected(_ subscription: SubscriptionMode) {
        modeSubscription = subscription
    }
    func activeButton() {
        subscribeButton.isEnabled = true
        subscribeButton.alpha = 1
    }
}
extension PaywallForOldIphone: SubscriptionDelegate {
    func update() {
        viewModel?.setData(mode: modeSubscription)
        DispatchQueue.main.async { [weak self] in
            self?.viewModel?.openTabBar()
        }
    }
    func getSubscriptionData(_ data: [String]) {
        subscribeView.priceTitle = data
        subscribeView.setupeTextForMonthly()
    }
}
