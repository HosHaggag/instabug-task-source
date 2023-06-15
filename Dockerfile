# Use the official Go image as the base image
FROM golang:1.18-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the necessary files to the container
COPY go.mod go.sum ./
COPY main.go db.go ./

# Download Go dependencies
RUN go mod download

# Build the Go application
RUN go build -o main .

# Use a minimal base image for the final image
FROM alpine:latest

# Copy the source code to the working directory
COPY . .

# Expose the port that the application listens on
EXPOSE 9090

# Set the command to run the application
CMD ["./main"]