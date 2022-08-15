import JavaScriptKit

var document = JSObject.global.document

let keypressFunction = JSClosure { event in
  let event = event.first!.object!

  if event.charCode.string == " " {
    print(event)

    return nil
  } else {
    return event.value
  }
}

document.onkeypress = .object(keypressFunction)
