//
//  TeamsDetailsViewController.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 21/05/2023.
//

import UIKit
import SDWebImage

import UIKit
import SDWebImage

class TeamsDetailsViewController: UIViewController {
    
    @IBOutlet weak var playersCollectionView: UICollectionView!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var coachNameBtn: UIButton!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var networkIndecator: UIActivityIndicatorView!
    @IBOutlet weak var teamLogo: UIImageView!
    
    var viewModel: TeamDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        playersCollectionView.delegate = self
        playersCollectionView.dataSource = self
        playersCollectionView.backgroundView?.backgroundColor = UIColor.clear
        if !NetworkStatusChecker.isInternetAvailable() {
           showToast(text: "No Internet Connection", imageName: K.NO_WIFI)
        }
        
        viewModel?.bindTeamsListToTeamDetailsVC.bind({ [weak self] isLoading in
            if let data = isLoading{
                DispatchQueue.main.async {
                    if data == false {
                        self?.networkIndecator.startAnimating()
              
                    } else {
                        self?.playersCollectionView.reloadData()
                        self?.updateUI()
                        self?.networkIndecator.stopAnimating()
                    }
                }
            }
       
        })
        
        viewModel.fetchTeamDetails()
        
        let layout = UICollectionViewCompositionalLayout { _, _ in
            return self.playersSection()
        }
        playersCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateFavoriteButtonState()
    }
    //MARK: - update UI
    func updateUI(){
        teamLogo.sd_setImage(with: URL(string: viewModel.team.team_logo ?? " "), placeholderImage: UIImage(named: K.LEAGUES_PLACEHOLDER_IMAGE))
                   self.teamName.text = viewModel.team.team_name
                   self.coachNameBtn.setTitle("  \(viewModel.team.coaches![0].coach_name ?? "unknown")", for: .normal)
                   self.playersCollectionView.reloadData()
    }
    
    // MARK: - Add to Favorite
    
    @IBAction func addToFav(_ sender: Any) {
        if viewModel.isFav {
            confirmDeleteAlert {
                self.viewModel.toggleFavorite()
                self.favBtn.tintColor = UIColor(named: K.WHITE)
            }
           
    
        } else {
            favBtn.tintColor = UIColor(named: K.FAV_COLOR)
            showToast(text: "Added To Favourite", imageName: K.FAV_IMAGE)
            viewModel.toggleFavorite()
        }
    }
    
    private func updateFavoriteButtonState() {
        if viewModel.isFav {
            favBtn.tintColor = UIColor(named: K.FAV_COLOR)
    
        } else {
            favBtn.tintColor = UIColor(named: K.WHITE)
        }
    }
    
    // MARK: - Latest events
    
    func playersSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 8)
        

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(210)
            ),
            subitems: [item]
        )
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 8)
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    // MARK: - Back
    
    private func configNavigationBar() {
        // edit back button
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: K.BACK_ARROW), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        // edit title
        let textAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: K.MEDIUM_PURPLE)!,
            .font: UIFont(name: "Chalkduster", size: 17.0)!,
        ]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = viewModel.teamName
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionView

extension TeamsDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.team.players?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.TEAM_DETAILS_CELL, for: indexPath) as! TeamDetailsCell
        
        if let player = viewModel.team.players?[indexPath.row] {
            cell.configure(with: player)
        }
        
        let existingColor = UIColor(named: K.WHITE)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        existingColor!.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        cell.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 0.5)
        
        return cell
    }
}
