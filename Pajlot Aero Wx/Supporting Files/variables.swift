
import UIKit

var isConnected = false

struct METARItem {
    var title: String
    var description: String
}

struct TAFItem {
    var title: String
    var description: String
}

var ICAOcodesMIL = ["EPIR", "EPCE", "EPDA", "EPDE", "EPKS", "EPLK", "EPLY", "EPMB", "EPMI", "EPMM", "EPNA", "EPOK", "EPPR", "EPPW", "EPSN", "EPTM"]

var ICAOcodesDescription = ["Inowrocław", "Cewice", "Darłowo", "Dęblin", "Krzesiny", "Łask", "Łęczyca", "Malbork", "Mirosławiec", "Mińsk Mazowiecki", "Nadarzyce", "Oksywie", "Pruszcz Gdański", "Powidz", "Świdwin", "Tomaszów Mazowiecki"]

var EPIR = METARItem(title: "EPIR", description: "METAR EPIR nie pobrany")
var EPCE = METARItem(title: "EPCE", description: "METAR EPCE nie pobrany")
var EPDA = METARItem(title: "EPDA", description: "METAR EPDA nie pobrany")
var EPDE = METARItem(title: "EPDE", description: "METAR EPDE nie pobrany")
var EPKS = METARItem(title: "EPKS", description: "METAR EPKS nie pobrany")
var EPLK = METARItem(title: "EPLK", description: "METAR EPLK nie pobrany")
var EPLY = METARItem(title: "EPLY", description: "METAR EPLY nie pobrany")
var EPMB = METARItem(title: "EPMB", description: "METAR EPMB nie pobrany")
var EPMI = METARItem(title: "EPMI", description: "METAR EPMI nie pobrany")
var EPMM = METARItem(title: "EPMM", description: "METAR EPMM nie pobrany")
var EPNA = METARItem(title: "EPNA", description: "METAR EPNA nie pobrany")
var EPOK = METARItem(title: "EPOK", description: "METAR EPOK nie pobrany")
var EPPR = METARItem(title: "EPPR", description: "METAR EPPR nie pobrany")
var EPPW = METARItem(title: "EPPW", description: "METAR EPPW nie pobrany")
var EPSN = METARItem(title: "EPSN", description: "METAR EPSN nie pobrany")
var EPTM = METARItem(title: "EPTM", description: "METAR EPTM nie pobrany")

var Metars: [METARItem] = [EPIR, EPCE, EPDA, EPDE, EPKS, EPLK, EPLY, EPMB, EPMI, EPMM, EPNA, EPOK, EPPR, EPPW, EPSN, EPTM]

//var metarItems: [METARItem] = []
var isParsing: Bool = false

var selectedAirfield: String = ""

//var mainColor = UIColor.rgb(red: 240, green: 182, blue: 81)
var mainColor = UIColor.rgb(red: 35, green: 45, blue: 55)
//var navBarColor = UIColor.rgb(red: 16, green: 25, blue: 38)

var activeColor = UIColor.rgb(red: 80, green: 162, blue: 170)
var accentColor = UIColor.rgb(red: 78, green: 221, blue: 200)

