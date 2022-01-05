//
//  SegmentViewController.swift
//  movietest
//
//  Created by QwertY on 11.12.2021.
//

import UIKit

class SegmentViewController: UIViewController {
    
    @IBOutlet private weak var moviesSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var containerView: UIView!
    
    static let identifier = "segmentedViewController"
    
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.barStyle = .black
        searchController.searchBar.isTranslucent = true
        searchController.searchBar.barTintColor = .black
        searchController.searchBar.tintColor = .yellow
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
        searchController.hidesNavigationBarDuringPresentation = false
        return searchController
    }()
    
    private lazy var featuredMoviesVC: FeaturedMoviesViewController = {
        let storyboardName = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: FeaturedMoviesViewController.identifier) as! FeaturedMoviesViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var chartsVC: ChartsViewController = {
        let storyboardName = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: ChartsViewController.identifier) as! ChartsViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var searchResultsVC: SearchResultsViewController = {
        let storyboardName = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: SearchResultsViewController.identifier) as! SearchResultsViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    static func viewController() -> SegmentViewController {
        let storyboardName = "Main"
        return UIStoryboard.init(name: storyboardName, bundle: nil).instantiateViewController(identifier: self.identifier) as SegmentViewController
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        view.blurView()
        present(searchController, animated: true, completion: nil)
    }
    
    @IBAction private func segmentValueChanged(_ sender: UISegmentedControl) {
        updateView()
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    private func updateView() {
        if moviesSegmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: chartsVC)
            add(asChildViewController: featuredMoviesVC)
        } else {
            remove(asChildViewController: featuredMoviesVC)
            add(asChildViewController: chartsVC)
        }
    }
    
    private func setupSegmentedControl() {
        let normalTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.yellow]
        let selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        moviesSegmentedControl.setTitleTextAttributes(normalTitleTextAttributes, for: .normal)
        moviesSegmentedControl.setTitleTextAttributes(selectedTitleTextAttributes, for: .selected)
        moviesSegmentedControl.layer.borderWidth = 1.0
        moviesSegmentedControl.layer.cornerRadius = 5.0
        moviesSegmentedControl.layer.borderColor = UIColor.yellow.cgColor
        moviesSegmentedControl.selectedSegmentTintColor = .yellow
        moviesSegmentedControl.backgroundColor = .black
        moviesSegmentedControl.tintColor = .yellow
    }
    
    private func setupView() {
        setupSegmentedControl()
        updateView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension SegmentViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    private func setupSearchController() {
        searchController.delegate = self
        searchController.searchBar.delegate = self
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        if moviesSegmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: chartsVC)
        } else {
            remove(asChildViewController: featuredMoviesVC)
        }
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        view.removeBlur()
        remove(asChildViewController: searchResultsVC)
        if moviesSegmentedControl.selectedSegmentIndex == 0 {
            add(asChildViewController: featuredMoviesVC)
        } else {
            add(asChildViewController: chartsVC)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            view.removeBlur()
            searchResultsVC.filterContentForSearchText(searchText)
            add(asChildViewController: searchResultsVC)
        } else {
            remove(asChildViewController: searchResultsVC)
            if moviesSegmentedControl.selectedSegmentIndex == 0 {
                add(asChildViewController: featuredMoviesVC)
            } else {
                add(asChildViewController: chartsVC)
            }
            view.blurView()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        remove(asChildViewController: searchResultsVC)
        if moviesSegmentedControl.selectedSegmentIndex == 0 {
            add(asChildViewController: featuredMoviesVC)
        } else {
            add(asChildViewController: chartsVC)
        }
    }
}

extension UIView {
    func blurView() {
        var blurEffectView = UIVisualEffectView()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        addSubview(blurEffectView)
    }
    
    func removeBlur() {
        for view in self.subviews {
            if let view = view as? UIVisualEffectView {
                view.removeFromSuperview()
            }
        }
    }
}
