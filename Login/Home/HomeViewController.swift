//
//  HomeViewController.swift
//  Login
//
//  Created by João Pedro on 09/05/23.
//

import UIKit

struct Avatars: Codable {
  let results: [Avatar];
};

struct Info: Codable {
  var count: Int;
  var pages: Int;
  var next: String;
  var prev: String;
};

struct Avatar: Codable {
  var id: Int;
  var name: String;
  var type: String;
  var location: Location;
  var image: String;
};

struct Location: Codable {
  var name: String;
  var url: String;
};

struct Origin: Codable {
  var name: String;
  var url: String;
};

class HomeViewController: UIViewController {
  let headerView = Header(headerTitleText: "Welcome to the Multiverse", headerSubtitleText: "Stay tuned for the multiverse of Rick and Morty madness");
  let tableView = UITableView();
  var avatars = [Avatar]();
  
  let activityIndicator = UIActivityIndicatorView(style: .whiteLarge);
  
  override func viewDidLoad() {
    super.viewDidLoad();
    view.backgroundColor = .darkGray;
    
    configureHeader();
    configureTableView();
    configureLoading();
    getData();
  };
  
  func configureTitleScreen() {
    let appearance = UINavigationBarAppearance();
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1)];
    
    navigationController?.navigationBar.prefersLargeTitles = true;
    navigationItem.title = "The Multiverse";
    navigationItem.standardAppearance = appearance;
  };
};

extension HomeViewController {
  func configureHeader() {
    view.addSubview(headerView);
    
    headerView.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.topAnchor),
      headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      view.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
      headerView.heightAnchor.constraint(equalToConstant: 350)
    ]);
  };
  
  func configureTableView() {
    view.addSubview(tableView);
    
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.register(AvatarCell.self, forCellReuseIdentifier: "avatarcell");
    
    tableView.translatesAutoresizingMaskIntoConstraints = false;
    tableView.backgroundColor = .darkGray;
    tableView.rowHeight = 200;
    tableView.separatorStyle = .singleLine;
    tableView.separatorColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1);
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalToSystemSpacingBelow: headerView.bottomAnchor, multiplier: 2),
      tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: tableView.trailingAnchor, multiplier: 2),
      tableView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: 0)
    ]);
  };
  
  func configureLoading() {
    view.addSubview(activityIndicator)
    
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false;
    activityIndicator.hidesWhenStopped = true;
    activityIndicator.color = UIColor.black;
    
    let horizontalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
    view.addConstraint(horizontalConstraint)
    
    let verticalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.35, constant: 0)
    view.addConstraint(verticalConstraint)
  };
  
  func getData() {
    activityIndicator.startAnimating();
    
    let url = URL(string: "https://rickandmortyapi.com/api/character/?page=2")!

    let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
      guard let data = data, error == nil else {
        print("Request failed");

        return;
      };

      var result: Avatars?
      do {
        result = try JSONDecoder().decode(Avatars.self, from: data)
      } catch {
        print("Failed to convert data \(error.localizedDescription)");
      };

      guard let jsonAvatars = result else {
        return print("Failed");
      };

      self.avatars = jsonAvatars.results
      DispatchQueue.main.async {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          self.activityIndicator.stopAnimating();
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.tableView.reloadData()
          };
        };
      };
    });

    task.resume();
  };
};

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "avatarcell", for: indexPath) as! AvatarCell
    let avatar = avatars[indexPath.row]
    cell.set(avatar: avatar);
    
    return cell;
  };
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return avatars.count;
  };
};
