
pub struct Canvas {
  pub let width: UInt8
  pub let height: UInt8
  pub let pixels: String

  init(width: UInt8, height: UInt8, pixels: String){
    self.width = width
    self.height = height
    self.pixels = pixels
  }
}

pub resource Picture {
  pub let canvas: Canvas

  init(canvas: Canvas){
    self.canvas = canvas
  }
}

pub fun serializeStringArray(_ lines: [String]): String {
  var buffer = ""
  for line in lines {
    buffer = buffer.concat(line)
  }

  return buffer;
}

pub fun display(canvas: Canvas) {
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

pub resource Printer {
  pub let printedCanvases: [String]

  init(){
    self.printedCanvases = []
  }

  pub fun print(canvas: Canvas): @Picture? {
    if(!self.printedCanvases.contains(canvas.pixels)){
      self.printedCanvases.append(canvas.pixels)
      let picture <- create Picture(canvas: canvas)
      display(canvas: picture.canvas)
      return <- picture
    }
    return nil
  }
}

pub fun main() {
  let pixelsX = [
    "*   *",
    " * * ",
    "  *  ",
    " * * ",
    "*   *"
  ]

  let printer <- create Printer()

  let canvasX = Canvas(
    width: 5,
    height: 5,
    pixels: serializeStringArray(pixelsX)
  )
  let picture <- printer.print(canvas: canvasX)
  destroy picture
  
  let duplicateCanvasX = Canvas(
    width: 5,
    height: 5,
    pixels: serializeStringArray(pixelsX)
  )
  let duplicatePicture <- printer.print(canvas: canvasX)
  destroy duplicatePicture

  destroy printer
}