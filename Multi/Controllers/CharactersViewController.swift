
import UIKit
import SwiftUI

final class CharactersViewController: UIViewController {
    private lazy var charactersView: CharactersView = { [unowned self] in
        let view = CharactersView()
        view.delegate = self
        view.setDelagates(collectionViewDelegate: self,
                          dataSource: self)
        return view
    }()
    
    private var charactersData: [Character] = []

    override func loadView() {
        view = charactersView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nav = self.navigationController?.navigationBar
        nav?.prefersLargeTitles = true
        navigationItem.title = "Characters"
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = .systemBackground
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCharacters()
    }
    
    private func fetchCharacters() {
        Request.shared.fetchCharacters { characters in
            if let characters = characters {
                self.charactersData = characters
                DispatchQueue.main.async {
                    self.charactersView.reloadCollectionView()
                }
            } else {
                print("Failed to fetch characters.")
            }
        }
    }
}

extension CharactersViewController: CharactersViewDelegate {
    func charactersViewDidLoad() {

    }
}

// MARK: - CollectionView Delegates
extension CharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        charactersData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath)
                as? CharactersCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let character = charactersData[indexPath.item]
        cell.configure(name: character.name,
                       imageURL: character.image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        let padding: CGFloat = 10
        let width = (bounds.width - padding * 3) / 2
        let height = width * 1.2
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = charactersData[indexPath.row]
        
        Request.shared.getLocationById(id: character.id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let location):
                    let detailView = UIHostingController(rootView: DetailSwiftUIView(character: character, location: location))
                    detailView.view.frame = UIScreen.main.bounds
                    
                    self.navigationItem.title = ""
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    self.navigationController?.navigationBar.tintColor = .white
                    
                    self.navigationController?.pushViewController(detailView, animated: true)
                    
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
