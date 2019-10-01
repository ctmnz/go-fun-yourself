package main

import (
	"fmt"
)

func Sum(nums ...int) int {
	res := 0
	for _, num := range nums {
		res += num
	}
	return res
}

func main() {

mynums := []int{12,22,84,23,44}
fmt.Println(Sum(mynums...))

}
