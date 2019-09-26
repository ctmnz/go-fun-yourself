package main

import (
	"fmt"
	"gopkg.in/yaml.v2"
	"io/ioutil"
	"log"
)

func main() {

	fdata, err := ioutil.ReadFile("data.yaml")
	if err != nil {
		log.Fatalln(err)
	}

	type userProfile struct {
		Name      string   `yaml:"name,omitempty"`
		Age       int      `yaml:"age,omitempty"`
		Multiline string   `yaml:"multi_line_variable"`
		Hobbies   []string `yaml:"hobbies"`
		FriendList []map[string]string `yaml:"friend_list"`
		EnvVars map[string]string `yaml:"env_vars"`
	}

	var up userProfile
	err = yaml.Unmarshal(fdata, &up)
	if err != nil {
		log.Fatalln(err)
	}

	fmt.Printf("\nName: %s\n", up.Name)
	fmt.Printf("\nMultiline text: %s\n", up.Multiline)

	fmt.Printf("Hobbies: \n")
	for _, hobbie := range up.Hobbies {
		fmt.Printf("- %s\n", hobbie)
	}

	fmt.Printf("\nFriend list: \n")
	for _, friend := range up.FriendList {
		fmt.Printf("\n")
		for k, v := range friend {
			fmt.Printf("\t%s -> %s \n", k, v)
		}
	}


	fmt.Printf("\nEnv Variables: \n")
	for k, v := range up.EnvVars {
		fmt.Printf("\t%s -> %s \n", k, v)
	}
}
