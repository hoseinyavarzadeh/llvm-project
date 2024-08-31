#include <iostream>

int main () {
    int a = 3;
    int b = 5;

    if (a == 1) {
        b -= 1;
    } else {
        b += 1;
    }

    if (b == 6) {
        b -= 2;
    } else {
        a += 1;
    }

    std::cout << a << std::endl;

    return 0;
}