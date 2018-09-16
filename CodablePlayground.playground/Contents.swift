//: Playground - noun: a place where people can play

import Foundation

/*
 {
 "name" : "Prime Focus TECHNOLOGY",
 "mobile_number" : 8602875253,
 "address" : {
 "city" : "Bangalore",
 "pinCode" : 560037,
 "country" : "India"
 }
 }
 */
//{"name":"Prime Focus","contact" : 8602875253}

//First way
/*struct Company: Codable {
    
    var name: String
    var mobile : Int
    var address : Address
    
    enum CodingKeys: String, CodingKey {
        case mobile = "mobile_number"
        case name
        case address
    }
}
 
struct Address: Codable {
    var city: String
    var pinCode: Int
    var country: String
}*/


struct Company
{
    var name: String
    var mobile : Int
    var city: String
    var pinCode: Int
    var country: String
    
    enum CodingKeys: String, CodingKey {
        case mobile = "mobile_number"
        case name
        case address
    }
    
    enum AddressKeys: String, CodingKey {
        case city
        case pinCode
        case country
    }
}

extension Company: Encodable
{
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(mobile, forKey: .mobile)
        
        var addressContainer = container.nestedContainer(keyedBy: AddressKeys.self, forKey: .address)
        try addressContainer.encode(city, forKey: .city)
        try addressContainer.encode(city, forKey: .city)
        try addressContainer.encode(pinCode, forKey: .pinCode)
        try addressContainer.encode(country, forKey: .country)
    }
}

extension Company: Decodable
{
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        mobile = try values.decode(Int.self, forKey: .mobile)
        
        let addressContainer = try values.nestedContainer(keyedBy: AddressKeys.self, forKey: .address)
        city = try addressContainer.decode(String.self, forKey: .city)
        pinCode = try addressContainer.decode(Int.self, forKey: .pinCode)
        country = try addressContainer.decode(String.self, forKey: .country)
    }

}

let url = Bundle.main.url(forResource: "response", withExtension: "json")!
let data = try! Data(contentsOf: url)
let company = try JSONDecoder().decode(Company.self, from:data)
print(company.name)
print(company.mobile)
//print(company.address.pinCode)
print(company.pinCode)
