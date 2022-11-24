import Foundation
import LibSeeded
import LibRando

import JavaScriptKit

var window = JSObject.global.window
let hash = window.location.hash.string!
let state: UUID
let initialMarks: IndexSet

if let parsed = parse(urlHash: hash) {
  state = parsed.0
  initialMarks = parsed.1
} else {
  state = UUID()
  initialMarks = IndexSet()
}

var generator = UUIDSeededRandomGenerator(state: state)

var card: BingoCard! = LibRando
  .game(named: "Nioh 2")?
  .bingomizers["NG"]?
  .makeCard(using: &generator)

card.mark(indices: initialMarks)

var document = JSObject.global.document

var permalink = document.getElementById("permalink")

window.location.hash = JSValue.string(urlHash(boardUUID: state, selected: card.marked))
permalink.href = window.location.href

var bingoCore = document.getElementById("bingoCore")
var bingoCard = document.getElementById("bingoCard")
var bingoData = document.getElementById("bingoData")

var bingoCells = bingoCore.getElementsByTagName("td")

for index in 0..<25 {
  bingoCells
    .item(index)
    .object
    .map {
      $0.innerText = JSValue.string(card.squares[index].summary)

      if card.marked.contains(index) {
        $0.className = "marked"
      }
    }
}

if BingoScorer.defaultScorer.score(card, using: .blackout) == .complete {
  bingoCard.className = "completed"
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

      window.location.hash = JSValue.string(urlHash(boardUUID: state, selected: card.marked))
      permalink.href = window.location.href
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
