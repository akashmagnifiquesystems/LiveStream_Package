//
//  File.swift
//  
//
//  Created by Aakash Patel on 16/11/21.
//

import Foundation
import FirebaseStorage
import FirebaseDatabase
import FirebaseMessaging
import FirebaseFirestore

public class FirestoreCommentViewModel {
    
    static let shared = FirestoreCommentViewModel()
    public var db : Firestore!
    public var ref : DocumentReference!
    public var listner : ListenerRegistration!
    public var path : String = ""
    private var commentArray : [Comments] = []

    func getCommentList(roomID : String, completion: @escaping ([Comments]) -> Void)
    {
        path = "rooms/\(roomID)/messages"
        
        self.db = Firestore.firestore()
        self.listner = self.db.collection(path).addSnapshotListener({ snapshot, error in
            if snapshot == nil
            {
                print("Error ====", error!)
                return
            }
            self.db.collection(self.path).order(by:"timestamp").getDocuments { snapshotArray, error in
                if (snapshotArray == nil)
                {
                }else{
                    self.commentArray = []
                    for dict in snapshotArray!.documents
                    {
                        let dictData = NSMutableDictionary()
                        dictData.addEntries(from: dict.data())
                        let commentData = Comments(comment: (dictData.object(forKey: "comment") as! String), receiver_image: (dictData.object(forKey: "receiver_image") as! String), receiver_username: (dictData.object(forKey: "receiver_username") as! String), receiver_uuid: (dictData.object(forKey: "receiver_uuid") as! String), sender_image: (dictData.object(forKey: "sender_image") as! String), sender_username: (dictData.object(forKey: "sender_username") as! String), sender_uuid: (dictData.object(forKey: "sender_uuid") as! String), timeStamp: (dictData.object(forKey: "timestamp") as! String))
                        self.commentArray.append(commentData)
                    }
                    
                }
                DispatchQueue.main.async {
                    completion(self.commentArray)
                }
            }
            
        })
    }
    
    //MARK:- Send Comment
    func sendCommentBySelf(commentTxt : String, avtarName : String)
    {
        if commentTxt.count == 0
        {
            return
        }
        self.profileUpdateViewModel.getPersonalInfo()
        
        let seconds : Int = Int(Timestamp().seconds)
        let msgDict = NSMutableDictionary()
        msgDict.setValue(commentTxt, forKey: "comment")
        
        msgDict.setValue((UserDefaultsConstants.shared.fetchFromUserDefault(Key: "firestoreUniqueID") as! String), forKey: "sender_uuid")
        msgDict.setValue((UserDefaultsConstants.shared.fetchFromUserDefault(Key: "streamLiveUserID") as! String), forKey: "receiver_uuid")
        
        msgDict.setValue(String(format: "%ld", seconds), forKey: "timestamp")
        
        msgDict.setValue((UserDefaultsConstants.shared.fetchFromUserDefault(Key: "streamLiveUserProfilePic") as? String ?? ""), forKey: "receiver_image")
        
        msgDict.setValue((UserDefaultsConstants.shared.fetchFromUserDefault(Key: "profilePicURL") as? String ?? ""), forKey: "sender_image")
        
        msgDict.setValue((UserDefaultsConstants.shared.fetchFromUserDefault(Key: "streamLiveUserName") as? String ?? ""), forKey: "receiver_username")
        
        msgDict.setValue(avtarName, forKey: "sender_username")
        
        self.db.collection(path).addDocument(data: msgDict as! [String : Any])
    }
    
    //MARK:- Send Comment by customer
    func sendCommentByCustomer(commentTxt : String, avtarName : String)
    {
        if commentTxt.count == 0
        {
            return
        }
        self.profileUpdateViewModel.getPersonalInfo()
        
        let seconds : Int = Int(Timestamp().seconds)
        
        let msgDict = NSMutableDictionary()
        msgDict.setValue(commentTxt, forKey: "comment")
        
        msgDict.setValue((UserDefaultsConstants.shared.fetchFromUserDefault(Key: "firestoreUniqueID") as! String), forKey: "sender_uuid")
        msgDict.setValue((UserDefaultsConstants.shared.fetchFromUserDefault(Key: "streamLiveUserID") as! String), forKey: "receiver_uuid")
        
        msgDict.setValue(String(format: "%ld", seconds), forKey: "timestamp")
        
        msgDict.setValue((UserDefaultsConstants.shared.fetchFromUserDefault(Key: "streamLiveUserProfilePic") as? String ?? ""), forKey: "receiver_image")
        msgDict.setValue((UserDefaultsConstants.shared.fetchFromUserDefault(Key: "profilePicURL") as? String ?? ""), forKey: "sender_image")
        
        msgDict.setValue((UserDefaultsConstants.shared.fetchFromUserDefault(Key: "streamLiveUserName") as? String ?? ""), forKey: "receiver_username")
        msgDict.setValue(avtarName, forKey: "sender_username")
        
        self.db.collection(path).addDocument(data: msgDict as! [String : Any])
    }
}
