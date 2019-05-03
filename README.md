# MVVMProject
# Summary

Libraries used:
- `Alamofire 5` for network calls and decoding JSON.
- `MBProgressHUD` for showing the activity indicator.
- `Realm` for database operations.

ARCHITECTURE
1) APIPosts, APIUsers, APIComments (APIRouter) - These classes  will present an endpoint using HTTP method, HTTP headers, path and parameters. We have created our API router using Swift Enum. These classes basically builds each endpoint respectively. 
2) APIClient - This class creates and performs the request. It also decodes the JSON into our model Objects.
3) PostViewModel, CommentsViewModel (View Model)-  The view model talks to the APIClient to make the request and gets the response. It also talks to the DBmanager for database operations and supplies the ViewController with nessary data.
4) DBManager -  Handles all database operations. Incase of a no internet connection scenario, the data wil be fetched from the database.
5) PostsVC, CommentsVC (ViewControler) - Its only job is to display the data and handle UI operation. 

UNIT TESTS
    - Test for checking if the user's api returns the response and parses correctly into our `User` model object.
    - Test for checking if the post's api returns the response and parses into our `Post` model object.
    - Test for checking if comment's api retruns the response & parses correctly into our `Comment` object, when a valid post id is passed.
    - Test for checking if  comment's api retruns the response & parses correctly into our `Comment` object, when an invalid post id is passed. (This test should fail)
    
UI TESTS
    - Test when users launches the app and loads the posts & comments data succesfully.  (This test will fail if there is no internet connection and there is no data in the cache/Database.)
    
 
# Other details
1. I used `Codable`  to directly decode the JSON response into our model object.  And `Realm` to store these objects into our database.
```class Post: Object, Codable {
        @objc dynamic var userId = 0
        @objc dynamic var id = 0
        @objc dynamic var title = ""
        @objc dynamic var body = ""
        @objc dynamic var username: String? = nil
            override static func primaryKey() -> String? {
                return "id"
            }
}
```
- With regards to the `Post` model , I  added this extra property  `username`  in order to get the username  from the user table in database and  assign it to this property.  So its easier to get the username directly from the post object and display it.


 Used Alamofire 5 for making network calls.  Alamofire 5 now has  a new method `responseDecodable` which helps  us to make a request and returns a Decodable object/structure .

```            AF.request(APIPosts.allposts)
                    .responseDecodable { (response: DataResponse<[Post]>) in
                        print("POSTS---\(response)")
                        switch response.result {
                        case .success:
                            completion(response.value, nil)
                        case .failure(let error):
                            print(error.localizedDescription)
                            completion(nil, error.localizedDescription)
                        }
                    }
```

2. Made use of `coordinators` to handle app navgation.
