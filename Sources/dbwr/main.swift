import Foundation
import LibSeeded

let state = UUID(uuidString: "4A062CFB-2408-4109-A1FA-C0052796EC1B")!
var generator = UUIDSeededRandomGenerator(state: state)

import LibRando

var card: BingoCard! = LibRando
  .game(named: "Nioh 2")?
  .bingomizers["NG+"]?
  .makeCard(using: &generator)

import JavaScriptKit

var document = JSObject.global.document
print(document.keys())

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

      if BingoScorer.defaultScorer.score(card, using: .lines(1)) == .complete {
        bingoCard.className = "completed"
      }
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
