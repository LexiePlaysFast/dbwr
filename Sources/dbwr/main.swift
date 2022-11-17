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

let clickFunction = JSClosure { event in
  let event = event.first!.object!

  print(event)

  return event.value
}

bingoCard.onclick = .object(clickFunction)
