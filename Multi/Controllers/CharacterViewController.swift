
import UIKit

final class CharacterViewController: UIViewController {
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
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = .systemBackground
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Characters"
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

extension CharacterViewController: CharactersViewDelegate {
    func charactersViewDidLoad() {

    }
}

// MARK: - CollectionView Delegates
extension CharacterViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        charactersData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath)
                as? CharacterCollectionViewCell else {
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
}
