import Cocoa

protocol Shape {
    func area() -> Double
    func perimeter() -> Double
}


class Circle: Shape {
    let radius: Double
    
    init(radius: Double) {
        self.radius = radius
    }
    
    func area() -> Double {
        return Double.pi * radius * radius
    }
    
    func perimeter() -> Double {
        return 2 * Double.pi * radius
    }
}


class Rectangle: Shape {
    let sideA: Double
    let sideB: Double
    
    init(sideA: Double, sideB: Double) {
        self.sideA = sideA
        self.sideB = sideB
    }
    
    func area() -> Double {
        return sideA * sideB
    }
    
    func perimeter() -> Double {
        return 2 * (sideA + sideB)
    }
}


func generateShape() -> some Shape {
    return Circle(radius: 5)
}

func calculateShapeDetails(_ shape: any Shape) -> (Double, Double) {
    return (shape.area(), shape.perimeter())
}


let rect1 = Rectangle(sideA: 5, sideB: 15)
let circ1 = generateShape()

print(calculateShapeDetails(rect1))
print(calculateShapeDetails(circ1))
