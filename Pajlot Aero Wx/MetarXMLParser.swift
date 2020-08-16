
import Foundation

class MetarFeedParser: NSObject, XMLParserDelegate{
    private var currentElement = ""
    
    private var metarItems: [METARItem] = Metars
    private var currentAirfield = ""
    private var index: Int = 0
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
    private var parserCompletionHandler: (([METARItem]) -> Void)?
    
    func parseFeed(completionHandler: (([METARItem]) -> Void)?){
        self.parserCompletionHandler = completionHandler
        
        for airfield in ICAOcodesMIL {
            currentAirfield = airfield
            let airfieldUrl = "http://awiacja.imgw.pl/rss/metarmil.php?airport=\(currentAirfield)"
            print("Pobieram dla lotniska: \(currentAirfield), index ustawiony na: \(index)")
            let request = URLRequest(url: URL(string: airfieldUrl)!)
            let urlSession = URLSession.shared
            let task = urlSession.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    
                    return
                }
                
                let parser = XMLParser(data: data)
                parser.delegate = self
                parser.parse()
            }
            
            task.resume()
        }
    }
    
    // MARK: - XML Parser Delegate
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        isParsing = true
        //print("isParsing ustawione ne: \(isParsing)")
        currentElement = elementName
        if currentElement == "item" {
            currentTitle = ""
            currentDescription = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        switch currentElement {
        case "title":
            var title = string
            title = title.replacingOccurrences(of: "Metar G30 ", with: "")
            currentTitle += title
            let airfield = findAirfield(ICAO: title)
            currentTitle += airfield
        case "description":
            var description = string
            description = description.replacingOccurrences(of: "  ", with: "")
            if description != "" {
                currentDescription += description
            }else{
                currentDescription += "Brak aktualnej depeszy"
            }
        default: break
        }
    }
    
    func findAirfield(ICAO: String) -> String {
        var airfield: String = ""
        switch ICAO {
        case "EPCE":
            airfield = " - Cewice"
        case "EPDA":
            airfield = " - Darłowo"
        case "EPDE":
            airfield = " - Dęblin"
        case "EPIR":
            airfield = " - Inowrocław"
        case "EPKS":
            airfield = " - Krzesiny"
        case "EPLK":
            airfield = " - Łask"
        case "EPLY":
            airfield = " - Łęczyca"
        case "EPMB":
            airfield = " - Malbork"
        case "EPMI":
            airfield = " - Mirosławiec"
        case "EPMM":
            airfield = " - Mińsk Mazowiecki"
        case "EPNA":
            airfield = " - Nadarzyce"
        case "EPOK":
            airfield = " - Oksywie"
        case "EPPR":
            airfield = " - Pruszcz Gdański"
        case "EPPW":
            airfield = " - Powidz"
        case "EPSN":
            airfield = " - Świdwin"
        case "EPTM":
            airfield = " - Tomaszów Mazowiecki"
        default:
            airfield = ""
        }
        return airfield
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let metarItem = METARItem(title: currentTitle, description: currentDescription)
            //metarItems.append(metarItem)
            metarItems[index] = metarItem
            index += 1
            print("metarsItem[\(index)] zawiera: \(metarItem) | metarItems.count: \(metarItems.count)")
            //print("\n\t metarItems[0]: \(metarItems[0])")
        }
        isParsing = false
        //print("isParsing ustawione ne: \(isParsing)")
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(metarItems)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
    
}
