//
//  ManagePVC.swift
//  photoViewer
//
//  Created by Emir haktan Ozturk on 25/09/2017.
//  Copyright © 2017 emirhaktan. All rights reserved.
//

import UIKit

class ManagePVC: UIPageViewController {

    var authors = [Author]()
    var currentIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let viewControllers = viewDetailVC(currentIndex ?? 0 ){
            let viewControllers = [viewControllers]
            
            // 2
            setViewControllers(
                viewControllers,
                direction: .forward,
                animated: false,
                completion: nil
            )
        }
        dataSource = self
        
    }

    func viewDetailVC(_ index: Int) -> DetailVC? {
        guard let storyboard = storyboard,
            let page = storyboard.instantiateViewController(withIdentifier: "detailVC")
                as? DetailVC else {
                    return nil
        }
        page.currentAuthor = authors[index]
        page.photoIndex = index
        return page
    }
    

}
extension ManagePVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? DetailVC,
            let index = viewController.photoIndex,
            index > 0 {
            return viewDetailVC(index - 1)
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? DetailVC,
            let index = viewController.photoIndex,
            (index + 1) < authors.count {
            return viewDetailVC(index + 1)
        }
        
        return nil
    }
}
