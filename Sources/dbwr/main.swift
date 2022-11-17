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

for cell in JSArray(from: bingoCard.getElementsByTagName("td"))! {
  print(cell)
}

let clickFunction = JSClosure { event in
  let event = event.first!.object!

  let target = event.target
  print(target)

  return nil
}

bingoCard.onclick = .object(clickFunction)
