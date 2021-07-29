import Artist from "./contract.cdc"

pub fun getFormattedPicture(canvas: Artist.Canvas): String {
  let frameHorizontal = "+-----+"
  let frameVertical = "|"

  let height = Int(canvas.height)
  let width = Int(canvas.width)
  
  var row = 0
  var picture = ""
  picture = picture.concat(frameHorizontal)
  while row < height {
    let pixels = canvas.pixels.slice(from: row * width, upTo: (row + 1) * width)
    picture = picture.concat(frameVertical.concat(pixels).concat(frameVertical))
    row = row + 1
  }
  picture = picture.concat(frameHorizontal)
  return picture;
}

pub fun main(address: Address): [String]? {
  let account = getAccount(address)
  let collectionRef = account.getCapability<&Artist.Collection>(/public/ArtistCollection).borrow()
  let pictures: [String] = []

  if let collection = collectionRef {
    if(collection.pictures.length == 0){
      return nil;
    }

    var index = 0
    while index < collection.pictures.length {
      let canvas = collection.pictures[index].canvas
      let picture = getFormattedPicture(canvas: canvas)
      pictures.append(picture)
      index = index + 1
    }
    return pictures;
  } else {
    return nil
  }
}