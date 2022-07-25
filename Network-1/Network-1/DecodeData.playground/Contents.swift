import UIKit

struct GithubProfile : Codable {
  let login : String
  let avatarUrl : String
  let htmlUrl : String
  let followers : Int
  let following : Int
  
  enum CodingKeys : String, CodingKey {
    case login
    case avatarUrl = "avatar_url"
    case htmlUrl = "html_url"
    case followers
    case following
  }
}

let session = URLSession.shared

let url = URL(string: "https://api.github.com/users/ByoungilYoun")!

let task = session.dataTask(with: url) { data, response, error in

  guard let httpResponse = response as? HTTPURLResponse,
        (200..<300).contains(httpResponse.statusCode) else {
    print("response : \(String(describing: response))")
    return
  }
  
  guard let data = data else { return }
  
  do {
    let decoder = JSONDecoder()
    let profile = try decoder.decode(GithubProfile.self, from: data)
    print("profile : \(profile)")
  } catch let error as NSError {
    print("decoding error : \(error.localizedDescription)")
  }
}

task.resume()
