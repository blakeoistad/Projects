//: Playground - noun: a place where people can play

import UIKit

//String Variations for Title

//var aNormalAmpTitleString = "#675 - Kirik Jenness & Chris Prennimal"
var aNormalComTitleString = "#169 - Brian Redban, Doug Benson, Bert Kreischer, Ari Shaffir, Jason Gillearn"
var aFightCompanionTitleString = "Fight Companion - August 8, 2015"
var aJRQETitleString = "JRQE#3 - Duncan Trussell"
//var aPODCASTTitleString = "PODCAST #186 - Ari Shaffir, Brian Redban"
//var aJRETitleString = "JRE #277 - Victor Conte, Brian Redban"
var aSpecialTitleString = "Podcast from a car"
//var aLateDateTitleString = "#301 - Doug Stanhope, Brian Redban - Date: 12/22/2012"
//var titleStringArray = [aNormalAmpTitleString, aNormalComTitleString, aFightCompanionTitleString, aJRQETitleString, aJRETitleString, aPODCASTTitleString, aSpecialTitleString, aLateDateTitleString]




//Separate Episode Number from Episode Guests in a regular comma separated guest list

let splitNormalComString = aNormalComTitleString.componentsSeparatedByString("-")
let episodeNumberString = splitNormalComString[0]
let episodeGuestString = splitNormalComString[1]
let splitGuests = episodeGuestString.componentsSeparatedByString(",")
let guest1 = splitGuests[0]
let guest2 = splitGuests[1]
let guest3 = splitGuests[2]
let guest4 = splitGuests[3]
let guest5 = splitGuests[4]
let episodeGuestArray = [guest1, guest2, guest3, guest4, guest5]



if entryTitle == "Podcast from a car" {
    entryTitle = "Podcast from a car - Bryan Callen"
}
if entryTitle == "Podcast from a car #2" {
    entryTitle = "Podcast from a car #2 - Cameron Haynes"
}
if entryTitle == "Podcast in a Swedish Hotel Room" {
    entryTitle = "Podcast in a Swedish Hotel Room - Tony Hinchcliffe"
}

//Separate Episode Number from Episode Guests in a regular amperstand separated guest list

//let splitNormalAmpString = aNormalAmpTitleString.componentsSeparatedByString("-")
//let episodeNumberString = splitNormalAmpString[0]
//let episodeGuestString = splitNormalAmpString[1]
//let splitGuests = episodeGuestString.componentsSeparatedByString("&")
//let guest1 = splitGuests[0]
//let guest2 = splitGuests[1]
//let episodeGuestArray = [guest1, guest2]



//Remove instance of PODCAST from episode title, then separate Episode Number from Episode Guests in a regular comma separated guest list

//let removedPODCASTTitleString = aPODCASTTitleString.stringByReplacingOccurrencesOfString("PODCAST", withString: "")
//let splitTitleString = removedPODCASTTitleString.componentsSeparatedByString("-")
//let episodeNumberString = splitTitleString[0]
//let episodeGuestString = splitTitleString[1]
//let splitGuests = episodeGuestString.componentsSeparatedByString(",")
//let guest1 = splitGuests[0]
//let guest2 = splitGuests[1]
//let episodeGuestArray = [guest1, guest2]



//Remove instance of JRE from episode title, then separate Episode Number from Episode Guests in a regular comma separated guest list

//let removedJRETitleString = aJRETitleString.stringByReplacingOccurrencesOfString("JRE", withString: "")
//let splitTitleString = removedJRETitleString.componentsSeparatedByString("-")
//let episodeNumberString = splitTitleString[0]
//let episodeGuestString = splitTitleString[1]
//let splitGuests = episodeGuestString.componentsSeparatedByString(",")
//let guest1 = splitGuests[0]
//let guest2 = splitGuests[1]
//let episodeGuestArray = [guest1, guest2]



//Remove extraneous date at the end of the title string, then separate Episode Number from Episode guests in a regular comma separated guest list

//let splitTitleString = aLateDateTitleString.componentsSeparatedByString("-")
//let episodeNumberString = splitTitleString[0]
//let episodeGuestString = splitTitleString[1]
//let splitGuests = episodeGuestString.componentsSeparatedByString(",")
//let guest1 = splitGuests[0]
//let guest2 = splitGuests[1]
//let episodeGuestArray = [guest1, guest2]



let stupidString = "Spiders are stupid, from Unbox Therapy."
let commaPosition = stupidString.rangeOfString(",")
//let endPosition = stupidString[advance(stupidString.startIndex,commaPosition)..< stupidString.endIndex]
let endOfString = stupidString.endIndex
//let commaFromString = stupidString.substringFromIndex(stupidString.endIndex.advancedBy(-4))



