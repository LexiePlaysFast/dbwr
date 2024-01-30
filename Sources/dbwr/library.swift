import Foundation

fileprivate let indexString = "ABCDEFGHIJKLMNOPQRSTUVWYZ"

func parse(urlHash: String) -> (UUID, IndexSet)? {
  guard
    urlHash.hasPrefix("#/")
  else {
    return nil
  }

  guard
    let urlComponents = URLComponents(string: String(urlHash.dropFirst(2)))
  else {
    return nil
  }

  guard
    let uuid = UUID(uuidString: urlComponents.path)
  else {
    return nil
  }

  var markedIndices = IndexSet()

  if
    let marked = urlComponents.queryItems?.first(where: { $0.name == "marked" }),
    let markedString = marked.value
  {
    markedIndices = markedString
      .reduce(into: IndexSet()) { idxSet, character in
        idxSet.insert(indexString.firstIndex(of: character)!.utf16Offset(in: indexString))
      }
  }

  return (uuid, markedIndices)
}

func render(indices: IndexSet) -> String {
  indices
    .map {
      String(indexString[String.Index(utf16Offset: $0, in: indexString)])
    }
    .reduce("", +)
}

func urlHash(boardUUID: UUID, selected: IndexSet) -> String {
  let boardID = "#/\(boardUUID)"

  return selected.count == 0
    ? boardID
    : "\(boardID)?marked=\(render(indices: selected))"
}
