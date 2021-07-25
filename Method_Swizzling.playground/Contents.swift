import UIKit

class SomeClass {
    
    @objc dynamic class func saveSomeThings(_ someThing: String) {
        print("SomeClass", someThing)
    }
}

class SomeTestClass {
    
    @objc dynamic class func forTesting_saveSomeThings(_ someThing: String) {
        print("SomeTestClass", someThing)
    }
    
    static let originalMethod = class_getClassMethod(SomeClass.self, #selector(SomeClass.saveSomeThings(_ :)))
    
    static let swizzledMethod = class_getClassMethod(SomeTestClass.self, #selector(SomeTestClass.forTesting_saveSomeThings(_ :)))
    
    static func start() {
        method_exchangeImplementations(originalMethod!, swizzledMethod!)
    }
    
    static func stop() {
        method_exchangeImplementations(swizzledMethod!, originalMethod!)
    }
}

SomeClass.saveSomeThings("saveSomeThings")

SomeTestClass.start()
SomeClass.saveSomeThings("saveSomeThings")
SomeTestClass.stop()
SomeClass.saveSomeThings("saveSomeThings")
