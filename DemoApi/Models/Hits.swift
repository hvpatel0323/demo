//
//  Hits.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on November 14, 2019

import Foundation
import SwiftyJSON


class Hits : NSObject, NSCoding{

    var author : String!
    var commentText : String!
    var createdAt : String!
    var createdAtI : Int!
    var numComments : Int!
    var parentId : String!
    var points : Int!
    var storyId : String!
    var storyText : String!
    var storyTitle : String!
    var storyUrl : String!
    var title : String!
    var url : String!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        author = json["author"].stringValue
        commentText = json["comment_text"].stringValue
        createdAt = json["created_at"].stringValue
        createdAtI = json["created_at_i"].intValue
        numComments = json["num_comments"].intValue
        parentId = json["parent_id"].stringValue
        points = json["points"].intValue
        storyId = json["story_id"].stringValue
        storyText = json["story_text"].stringValue
        storyTitle = json["story_title"].stringValue
        storyUrl = json["story_url"].stringValue
        title = json["title"].stringValue
        url = json["url"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if author != nil{
        	dictionary["author"] = author
        }
        if commentText != nil{
        	dictionary["comment_text"] = commentText
        }
        if createdAt != nil{
        	dictionary["created_at"] = createdAt
        }
        if createdAtI != nil{
        	dictionary["created_at_i"] = createdAtI
        }
        if numComments != nil{
        	dictionary["num_comments"] = numComments
        }
        if parentId != nil{
        	dictionary["parent_id"] = parentId
        }
        if points != nil{
        	dictionary["points"] = points
        }
        if storyId != nil{
        	dictionary["story_id"] = storyId
        }
        if storyText != nil{
        	dictionary["story_text"] = storyText
        }
        if storyTitle != nil{
        	dictionary["story_title"] = storyTitle
        }
        if storyUrl != nil{
        	dictionary["story_url"] = storyUrl
        }
        if title != nil{
        	dictionary["title"] = title
        }
        if url != nil{
        	dictionary["url"] = url
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		author = aDecoder.decodeObject(forKey: "author") as? String
		commentText = aDecoder.decodeObject(forKey: "comment_text") as? String
		createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
		createdAtI = aDecoder.decodeObject(forKey: "created_at_i") as? Int
		numComments = aDecoder.decodeObject(forKey: "num_comments") as? Int
		parentId = aDecoder.decodeObject(forKey: "parent_id") as? String
		points = aDecoder.decodeObject(forKey: "points") as? Int
		storyId = aDecoder.decodeObject(forKey: "story_id") as? String
		storyText = aDecoder.decodeObject(forKey: "story_text") as? String
		storyTitle = aDecoder.decodeObject(forKey: "story_title") as? String
		storyUrl = aDecoder.decodeObject(forKey: "story_url") as? String
		title = aDecoder.decodeObject(forKey: "title") as? String
		url = aDecoder.decodeObject(forKey: "url") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if author != nil{
			aCoder.encode(author, forKey: "author")
		}
		if commentText != nil{
			aCoder.encode(commentText, forKey: "comment_text")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if createdAtI != nil{
			aCoder.encode(createdAtI, forKey: "created_at_i")
		}
		if numComments != nil{
			aCoder.encode(numComments, forKey: "num_comments")
		}
		if parentId != nil{
			aCoder.encode(parentId, forKey: "parent_id")
		}
		if points != nil{
			aCoder.encode(points, forKey: "points")
		}
		if storyId != nil{
			aCoder.encode(storyId, forKey: "story_id")
		}
		if storyText != nil{
			aCoder.encode(storyText, forKey: "story_text")
		}
		if storyTitle != nil{
			aCoder.encode(storyTitle, forKey: "story_title")
		}
		if storyUrl != nil{
			aCoder.encode(storyUrl, forKey: "story_url")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}
		if url != nil{
			aCoder.encode(url, forKey: "url")
		}

	}

}
