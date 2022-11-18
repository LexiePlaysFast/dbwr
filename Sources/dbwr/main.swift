import LibRando

struct TestBingoCardSquare: BingoCardSquare {

  let number: Int

  var summary: String { "\(number)" }
  let description = ""

}

var card: BingoCard! = BingoCard(squares: (1...25).map(TestBingoCardSquare.init))

import JavaScriptKit

var document = JSObject.global.document

var bingoCard = document.getElementById("bingoCore")

var bingoCells = bingoCard.getElementsByTagName("td")
var bingoCount: JSValue = bingoCells.length

for index in 0..<25 {
  bingoCells
    .item(index)
    .object
    .map { $0.innerText = JSValue.string(card.squares[index].summary) }
}

print(bingoCount)

let clickFunction = JSClosure { event in
  let event = event.first!.object!

  let target = event.target
  print(target)

  return nil
}

bingoCard.onclick = .object(clickFunction)
