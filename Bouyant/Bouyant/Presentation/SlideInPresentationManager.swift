//
//  SlideInPresentationManager.swift
//  Bouyant
//
//  Created by Lambda_School_Loaner_204 on 11/16/20.
//

import UIKit

enum PresentationDirection {
    case bottom
}

class SlideInPresentationManager: NSObject {
    var direction: PresentationDirection = .bottom
    

}

extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
      let presentationController = SlideInPresentationController(
        presentedViewController: presented,
        presenting: presenting,
        direction: direction
      )
      return presentationController
    }
}
