//
//  ChartsViewController.swift
//  movietest
//
//  Created by QwertY on 11.12.2021.
//

import UIKit

class ChartsViewController: UIViewController {

    @IBOutlet private weak var chartsTableView: UITableView!
    
    static let identifier = "chartsViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpChartsTableView()
    }
}

extension ChartsViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setUpChartsTableView() {
        chartsTableView.backgroundColor = .black
        chartsTableView.delegate = self
        chartsTableView.dataSource = self
        chartsTableView.register(ChartsTableViewCell.nib(), forCellReuseIdentifier: ChartsTableViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChartsTableViewCell.identifier, for: indexPath) as! ChartsTableViewCell
        let movieName = movies[indexPath.row].name
        let poster = movies[indexPath.row].poster
        let indexNumber = String(indexPath.row + 1)
        cell.configureCell(index: indexNumber, text: movieName, image: poster)
        return cell
    }
}
