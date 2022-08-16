import LibRando

let deck = LibRando
  .game(named: "Nioh 2")!
  .randomizers["Depths Randomizer"]!
  .randomize(logicLevel: .enhanced)

let floorData = deck
  .map { $0.floorData }

import JavaScriptKit

var document = JSObject.global.document

var cardContainer = document.getElementById("cards")

let keypressFunction = JSClosure { event in
  let event = event.first!.object!

  if event.charCode == 32 {
    print("Turn over a card!")

    var card = document.createElement("div")
    card.innerText = .string(floorData.joined(separator: " "))

    _ = cardContainer.appendChild(card)

    return nil
  } else {
    return event.value
  }
}

document.onkeypress = .object(keypressFunction)
