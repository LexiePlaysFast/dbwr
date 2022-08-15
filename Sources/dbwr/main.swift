import JavaScriptKit

var document = JSObject.global.document

let keypressFunction = JSClosure { event in
  print(event)

  return nil
}

document.onkeypress = .object(keypressFunction)
