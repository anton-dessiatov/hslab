#include <math.h> // for M_PI
#include <iostream>
#include <memory> // for std::unique_ptr

class Shape {
public:
  virtual ~Shape() { }
  virtual double Area() = 0;
  virtual double Perimeter() = 0;
  virtual std::unique_ptr<Shape> Scale(double factor) = 0;
};

class Rect : public Shape {
public:
  Rect(double w, double h)
    : w_(w), h_(h) {}

  virtual double Area() {
    return w_ * h_;
  }

  virtual double Perimeter() {
    return 2 * (w_ + h_);
  }

  virtual std::unique_ptr<Shape> Scale(double factor) {
    return std::make_unique<Rect>(factor * w_, factor * h_);
  }
private:
  double w_, h_;
};

class Circle : public Shape {
public:
  Circle(double r) 
    : r_(r) {}
  
  virtual double Area() {
    return M_PI * r_ * r_;
  }

  virtual double Perimeter() {
    return 2 * M_PI * r_;
  }

  virtual std::unique_ptr<Shape> Scale(double factor) {
    return std::make_unique<Circle>(factor * r_);
  }
private:
  double r_;
};

class Triangle : public Shape {
public:
  Triangle(double a, double b, double c) 
    : a_(a), b_(b), c_(c) { }

  virtual double Perimeter() {
    return a_ + b_ + c_;
  }

  virtual double Area() {
    const double s = (a_ + b_ + c_) / 2;
    return sqrt(s * (s - a_) * (s - b_) * (s - c_));
  }

  virtual std::unique_ptr<Shape> Scale(double factor) {
    return std::make_unique<Triangle>(factor * a_, factor * b_, factor * c_);
  }
private:
  double a_, b_, c_;
};

int main(int argc, char* argv[]) {
  std::cout << "Perimeter of unit rect: " << Rect(1.0, 1.0).Perimeter() << std::endl;
  std::cout << "Area of unit rect: " << Rect(1.0, 1.0).Area() << std::endl;
  std::cout << "Perimeter of unit circle: " << Circle(1.0).Perimeter() << std::endl;
  std::cout << "Area of unit circle: " << Circle(1.0).Area() << std::endl;
  std::cout << "Perimeter of unit triangle: " << Triangle(1.0, 1.0, 1.0).Perimeter() << std::endl;
  std::cout << "Area of unit triangle: " << Triangle(1.0, 1.0, 1.0).Area() << std::endl;

  return 0;
}