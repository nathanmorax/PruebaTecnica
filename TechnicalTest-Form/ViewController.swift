//
//  ViewController.swift
//  TechnicalTest-Form
//
//  Created by Xcaret Mora on 03/02/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mobileErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var sendDataButton: UIButton!
    
    var checkTextField = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSetUp()
        setupKeyboardHiding()
        resetForm()
    }
    
    func configureSetUp() {
        
        nameTextField.delegate = self
        firstNameTextfield.delegate = self
        lastNameTextField.delegate = self
        mobileNumberTextField.delegate = self
        emailTextField.delegate = self
        
    }
    
    func setupKeyboardHiding() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard)))
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoarddWillShow(notification: )), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name:UIResponder.keyboardWillHideNotification , object: nil)
    }
   
    func resetForm() {
        mobileErrorLabel.text = ""
        emailErrorLabel.text = ""
        sendDataButton.isEnabled = false
        nameTextField.text = ""
        firstNameTextfield.text = ""
        lastNameTextField.text = ""
        mobileNumberTextField.text = ""
        emailTextField.text = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
    }
    
    // MARK: - IBAction cambios de textField y boton
    @IBAction func sendData(_ sender: Any) {
        saveCoreData()
    }
 
    @IBAction func mobileChanged(_ sender: Any) {
        
        if let number = mobileNumberTextField.text {
            if let errorMessage = checkTextField.invalidPhoneNumber(number) {
                mobileErrorLabel.text = errorMessage
                mobileErrorLabel.isHidden = false
            } else {
                mobileErrorLabel.isHidden =  true
            }
        }
        checkedValidForm()
    }
    
    @IBAction func emailChanged(_ sender: Any) {
        if let email = emailTextField.text {
            if let errorMessage = checkTextField.invalidEmail(email) {
                emailErrorLabel.text = errorMessage
                emailErrorLabel.isHidden = false
            } else {
                emailErrorLabel.isHidden =  true
            }
        }
        checkedValidForm()
    }
    // MARK: - Guardar datos en CoreData
    func saveCoreData() {
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context : NSManagedObjectContext = appdelegate.persistentContainer.viewContext
        
        guard let userEntity = NSEntityDescription.entity(forEntityName: "Contact", in: context) else { return }
                
        let newContact = Contact(entity: userEntity, insertInto: context)
        
        newContact.id = contactList.count as NSNumber
        newContact.name = nameTextField.text
        newContact.firtsName = firstNameTextfield.text
        newContact.lastName = lastNameTextField.text
        newContact.mobileNumber = mobileNumberTextField.text
        newContact.email = emailTextField.text
                
        do {
            try context.save()
            contactList.append(newContact)
            resetForm()
            showAlert(alertText: "DataCore", alertMessage: "saved successfully")
            print(newContact)
        } catch let error as NSError {
            print("No se pudo guardar \(error), \(error.userInfo)")
        }
    }
    // MARK: - Verifica formulario
    func checkedValidForm() {
        
        if nameTextField.text != "" && firstNameTextfield.text != "" && lastNameTextField.text != "" && emailErrorLabel.isHidden && mobileErrorLabel.isHidden {
            sendDataButton.isEnabled = true
        } else  { sendDataButton.isEnabled = false }
    }
}
// MARK: - Delegado de TextField
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
