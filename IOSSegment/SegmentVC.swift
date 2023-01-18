//
//  SegmentVC.swift
//  IOSSegment
//
//  Created by Elif Karakolcu on 12.01.2023.
//

import UIKit

class SegmentVC: UIViewController {
    
    @IBOutlet weak var segmentTwoBttn: UIButton!
    @IBOutlet weak var segmentOneBttn: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    private var pageController: UIPageViewController!
    private var arrayVC:[UIViewController] = []
    private var currentPage: Int!
    
    lazy var vc1: SegmentOneVC = {
        
        var viewController = storyboard?.instantiateViewController(withIdentifier: "SegmentOneVC") as! SegmentOneVC
        return viewController
    }()
    
    lazy var vc2: SegmentTwoVC = {
        
        var viewController = storyboard?.instantiateViewController(withIdentifier: "SegmentTwoVC") as! SegmentTwoVC
        return viewController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPage = 0
        createPageViewController()
        arrayVC.removeAll()
        arrayVC.append(vc1)
        arrayVC.append(vc2)
        
    }
    
}
//MARK: - createPageViewController
extension SegmentVC {
    private func createPageViewController() {
        
        pageController = UIPageViewController.init(transitionStyle: UIPageViewController.TransitionStyle.scroll, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal, options: nil)
        
        pageController.view.backgroundColor = .clear
        pageController.delegate = self
        pageController.dataSource = nil
        
        pageController.view.frame = containerView.bounds
        pageController.setViewControllers([vc1], direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
        
        self.addChild(pageController)
        self.containerView.addSubview(pageController.view)
        pageController.didMove(toParent: self)
    }
    
    
    private func indexofviewController(viewCOntroller: UIViewController) -> Int {
        if(arrayVC .contains(viewCOntroller)) {
            return arrayVC.firstIndex(of: viewCOntroller)!
        }
        
        return -1
    }
    
}
//MARK: - Button Actions
extension SegmentVC {
    @IBAction func changeSegment(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            self.segmentTwoBttn.backgroundColor = .white
            self.segmentOneBttn.backgroundColor = .systemBrown
            self.segmentOneBttn.setTitleColor(.white, for: .normal)
            self.segmentTwoBttn.setTitleColor(.systemBrown, for: .normal)
            pageController.setViewControllers([arrayVC[0]], direction: UIPageViewController.NavigationDirection.reverse, animated: true, completion: nil)
            currentPage = 0
        case 1:
            self.segmentOneBttn.backgroundColor = .white
            self.segmentTwoBttn.backgroundColor = .systemBrown
            self.segmentOneBttn.setTitleColor(.systemBrown, for: .normal)
            self.segmentTwoBttn.setTitleColor(.white, for: .normal)
            
            if currentPage > 1{
                pageController.setViewControllers([arrayVC[1]], direction: UIPageViewController.NavigationDirection.reverse, animated: true, completion: nil)
                currentPage = 1
                
            }else{
                pageController.setViewControllers([arrayVC[1]], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
                currentPage = 1
                
            }
            
        default:
            break
        }
    }
    
}
//MARK: - UIPageViewControllerDelegate, UIPageViewControllerDataSource
extension SegmentVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = indexofviewController(viewCOntroller: viewController)
        
        if(index != -1) {
            index = index - 1
        }
        
        if(index < 0) {
            return nil
        }
        else {
            return arrayVC[index]
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = indexofviewController(viewCOntroller: viewController)
        
        if(index != -1) {
            index = index + 1
        }
        
        if(index >= arrayVC.count) {
            return nil
        }
        else {
            return arrayVC[index]
        }
        
    }
    
    func pageViewController(_ pageViewController1: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if(completed) {
            currentPage = arrayVC.firstIndex(of: (pageViewController1.viewControllers?.last)!)
            
        }
        
    }
    
}
