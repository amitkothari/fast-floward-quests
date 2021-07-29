import Artist from "./contract.cdc"

transaction {
    prepare(account: AuthAccount) {
        let collection <- Artist.createCollection()
        account.save<@Artist.Collection>(<-collection, to: /storage/ArtistCollection)
        account.link<&Artist.Collection>(/public/ArtistCollection, target: /storage/ArtistCollection)
    }
}