import Foundation
import LibSeeded
import LibRando

import JavaScriptKit

var window = JSObject.global.window
let hash = window.location.hash.string!
let state: UUID

if let parsed = parse(urlHash: hash) {
  state = parsed.0
  print(parsed.1)
} else {
  state = UUID()
}

window.location.hash = JSValue.string("#/\(state)")

var generator = UUIDSeededRandomGenerator(state: state)

var card: BingoCard! = LibRando
  .game(named: "Nioh 2")?
  .bingomizers["NG+"]?
  .makeCard(using: &generator)

var document = JSObject.global.document

var permalink = document.getElementById("permalink")
permalink.href = window.location.href

var bingoCore = document.getElementById("bingoCore")
var bingoCard = document.getElementById("bingoCard")
var bingoData = document.getElementById("bingoData")

var bingoCells = bingoCore.getElementsByTagName("td")

for index in 0..<25 {
  bingoCells
    .item(index)
    .object
    .map { $0.innerText = JSValue.string(card.squares[index].summary) }
}

let clickFunction = JSClosure { event in
  let event = event.first!.object!

  let target = event.target.object!

  if target.className.string! != "marked" {
    let square: String = target.getAttribute!("data-square").string!
    if card.mark(square: square) {
      target.className = "marked"

      if BingoScorer.defaultScorer.score(card, using: .blackout) == .complete {
        bingoCard.className = "completed"
      }

      print(render(indices: card.marked))
    }
  }

  return nil
}

let hoverFunction = JSClosure { event in
  let event = event.first!.object!

  let target = event.target.object!

  if target.tagName.string == "TD" {
    let square = target.getAttribute!("data-square").string!
    let bingoSquare = card.square(named: square)!

    bingoData.getElementsByTagName("h2").item(0).object.map { $0.innerText = JSValue.string(bingoSquare.summary) }
    bingoData.getElementsByTagName("p").item(0).object.map { $0.innerText = JSValue.string(bingoSquare.description) }
  }

  return event.value
}

bingoCore.onclick = .object(clickFunction)
bingoCore.onmouseover = .object(hoverFunction)
