//
//  OnBoardingViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 17/07/2024.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    // MARK: - Variables
    
    var slides: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet{
            pageControl.currentPage = currentPage
        }
    }
    
    //MARK: -IBOUtlet
    
    @IBOutlet var onBoardingImageView: UIImageView!
    @IBOutlet var onboardingTitle: UILabel!
    @IBOutlet var onBoardingDescription: UILabel!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = [ .init(image: UIImage(named: "OnBoarding1")!,
                         title: "20% Discount New Arrival Product",
                         descrption: "Publish up your selfies to make yourself more beautiful with this app."
                        ),
                   .init(
                    image: UIImage(named: "OnBoarding2")!,
                    title: "Take AdvantageOf The Offer Shopping ",
                    descrption: "Publish up your selfies to make yourself more beautiful with this app."
                   ),
                   .init(
                    image: UIImage(named: "OnBoarding3")!,
                    title: "All Types Offers Within Your Reach",
                    descrption: "Publish up your selfies to make yourself more beautiful with this app."
                   )
        ]
        pageControl.numberOfPages = slides.count
    }
    
    
    //MARK: -IBAction
    
    @IBAction func nextButton(_ sender: Any) {
        if currentPage < slides.count - 1 {
            currentPage += 1
            onBoardingImageView.image = slides[currentPage].image
            onboardingTitle.text = slides[currentPage].descrption
        }
    }
}
