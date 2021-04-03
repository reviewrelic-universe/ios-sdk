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
    func displayDataFailure()
    func displayDataSubmittedSuccessfully()
    func displayDataSubmittedFailed()
}

public class ReviewRelicViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!{
        didSet{
            logoImageView.setRoundedFull()
        }
    }
    @IBOutlet weak var resultView: RRResultView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starsStackView: UIStackView!
    @IBOutlet weak var commentTextView: RRUITextView!
    @IBOutlet weak var wordsCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var mainStackViewCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var wordsCollectionView: UICollectionView!{
        didSet{
            wordsCollectionView.register(UINib(nibName:"WordsCollectionViewCell", bundle: ReviewRelic.shared.bundle), forCellWithReuseIdentifier:"WordsCollectionViewCell")
            let alignedFlowLayout = wordsCollectionView?.collectionViewLayout as? AlignedCollectionViewFlowLayout
            alignedFlowLayout?.horizontalAlignment = .left
            alignedFlowLayout?.verticalAlignment = .top
            alignedFlowLayout?.minimumLineSpacing = 10
            alignedFlowLayout?.minimumInteritemSpacing = 10
            alignedFlowLayout?.scrollDirection = .vertical
        }
    }
    
    @IBOutlet weak var submitButton: RRButton!{
        didSet{
            submitButton.setRoundedCorner(radius: 22)
        }
    }
    
    @IBOutlet weak var closeButton: UIButton!{
        didSet{
            closeButton.setRoundedCorner(radius: 15)
        }
    }
    
    var interactor: ReviewRelicBusinessLogic?
    var viewModel: ReviewRelicModels.ViewModel?
    var words: [ReviewRelicModels.ViewModel.WordsData.Word] = []{
        didSet{
            wordsCollectionView.reloadData()
            wordsCollectionViewHeight.constant = wordsCollectionView.collectionViewLayout.collectionViewContentSize.height
        }
    }
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
    
    
    public func setHeadingLabel(text: String, font: UIFont? = .boldSystemFont(ofSize: 14), textColor: UIColor? = .darkText) {
        headingLabel.text = text
        headingLabel.font = font
        headingLabel.textColor = textColor
    }
    
    public func setDescriptionLabel(text: String, font: UIFont? = .systemFont(ofSize: 14), textColor: UIColor? = .darkText) {
        descriptionLabel.text = text
        descriptionLabel.font = font
        descriptionLabel.textColor = textColor
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
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
                
        NotificationCenter.default.addObserver(
            forName: .UIKeyboardWillShow,
            object: nil,
            queue: .main) { [weak self](notification) in
            
            guard let info:Dictionary = (notification as NSNotification).userInfo, let strongSelf = self else { return }
            let duration = (info[UIKeyboardAnimationDurationUserInfoKey] as! Double)
            
            strongSelf.mainStackViewCenterConstraint.constant = -160
            strongSelf.view.animateAfterConstraintChangeDuration(seconds: duration)
        }
        
        NotificationCenter.default.addObserver(
            forName: .UIKeyboardWillHide,
            object: nil,
            queue: .main) { [weak self](notification) in
            guard let info:Dictionary = (notification as NSNotification).userInfo, let strongSelf = self else { return }
            let duration = (info[UIKeyboardAnimationDurationUserInfoKey] as! Double)
            
            strongSelf.mainStackViewCenterConstraint.constant = -40
            strongSelf.view.animateAfterConstraintChangeDuration(seconds: duration)
        }
        
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: Requsts
    
    func requestData() {
        interactor?.requestReviewData()
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
        case .words(_):
            if rating == 0 {
                wordsCollectionView.shake()
                return
            }
        }

        let comment = commentTextView == nil ? "" : commentTextView.text!
        let request = ReviewRelicModels.Request(rating: rating, itemId: "11", comments: comment)
        interactor?.submitData(request: request, completion: nil)
        (sender as? RRButton)?.set(state: .loading)
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

    
    func displayDataFailure() {
        view.bringSubview(toFront: resultView)
        resultView.showWithAnimation()
        resultView.show(kind: .failure, themeColor: .lightText)
        dismiss()
    }
    
    func displayDataSubmittedFailed() {
        view.bringSubview(toFront: resultView)
        resultView.showWithAnimation()
        resultView.show(kind: .failure, themeColor: .lightText)
        dismiss()
    }
    
    func displayDataSubmittedSuccessfully() {
        view.bringSubview(toFront: resultView)
        resultView.showWithAnimation()
        resultView.show(kind: .success, themeColor: viewModel?.themeColor ?? .black)
        dismiss()
    }
   
    func displayData(viewModel: ReviewRelicModels.ViewModel) {
        
        self.viewModel = viewModel
        logoImageView.image = viewModel.appLogo
        closeButton.setBackgroundImage(viewModel.themeColor.withAlphaComponent(0.2).image(), for: .normal)
        closeButton.tintColor = viewModel.themeColor
        
        submitButton.setBackgroundImage(viewModel.themeColor.image(), for: .normal)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)

        switch viewModel.ratingType {
        
        case .stars(let starsData):
            wordsCollectionView.isHidden = true
            setupStarsReview(starsData: starsData)
        
        case .words(let wordsData):
            words = wordsData.words
            starsStackView.isHidden = true
        }
    }
    
    func dismiss(){
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [weak self](_) in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    private func setupStarsReview(starsData: ReviewRelicModels.ViewModel.StarsData ){
        
        for index in 0..<starsData.starsCount {
            let starButton = UIButton()//  (frame: .init(x: 0, y: 0, width: 44, height: 44))
            starButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
            starButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
            
            starButton.setImage(starsData.starUnSelected, for: .normal)
            starButton.setImage(starsData.starSelected, for: .selected)
            starButton.setImage(starsData.starSelected, for: .highlighted)
            starButton.imageView?.contentMode = .scaleAspectFit
            starButton.tag = index
            starButton.addTarget(self, action: #selector(starAction(_:)), for: .touchUpInside)
            starsStackView.addArrangedSubview(starButton)
        }
    }
}

extension ReviewRelicViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        words.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WordsCollectionViewCell", for: indexPath) as! WordsCollectionViewCell
        cell.themeColor = viewModel?.themeColor ?? .lightGray
        cell.wordLabel.text = words[indexPath.row].title        
        return cell
    }
    
    public  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        rating = words[indexPath.row].rating
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = words[indexPath.row].title.width(withConstrainedHeight: 36, font: UIFont.systemFont(ofSize: 14)) + 32
        return CGSize(width: width, height: 36)
    }
}

class RRResultView: UIView {
    
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!{
        didSet{
            resultLabel.font = .boldSystemFont(ofSize: 18)
            resultLabel.textColor = .darkText
        }
    }
    
    enum Kind {
        case success
        case failure
    }
    
    func show(kind:Kind, themeColor: UIColor) {
        switch kind {
        case .success:
            resultImageView.image = UIImage(namedInBundle: "successTick")
            resultLabel.text = "Review submitted successfully!"
            resultImageView.tintColor = themeColor
            resultLabel.textColor = themeColor
        case .failure:
            resultImageView.image = UIImage(namedInBundle: "failureIcon")
            resultLabel.text = "Oops!\nSomething went wrong"
            resultImageView.tintColor = .darkText
        }
    }
}

