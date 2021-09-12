//
//  JokeAPI.swift
//  FunnyDadJokes
//
//  Created by Heang Ly on 9/10/21.
//


import Foundation

class JokeAPI {
    static let shared = JokeAPI()

    func fetchJoke(completion: @escaping(Joke?) -> Void) {
        guard let url = URL(string: "https://icanhazdadjoke.com/") else { return }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("DEBUG: Error fetching data from API -> \(error.localizedDescription)")
                return
            }

            guard let data = data else { return }
            let jokeOject = self.parseJson(data: data)
            completion(jokeOject)
        }

        task.resume()
    }

    private func parseJson(data: Data) -> Joke? {
        let decoder = JSONDecoder()
        do {
            let joke = try decoder.decode(Joke.self, from: data)
            return joke
        } catch {
            print("DEBUG: Error coverting joke to object -> \(error.localizedDescription)")
            return nil
        }
    }


}
