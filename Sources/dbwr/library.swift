import Foundation

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

  return (uuid, IndexSet())
}
