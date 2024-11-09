//
//  OnBoardingViewModel.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 09/11/2024.
//

import Foundation
import UIKit

class OnBoardingViewModel{
    
    var slides : [OnboardingSlide] = [
        .init(image: UIImage(named: "OnBoarding1")!,
              title: "20% Discount New Arrival Product",
              descrption: "Publish up your selfies to make yourself more beautiful with this app."
             ),
        .init(
            image: UIImage(named: "OnBoarding2")!,
            title: "Take Advantage Of The Offer Shopping ",
            descrption: "Publish up your selfies to make yourself more beautiful with this app."
        ),
        .init(
            image: UIImage(named: "OnBoarding3")!,
            title: "All Types Offers Within Your Reach",
            descrption: "Publish up your selfies to make yourself more beautiful with this app."
        )
    ]
    
}
