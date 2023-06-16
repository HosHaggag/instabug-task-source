


# Use the official Go image as the base image
FROM golang:1.18-alpine

# Set the working directory inside the container
WORKDIR ./app

# Copy the Go modules manifest file to the working directory
COPY go.mod go.sum ./

# Download the Go modules
RUN go mod download

# Copy the source code to the working directory
COPY . .

# Build the Go application
RUN go build -o main .

# Expose the port that the application listens on
EXPOSE 9090

# Set the command to run the application
CMD ["./main"]

