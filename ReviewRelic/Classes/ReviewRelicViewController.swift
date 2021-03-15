//
//  ReviewRelicViewController.swift
//  Pods
//
//  Created by Raheel Sadiq on 27/02/2021.
//  Copyright (c) 2021 ReviewRelic. All rights reserved.
//

import UIKit

protocol ReviewRelicDisplayLogic: class {
    func displayData(viewModel: ReviewRelicModels.ViewModel)
}

class ReviewRelicViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var shareYourExperienceLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var starsStackView: UIStackView!
    @IBOutlet weak var commentTextView: RRUITextView!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!{
        didSet{
            closeButton.setRoundedCorner(radius: 15)
        }
    }
    
    var interactor: ReviewRelicBusinessLogic?
    var viewModel: ReviewRelicModels.ViewModel?
    // MARK: Object lifecycle
    
    class func instanceFromNib() -> ReviewRelicViewController {
        let bundle = Bundle(for: ReviewRelic.self)
        let controller = ReviewRelicViewController(nibName: "ReviewRelicViewController", bundle: bundle)
        return controller
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ReviewRelicInteractor()
        let presenter = ReviewRelicPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: Requsts
    
    func requestData() {
        interactor?.submitData(request: .init(rating: rating))
    }
    
    var rating: Int = 0
}

// IBActions
extension ReviewRelicViewController {
    
    @IBAction func submitAction(_ sender: UIButton) {
    
        guard let viewModel = viewModel else { return }
        switch viewModel.ratingType {
        case .stars(_):
            if rating == 0 {
                starsStackView.shake()
                return
            }
        case .words(let _):
            
            break
        }
        
        let request = ReviewRelicModels.Request(rating: rating)
        interactor?.submitData(request: request)
        
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
        
    @objc func starAction(_ sender: UIButton) {
        rating = sender.tag + 1
        for button in starsStackView.arrangedSubviews as! [UIButton] {
            if button.tag <= sender.tag {
                button.isSelected = true
            }else{
                button.isSelected = false
            }
        }
        
    }
}

// Display
extension ReviewRelicViewController: ReviewRelicDisplayLogic {
   
    func displayData(viewModel: ReviewRelicModels.ViewModel) {
        self.viewModel = viewModel
        closeButton.setBackgroundImage(viewModel.themeColor.withAlphaComponent(0.2).image(), for: .normal)
        closeButton.tintColor = viewModel.themeColor
        submitButton.setBackgroundImage(viewModel.themeColor.image(), for: .normal)
        submitButton.setRoundedCorner(radius: 6)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        switch viewModel.ratingType {
        
        case .stars(let starsData):
            setupStarsReview(starsData: starsData)
        
        case .words(let wordsData):
            print(wordsData)
            break
        }
    }
    
    private func setupStarsReview(starsData: ReviewRelicModels.ViewModel.StarsData ){
        
        for index in 0..<starsData.starsCount {
            let starButton = UIButton()
            starButton.setImage(starsData.starUnSelected, for: .normal)
            starButton.setImage(starsData.starSelected, for: .selected)
            starButton.setImage(starsData.starSelected, for: .highlighted)
            starButton.imageView?.contentMode = .center
            starButton.tag = index

            starButton.addTarget(self, action: #selector(starAction(_:)), for: .touchUpInside)
            starsStackView.addArrangedSubview(starButton)
        }
    }
}
