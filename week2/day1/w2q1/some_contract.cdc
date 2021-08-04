access(all) contract SomeContract {
    pub var testStruct: SomeStruct

    pub struct SomeStruct {
        // 4 Variables
        //
        pub(set) var a: String

        pub var b: String

        access(contract) var c: String

        access(self) var d: String

        // 3 Functions
        //
        pub fun publicFunc() {}

        access(self) fun privateFunc() {}

        access(contract) fun contractFunc() {}


        pub fun structFunc() {
            // Area 1
            // variables with read scope - a, b, c, d
            // variable with write scope - a, b, c, d
            // functions with access -  publicFunc, privateFunc, contractFunc
        }

        init() {
            self.a = "a"
            self.b = "b"
            self.c = "c"
            self.d = "d"
        }
    }

    pub resource SomeResource {
        pub var e: Int

        pub fun resourceFunc() {
            // Area 2
            // variables with read scope - a, b, c
            // variable with write scope - a
            // functions with access -  publicFunc, contractFunc
        }

        init() {
            self.e = 17
        }
    }

    pub fun createSomeResource(): @SomeResource {
        return <- create SomeResource()
    }

    pub fun questsAreFun() {
        // Area 3
        // variables with read scope - a, b, c
        // variable with write scope - a
        // functions with access -  publicFunc, contractFunc
    }

    init() {
        self.testStruct = SomeStruct()
    }
}
