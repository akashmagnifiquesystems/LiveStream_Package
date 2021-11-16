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
                    completion(commentArray)
                }
            }
            
        })
    }

}
