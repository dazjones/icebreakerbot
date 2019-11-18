package main

import "testing"

func TestGetIceBreaker(t *testing.T) {
	i := GetIceBreaker()

	if i == "" {
		t.Errorf("Expected not empty string, got empty string")
	}
}
