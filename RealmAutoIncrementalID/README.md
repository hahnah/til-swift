# RalmAutoIncrementalID

A sample of auto incremental ID implementation with RealmSwift.

## Feature

This sample project implements auto incrementa ID with RealmSwift.  
To prevent reuse of deleted IDs, it always allows an dummy object at the tail of Realm Objects.

`RealmAutoIncrementalID/Person.swift` shows auto incremental ID implementaion, and  
`RealmAutoIncrementalID/ViewController.swift` shows how to use it.

## How to build

1. Install pods  
    ```
    $ pod install
    ```
2. Open Project  
    Open RealmAutoIncrementalID.xcworkspace by XCode.
3. Build & Run  
    You can see console log as below. (Nothing appears on your mobile or simulator)
    ```
    1 
    ---------------
    1 Alice
    2 
    ---------------
    2 
    ---------------
    2 Bob
    3 
    ---------------
    ```

## Licene

MIT © [hahnah](https://superhahnah.com)
