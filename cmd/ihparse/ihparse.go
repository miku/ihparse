package main

import (
	"bufio"
	"encoding/xml"
	"flag"
	"fmt"
	"log"
	"os"
	"strings"
)

type Item struct {
	Title string     `xml:"title"`
	ISSN  string     `xml:"issn"`
	Covs  []Coverage `xml:"coverage"`
}

type Coverage struct {
	FromYear   string `xml:"from>year"`
	FromVolume string `xml:"from>volume"`
	FromIssue  string `xml:"from>issue"`
	ToYear     string `xml:"to>year"`
	ToVolume   string `xml:"to>volume"`
	ToIssue    string `xml:"to>issue"`
	Comment    string `xml:"comment"`
}

func main() {
	flag.Parse()

	if flag.NArg() < 1 {
		log.Fatal("input file needed")
	}

	ff, err := os.Open(flag.Arg(0))
	if err != nil {
		log.Fatal(err)
	}
	reader := bufio.NewReader(ff)

	// XML decoder
	decoder := xml.NewDecoder(reader)
	var inElement string

	for {
		t, _ := decoder.Token()
		if t == nil {
			break
		}
		switch se := t.(type) {
		case xml.StartElement:
			inElement = se.Name.Local
			if inElement == "item" {
				var item Item
				decoder.DecodeElement(&item, &se)
				var comments []string
				for _, cov := range item.Covs {
					comments = append(comments, cov.Comment)
				}
				fmt.Printf("%s\t%d\t%s\n", item.ISSN, len(item.Covs), strings.Join(comments, "|"))
			}
		default:
		}
	}
}
