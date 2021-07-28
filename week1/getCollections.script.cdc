import Artist from 0x02

pub fun display(canvas: Artist.Canvas) {
  let frameHorizontal = "+-----+"
  let frameVertical = "|"

  let height = Int(canvas.height)
  let width = Int(canvas.width)
  
  var row = 0
  log(frameHorizontal)
  while row < height {
    let pixels = canvas.pixels.slice(from: row * width, upTo: (row + 1) * width)
    log(frameVertical.concat(pixels).concat(frameVertical))
    row = row + 1
  }
  log(frameHorizontal)
}

pub fun main() {
    let accounts = [getAccount(0x01), getAccount(0x02), getAccount(0x03), getAccount(0x04), getAccount(0x05)]

    for account in accounts {
      let artistCollection = account.getCapability<&Artist.Collection>(/public/ArtistCollection)
      let collectionRef = artistCollection.borrow()

      if let collection = collectionRef {
        for key in collection.items.keys {
          let maybeCanvas = collection.items[key]?.canvas
          if let canvas = maybeCanvas {
            display(canvas: canvas)
          }      
        }
      } else {
        log("No collection found for account - ".concat(account.address.toString()))
      }
    }
}