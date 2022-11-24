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
    let uuidString = fragments.first,
    let uuid = UUID(uuidString: String(uuidString))
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
          idxSet.insert(indexString.index(of: character)!.utf16Offset(in: indexString))
        }
    }
  }

  return (uuid, markedIndices)
}
