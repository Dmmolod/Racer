import Foundation

extension UserDefaults {
    
    func setValue<T: Encodable>(_ value: T, forKey key: String) {
        guard let valueData = try? JSONEncoder().encode(value) else { return }
        set(valueData, forKey: key)
    }
    
    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let valueData = value(forKey: key) as? Data,
              let value = try? JSONDecoder().decode(type, from: valueData) else { return nil }
        return value
    }
    
}
