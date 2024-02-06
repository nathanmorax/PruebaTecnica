//
//  ContactsCollectionController.swift
//  TechnicalTest-Form
//
//  Created by Xcaret Mora on 05/02/24.
//

import UIKit
import CoreData

var contactList = [Contact]()

class ContactsCollectionController: UICollectionViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
        fetchCoreData()
  
    }
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    func configureCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self

    }
    
    func fetchCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results
            {
                guard let note = result as? Contact else { return }
                contactList.append(note)
                print(note)
                print("Recuperacion exitosa")
            }
        }
        catch
        {
            print("Recuperacion fallida")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        contactList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "contactCell", for: indexPath)
        if let cell = cell as? ContactDetailCollectionCell {
            cell.nameLabel.text = contactList[indexPath.item].name
            cell.emailLabel.text = contactList[indexPath.item].email
            cell.phoneNumberLabel.text = contactList[indexPath.item].mobileNumber

        }
        return cell
    }
    
}
extension ContactsCollectionController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 30, height: 120)
    }
}

class ContactDetailCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
}
