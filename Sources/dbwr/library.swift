import Foundation

fileprivate let indexString = "ABCDEFGHIJKLMNOPQRSTUVWYZ"

func parse(urlHash: String) -> (UUID, IndexSet)? {
  guard
    urlHash.hasPrefix("#/")
  else {
    return nil
  }

  let fragments = urlHash
    .dropFirst(2)
    .split(separator: "?", maxSplits: 2)

  guard
    let path = fragments.first
  else {
    return nil
  }

  guard
    let uuid = UUID(uuidString: String(path))
  else {
    return nil
  }

  var markedIndices = IndexSet()

  if fragments.count == 2 {
    let markedParameter = fragments.last!
    if markedParameter.hasPrefix("marked=") {
      let markedString = String(markedParameter.dropFirst(7))
      markedIndices = markedString
        .reduce(into: IndexSet()) { idxSet, character in
          idxSet.insert(indexString.firstIndex(of: character)!.utf16Offset(in: indexString))
        }
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
