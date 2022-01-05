//
//  FeatureMoviesViewController.swift
//  movietest
//
//  Created by QwertY on 11.12.2021.
//

import UIKit

class FeaturedMoviesViewController: UIViewController {
    
    @IBOutlet private weak var postersCollectionView: UICollectionView!
    @IBOutlet private weak var moviesCollectionView: UICollectionView!
    
    static let identifier = "featuredMoviesViewController"
    var moviePosters = [
        UIImage(named: "image1"),
        UIImage(named: "image2"),
        UIImage(named: "image3"),
        UIImage(named: "image4")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPostersCollectionView()
        setUpMoviesCollectionView()
        sortMovies()
    }
    
    private func sortMovies() {
        movies.sort(by: { $0.name < $1.name })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        postersCollectionView.collectionViewLayout = layout
        postersCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        postersCollectionView.isPagingEnabled = true
    }
}

extension FeaturedMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private func setUpPostersCollectionView() {
        postersCollectionView.backgroundColor = .black
        postersCollectionView.delegate = self
        postersCollectionView.dataSource = self
        postersCollectionView.register(MoviesPostersCollectionViewCell.self, forCellWithReuseIdentifier: MoviesPostersCollectionViewCell.identifier)
    }
    
    private func setUpMoviesCollectionView() {
        moviesCollectionView.backgroundColor = .black
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case postersCollectionView:
            return moviePosters.count
        case moviesCollectionView:
            return movies.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case postersCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesPostersCollectionViewCell.identifier, for: indexPath) as! MoviesPostersCollectionViewCell
            let poster = moviePosters[indexPath.row]
            cell.configureCell(image: poster)
            return cell
        case moviesCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier, for: indexPath) as! MoviesCollectionViewCell
            let poster = movies[indexPath.row].poster
            let movieName = movies[indexPath.row].name
            cell.configureCell(image: poster, text: movieName)
            return cell
        default:
            let cell = UICollectionViewCell()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case postersCollectionView:
            return CGSize(
                width: view.frame.size.width,
                height: collectionView.frame.size.height
            )
        case moviesCollectionView:
            return CGSize(
                width: (view.frame.size.width / 3) - 10,
                height: (view.frame.size.height / 4) - 10)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case moviesCollectionView:
            return 10
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case moviesCollectionView:
            return 10
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "moviesHeader", for: indexPath)
        header.backgroundColor = .black
        return header
    }
}

