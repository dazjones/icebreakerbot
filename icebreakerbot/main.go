package main

import (
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"math/rand"
	"time"
)

var questions [24]string

func init() {
	questions = [24]string{
		"If you were a vegetable, what vegetable would you be?",
		"If you woke up tomorrow as an animal, what animal would you choose to be and why?",
		"If you could live anywhere on this planet & and take everything that you love with you, where would you choose to live?",
		"What favorite color are you and how does being that color make you feel?",
		"If you could choose an imaginary friend, who would you choose and why?",
		"If you could sit on a bench in a beautiful woods, who would you like sitting next to you on the bench and why?",
		"Are you sunrise, daylight, twilight, or night? Please share why you picked your time of day.",
		"If you could choose your age forever, what age would you choose and why?",
		"If you could be in the movie of your choice, what movie would you choose and what character would you play?",
		"If you could meet any historical figure, who would you choose and why?",
		"If you were a city, which city would you choose to be and why?",
		"What are your 3 favorite foods?",
		"If you were a candy bar, which candy bar would you be? Share why.",
		"If you were to change your name, what name would you adopt going forward? Why?",
		"Are you spring, summer, fall, or winter? Please share why.",
		"If you were stranded on a desert island, what three items would you want to have with you?",
		"Share a description of your favorite material object that you already own?",
		"What item that you don't have already, would you most like to own?",
		"If you were to create a slogan for your life, what would the slogan be?",
		"Pick something out of your pocket or purse and share with the group why it's important to you.",
		"If you could meet any living person for a chat over a shared dinner, who would you pick and why?",
		"If you awoke one day as a flower, what flower would you choose to be?",
		"If you could choose one hobby that now seems out of your reach either financially or time-wise, what hobby would you take up and why?",
		"Thinking about the architecture of houses, what type of architecture is the best fit for you? What appeals to you about your choice?",
	}
}

func GetIceBreaker() string {
	rand.Seed(time.Now().Unix()) // initialize global pseudo random generator
	return questions[rand.Intn(len(questions))]
}

func GetIceBreakerHandler(request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	return events.APIGatewayProxyResponse{Body: GetIceBreaker(), StatusCode: 200}, nil
}

func main() {
	lambda.Start(GetIceBreakerHandler)
}
