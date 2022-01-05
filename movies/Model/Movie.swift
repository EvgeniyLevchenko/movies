//
//  Movie.swift
//  movietest
//
//  Created by QwertY on 07.12.2021.
//

import UIKit

public struct Movie {
    var name: String
    var poster: UIImage? {
        return UIImage(named: name)
    }
}

public var movies: [Movie] = [
    Movie(name: "The Shawshank Redemption"),
    Movie(name: "The Godfather"),
    Movie(name: "The Godfather Part 2"),
    Movie(name: "The Dark Knight"),
    Movie(name: "12 Angry Men"),
    Movie(name: "Schindler's List"),
    Movie(name: "Pulp Fiction"),
    Movie(name: "The Good, the Bad and the Ugly"),
    Movie(name: "Fight Club"),
    Movie(name: "Forrest Gump"),
    Movie(name: "Inception"),
    Movie(name: "Seven"),
    Movie(name: "Seven Samurai"),
    Movie(name: "Interstellar"),
    Movie(name: "Spirited Away"),
    Movie(name: "Leon"),
    Movie(name: "Gladiator")
]



