# This project explains use of Codable protocol to parse and persist json data received from network.
       1. Parse and save json response to disk in very effiecent way with the help of codable. (Without using encoder decoder and core data)
       
       2. Save image in NSCache
       
    # References-:
    1. https://medium.com/@sdrzn/networking-and-persistence-with-json-in-swift-4-c400ecab402d
    2. https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types
    
    
    Note -:
    1. Codable is available swift 4.0+     
    
    Use case-: Make api call, parse and save url and school code on disk. If user quite or relaunch app then do not make api call for school fetch from disk. 
    
