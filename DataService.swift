//
//  DataService.swift
//  NEXT-GEN
//
//  Created by Steve Slack on 01/02/2016.
//  Copyright © 2016 Steve Slack. All rights reserved.
//

import Foundation
import Firebase

let BASE_URL = "https://next-gen-coach.firebaseio.com"

class DataService {
    
    static let ds = DataService()
    
    private var _REF_BASE = Firebase(url: "\(BASE_URL)")
    private var _REF_POSTS = Firebase(url: "\(BASE_URL)/posts")
    private var _REF_USERS = Firebase(url: "\(BASE_URL)/users")
    private var _REF_NEWS_POSTS = Firebase(url: "\(BASE_URL)/news")
    
    var REF_BASE: Firebase {
        
        return _REF_BASE
    }
    
    var REF_POSTS: Firebase {
        return _REF_POSTS
    }
    
    var REF_USERS: Firebase {
        
        return _REF_USERS
    }

    var _REF_USER_CURRENT: Firebase {
        
        let uid = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as! String
        
        let user = Firebase(url: "\(BASE_URL)").childByAppendingPath("users").childByAppendingPath(uid)
        return user!
        
    }
    
    var REF_NEWS_POSTS: Firebase {
        return _REF_NEWS_POSTS
        
    }
    
    
    
    
    
}