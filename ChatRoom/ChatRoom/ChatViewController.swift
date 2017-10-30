//
//  ViewController.swift
//  Flash Chat
//
//  Created by Angela Yu on 29/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    
    
    // Declare instance variables here
    var messageArr : [Message] = [Message]()
    
    // We've pre-linked the IBOutlets
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    var keyboardHeight : CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Set yourself as the delegate and datasource here:
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        
        //TODO: Set yourself as the delegate of the text field here:
        messageTextfield.delegate = self
        
        
        //TODO: Set the tapGesture here:
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        

        //TODO: Register your MessageCell.xib file here:
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        configureTableView()
        retrieveMessages()
        messageTableView.separatorStyle = .none
        
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyBoard), name: Notification.Name.UIKeyboardWillHide, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(showKeyBoard), name: Notification.Name.UIKeyboardWillShow, object: nil)
        
    }
    
    @objc func showKeyBoard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
//        print(messageTextfield.frame.size.height)
        self.view.frame.origin.y -= keyboardScreenEndFrame.height + messageTextfield.frame.size.height - 30
//        self.view.layoutIfNeeded()

        
    }
    
    @objc func hideKeyBoard(notification: Notification) {
        
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        print(messageTextfield.frame.size.height + keyboardScreenEndFrame.height)
        self.view.frame.origin.y += keyboardScreenEndFrame.height + messageTextfield.frame.size.height - 30
//        self.view.layoutIfNeeded()
        
    }
    
    

    ///////////////////////////////////////////
    
    //MARK: - TableView DataSource Methods
    
    
    
    //TODO: Declare cellForRowAtIndexPath here:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        cell.messageBody.text = messageArr[indexPath.row].messageBody
        cell.senderUsername.text = messageArr[indexPath.row].sender
        cell.avatarImageView.image = UIImage(named: "egg")
        
        if cell.senderUsername.text == FIRAuth.auth()?.currentUser?.email as String! {
            cell.avatarImageView.backgroundColor = UIColor.flatWhite()
            cell.messageBackground.backgroundColor = UIColor.flatGreen()
        }
        else {
            cell.avatarImageView.backgroundColor = UIColor.flatWhite()
            cell.messageBackground.backgroundColor = UIColor.flatWhite()
        }
        
        return cell
        
    }
    
    
    
    //TODO: Declare numberOfRowsInSection here:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArr.count
    }
    
    
    
    //TODO: Declare tableViewTapped here:
    @objc func tableViewTapped () {
        
        messageTextfield.endEditing(true)
        
    }
    
    
    //TODO: Declare configureTableView here:
    func configureTableView () {
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    
    
    ///////////////////////////////////////////
    
    //MARK:- TextField Delegate Methods
    
    

    
    //TODO: Declare textFieldDidBeginEditing here:
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.25){
//            self.heightConstraint.constant = 270
//            self.view.layoutIfNeeded()
        }
        
    }
    
    
    
    //TODO: Declare textFieldDidEndEditing here:
    func textFieldDidEndEditing(_ textField: UITextField) {
        
//        UIView.animate(withDuration: 0.25){
//            self.heightConstraint.constant = 50
//            self.view.layoutIfNeeded()
//        }
    }

    
    ///////////////////////////////////////////
    
    
    //MARK: - Send & Recieve from Firebase
    
    
    
    
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        messageTextfield.endEditing(true)
        //TODO: Send the message to Firebase and save it in our database
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        
        let messageDB = FIRDatabase.database().reference().child("Messages")
        let messageDict = ["Sender" : FIRAuth.auth()?.currentUser?.email, "MessageBody" : messageTextfield.text!]
        messageDB.childByAutoId().setValue(messageDict) {
            (error, ref) in
            if error != nil {
                print(error)
            }
            else {
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextfield.text = ""
            }
        }
        
    }
    
    //TODO: Create the retrieveMessages method here:
    func retrieveMessages () {
        let messageDB = FIRDatabase.database().reference().child("Messages")
        messageDB.observe(.childAdded) { (snapshot) in
            let snapshotVal = snapshot.value as! Dictionary<String, String>
            let text = snapshotVal["MessageBody"]!
            let sender = snapshotVal["Sender"]!
//            print(text, sender)
            let message = Message()
            message.messageBody = text
            message.sender = sender
            self.messageArr.append(message)
            self.configureTableView()
            self.messageTableView.reloadData()
        }
    }
    

    
    
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        //TODO: Log out the user and send them back to WelcomeViewController
        do {
            try FIRAuth.auth()?.signOut()
        }
        catch {
            print("error sign out")
        }
        guard (navigationController?.popToRootViewController(animated: true)) != nil
        else {
            print("no view to return to")
            return
        }
        
    }
    
    
    


}
