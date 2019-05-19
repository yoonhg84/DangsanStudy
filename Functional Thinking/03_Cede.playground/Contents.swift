import Foundation

// Example 3-1
print("Example 3-1")

struct Employee {
    let name: String
    let salary: Int
}

func paidMore(amount: Int) -> (Employee) -> Bool {
    return { (e: Employee) in
        e.salary > amount
    }
}

var isHighPaid = paidMore(amount: 100000)


// Example 3-2
print("Example 3-2")

let smithers = Employee(name: "Fred", salary: 120000)
let homer = Employee(name: "Homer", salary: 80000)
// output: true
print(isHighPaid(smithers))
// output: false
print(isHighPaid(homer))


// Exmaple 3-3
print("Example 3-3")

isHighPaid = paidMore(amount: 200000)
// output: false
print(isHighPaid(smithers))
// output: false
print(isHighPaid(homer))
let burns = Employee(name: "Monty", salary: 1000000)
// output: true
print(isHighPaid(burns))


// Example 3-4
print("Example 3-4")

func makeCounter() -> () -> Int {
    var localVariable = 0
    return {
        localVariable += 1
        return localVariable
    }
}

let c1 = makeCounter()
c1()
c1()
c1()

let c2 = makeCounter()

// output: c1 = 4, c2 = 1
print("c1 = \(c1()), c2 = \(c2())")


// Example 3-6
print("Example 3-6")

let product: (Int) -> (Int) -> Int = { x in { x * $0 } }
let quadrante = product(4)
let octate = product(8)

// output: 4x4: 16
print("4x4: \(quadrante(4))")
// output: 8x5: 40
print("8x5: \(octate(5))")


// Example 3-7
print("Example 3-7")

let volume: (Int) -> (Int) -> (Int) -> Int = { h in { w in { l in h * w * l }}}
let area = volume(1)
let lengthPA = volume(1)(1)

// output: The volume of the 2x3x4 rectangular solid is 24
print("The volume of the 2x3x4 rectangular solid is \(volume(2)(3)(4))")
// output: The area of the 3x4 rectangle is 12
print("The area of the 3x4 rectangle is \(area(3)(4))")
// output: The length of the 6 line is 6
print("The length of the 6 line is \(lengthPA(6))")


// Example 3-8
print("Example 3-8")

let composite: ( @escaping (Int) -> Int, @escaping (Int) -> Int) -> (Int) -> Int = { f, g in { x in f(g(x)) }}
let thirtyTwoer = composite(quadrante, octate)

// output: composition of curried functions yields 64
print("composition of curried functions yields \(thirtyTwoer(2))")


// Example 3-10
print("Example 3-10")

func filter(_ xs: [Int], _ p: (Int) -> Bool) -> [Int] {
    guard let head = xs.first else {
        return xs
    }
    
    if p(head) {
        return [head] + filter(Array(xs[1...]), p)
    }
    return filter(Array(xs[1...]), p)
}

let modN: (Int) -> (Int) -> Bool = { n in { x in x % n == 0 }}
let nums = [1, 2, 3, 4, 5, 6, 7, 8]
// output: [2, 4, 6, 8]
print(filter(nums, modN(2)))
// output: [3, 6]
print(filter(nums, modN(3)))


// Example 3-11
print("Example 3-11")

enum Product {
    case apple
    case orange
}
enum State {
    case NY
    case FL
}
func price(product: Product) -> Int {
    switch product {
    case .apple:
        return 140
    case .orange:
        return 223
    }
}
func withTax(cost: Int, state: State) -> Int {
    switch state {
    case .NY:
        return cost * 2
    case .FL:
        return cost * 3
    }
}
func withTax(state: State) -> (Int) -> Int {
    switch state {
    case .NY:
        return { cost in cost * 2 }
    case .FL:
        return { $0 * 3 }
    }
}

let locallyTaxed = withTax(state: .NY)
let costOfApples = locallyTaxed(price(product: .apple))
assert(costOfApples == 280)


// Example 3-12
print("Example 3-12")

let cities = [
    "Atlanta": "GA",
    "New York": "New York",
    "Chicago": "IL",
    "San Francsico": "CA",
    "Dallas": "TX"
]
// output: Chicago -> IL
//         San Francsico -> CA
//         Atlanta -> GA
//         Dallas -> TX
//         New York -> New York
cities.map { key, value in print("\(key) -> \(value)") }


// Example 3-13
print("Example 3-13")

//[1, 3, 5, "seven"].map { $0 as? Int }.map { $0 + 1}
let compact = [1, 3, 5, "seven"].compactMap { $0 as? Int }.map { $0 + 1}
assert([2, 4, 6] == compact)


// Example 3-14
print("Example 3-17")

let addr: (Int) -> (Int) -> Int = { x in { y in x + y }}
let incrementer = addr(1)
// output: increment 7: 8
print("increment 7: \(incrementer(7))")


// Example 3-19
print("Example 3-19")

let numbers = [6, 28, 4, 9, 12, 4, 8, 8, 11, 45, 99, 2]

func iterate(list: [Int]) {
    list.forEach {
        print($0)
    }
}

print("Iterate List")
//output: 6
//        28
//        4
//        9
//        12
//        4
//        8
//        8
//        11
//        45
//        99
//        2
iterate(list: numbers)


// Example 3-20
print("Example 3-20")

func recurse(list: [Int]) {
    guard let head = list.first else { return }
    
    print(head)
    recurse(list: Array(list[1...]))
}

print("Recurse List")
//output: 6
//        28
//        4
//        9
//        12
//        4
//        8
//        8
//        11
//        45
//        99
//        2
recurse(list: numbers)


// Example 3-21
print("Example 3-21")

func filter2(_ list: [Int], _ predicate: (Int) -> Bool) -> [Int] {
    var newList: [Int] = []
    
    list.forEach {
        if predicate($0) {
            newList.append($0)
        }
    }
    return newList
}

let modBy2: (Int) -> Bool = { n in n % 2 == 0 }
let l = filter2((1...20).map { $0 }, modBy2)
// output: [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
print(l)


// Example 3-22
print("Example 3-22")

func filterR(_ list: [Int], _ pred: (Int) -> Bool) -> [Int] {
    guard let head = list.first else { return list }
    
    if pred(head) {
        return [head] + filterR(Array(list[1...]), pred)
    }
    return filterR(Array(list[1...]), pred)
}

print("Recursive Filtering")
// output: [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
print(filterR((1...20).map { $0 }, { $0 % 2 == 0 }))


// Example 3-23
print("Example 3-23")

func filter3(_ xs: [Int], _ p: (Int) -> Bool) -> [Int] {
    guard let head = xs.first else { return xs }
    
    if p(head) {
        return [head] + filterR(Array(xs[1...]), p)
    }
    return filter3(Array(xs[1...]), p)
}

let dividesBy: (Int) -> (Int) -> Bool = { n in { x in x % n == 0 }}
// output: [2, 4, 6, 8]
print(filter3(nums, dividesBy(2)))
// output: [3, 6]
print(filter3(nums, dividesBy(3)))

