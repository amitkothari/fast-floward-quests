import Artist from "./contract.cdc"

// Print a Picture and store it in the authorizing account's Picture Collection.
transaction(width: UInt8, height: UInt8, pixels: String) {
    prepare(account: AuthAccount) {
        let printerRef = account
            .getCapability<&Artist.Printer>(/public/ArtistPicturePrinter)
            .borrow()
            ?? panic("Couldn't borrow printer reference")

        let collectionRef = account
            .getCapability<&Artist.Collection>(/public/ArtistCollection)
            .borrow()
            ?? panic("Couldn't borrow collection reference")

        let canvas = Artist.Canvas(
            width: width,
            height: height,
            pixels: pixels,
        )
        let maybePicture <- printerRef.print(canvas: canvas)
        if let picture <- maybePicture {
          collectionRef.deposit(picture: <- picture)
        } else {
          destroy maybePicture
        }
    }
}