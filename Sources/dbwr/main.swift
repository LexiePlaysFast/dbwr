import JavaScriptKit

var document = JSObject.global.document

var cardElement = document.getElementById("card")
var cardContainer = document.getElementById("cards")

let keypressFunction = JSClosure { event in
  let event = event.first!.object!

  if event.charCode == 32 {
    print(event)

    _ = cardContainer.appendChild(cardElement)

    return nil
  } else {
    return event.value
  }
}

document.onkeypress = .object(keypressFunction)
