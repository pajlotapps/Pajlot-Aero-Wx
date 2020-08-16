
import Foundation

protocol tafDelegate {
    func tafPassing(tafItem: TAFItem)
}

class TafFetch: NSObject, XMLParserDelegate {

    private var currentElement = ""
    private var htmlContent: NSString!

    private var TAF: TAFItem!

    private var currentName: String!
    private var currentAirfield: String!

    
    var delegate: tafDelegate?

    
    private var currentTitle: String = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentDescription: String = "" {
        didSet {
            currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var parserCompletionHandler: ((TAFItem) -> Void)?
    
    
    func parseFeed(airfield: String, completionHandler: ((TAFItem) -> Void)?){
        self.parserCompletionHandler = completionHandler
        
        currentName = "TAF \(airfield)</span> "
        currentAirfield = airfield

        let airfieldUrl = "http://awiacja.imgw.pl/index.php?product=taf_mil"
        
        let request = URLRequest(url: URL(string: airfieldUrl)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                }else{
                    
                    self.htmlContent = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    let text = String(describing: self.htmlContent)
                    
                    if let start = text.range(of: self.currentName),
                        let end  = text.range(of: "<br><br><span class='redfont'>TAF", range: start.upperBound..<text.endIndex) {
                        let TAFraw = text[start.upperBound..<end.lowerBound]
                        
                        self.currentDescription = String(TAFraw)
                        self.currentDescription = self.currentDescription.replacingOccurrences(of: "<br>", with: "")
                        self.currentDescription = self.currentDescription.replacingOccurrences(of: "  ", with: "")

                        self.TAF = TAFItem(title: self.currentAirfield, description: self.currentDescription)
                    } else {
                        self.TAF = TAFItem(title: self.currentAirfield, description: "Brak aktualnej depeszy TAF dla \(airfield)")
                    }
                    self.delegate?.tafPassing(tafItem: self.TAF)
                    print(self.TAF.description)
                }
        }

        task.resume()
    }
}
