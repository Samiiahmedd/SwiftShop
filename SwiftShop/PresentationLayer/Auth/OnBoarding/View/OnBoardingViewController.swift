//
//  OnBoardingViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 17/07/2024.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    // MARK: - VARIABLES
    
    var viewModel = OnBoardingViewModel()
    var coordinator: AuthCoordinatorProtocol?
    var currentPage = 0 {
        didSet{
            pageControl.currentPage = currentPage
        }
    }
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet var onBoardingImageView: UIImageView!
    @IBOutlet var onboardingTitle: UILabel!
    @IBOutlet var onBoardingDescription: UILabel!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var pageControl: UIPageControl!
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        pageControl.numberOfPages = viewModel.slides.count
        updateSlideContent()
    }
    
    //MARK: -IBACTIONS
    
    @IBAction func nextButton(_ sender: Any) {
        if currentPage < viewModel.slides.count - 1 {
            currentPage += 1
            updateSlideContent()
        } else {
//            coordinator?.pushOnBoardingScreen()
        }
    }
    
    //MARK: -FUNCTIONS
    
    private func updateSlideContent() {
        let slide = viewModel.slides[currentPage]
           UIView.transition(with: onBoardingImageView, duration: 0.3, options: .transitionCrossDissolve, animations: {
               self.onBoardingImageView.image = slide.image
           }, completion: nil)
           onboardingTitle.text = slide.title
           onBoardingDescription.text = slide.descrption
       }
}
