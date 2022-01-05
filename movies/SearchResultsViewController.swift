//
//  SearchResultsViewController.swift
//  movietest
//
//  Created by QwertY on 20.12.2021.
//

import UIKit

class SearchResultsViewController: UIViewController {

    @IBOutlet private weak var moviesCollectionView: UICollectionView!
    
    private var filteredMovies: [Movie] = []
    static let identifier = "searchResultsViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMoviesCollectionView()
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredMovies = movies.filter( { (movie) -> Bool in
            movie.name.lowercased().contains(searchText.lowercased())
        })
        moviesCollectionView.reloadData()
    }
}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private func setUpMoviesCollectionView() {
        moviesCollectionView.backgroundColor = .black
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier, for: indexPath) as! MoviesCollectionViewCell
        let poster = filteredMovies[indexPath.row].poster
        let movieName = filteredMovies[indexPath.row].name
        cell.configureCell(image: poster, text: movieName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (view.frame.size.width / 3) - 10,
            height: (view.frame.size.height / 4) - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView.numberOfItems(inSection: section) == 1 {
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            return UIEdgeInsets(top: 10,
                                left: 10,
                                bottom: 10,
                                right: collectionView.frame.width - flowLayout.itemSize.width)
        }
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0)
    }
}
