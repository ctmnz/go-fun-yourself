package main

import (
	"fmt"
//	"log"
	"net"
)

func main() {

	ip, ipNet, _ := net.ParseCIDR("10.0.41.1/16")
	fmt.Printf("\nip: %s\nNetwork: %s\n",ip ,ipNet)
}


