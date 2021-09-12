//
//  FavoriteTabController.swift
//  FunnyDadJokes
//
//  Created by Heang Ly on 9/10/21.
//

import UIKit

class FavoriteTabController: UITableViewController {
    //MARK: - Properties
    private var models = [SavedJokeData]()

    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchJokesFromCoreData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainUI()
    }

    //MARK: - Helpers
    func configureMainUI() {
        title = "Favorites"
        tableView.backgroundColor = .lightGold
        tableView.separatorStyle = .none
        tableView.register(FavoriteTabCell.self, forCellReuseIdentifier: FavoriteTabCell.reusableID)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewJoke))
        navigationController?.navigationBar.tintColor = .black
    }

    func fetchJokesFromCoreData() {
        models = CoreDataCRUDHelper.fetchSavedJokes()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func updateJokeCells() {
        let newModels = CoreDataCRUDHelper.fetchSavedJokes()
        DispatchQueue.main.async {
            self.models = newModels
            self.tableView.performBatchUpdates({
                self.tableView.insertRows(at: [IndexPath(row: 0,
                    section: 0)],
                    with: .automatic)
            }, completion: nil) }
    }
    
    func successAlert(success: Bool) {
        let title = success ? "Success" : "Duplication"
        let message = success ? "Joke is saved successfully" : "Joke is already saved!"
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "ok", style: .default))
        present(ac, animated: true)
    }

    @objc func addNewJoke() {
        let ac = UIAlertController(title: "Write your own new joke", message: nil, preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)
        ac.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] _ in
            guard let tf = ac.textFields?.first, let text = tf.text, !text.isEmpty else { return }
            CoreDataCRUDHelper.saveJoke(id: UUID().uuidString, joke: text) { success in
                self?.successAlert(success: success)
                self?.updateJokeCells()
            }
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }
}

//MARK: - UITableView DataSource
extension FavoriteTabController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTabCell.reusableID, for: indexPath) as? FavoriteTabCell else { return UITableViewCell() }
        cell.textLabel?.text = model.joke
        return cell
    }
}

//MARK: - UITableview Delegate
extension FavoriteTabController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataCRUDHelper.deleteJoke(joke: models[indexPath.row])
            models.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

