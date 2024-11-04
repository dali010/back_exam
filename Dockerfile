# Step 1: Build Stage
FROM node:18-alpine AS build
 
# Set the working directory
WORKDIR /app
 
# Copy package.json and package-lock.json
COPY package.json package-lock.json ./
 
# Install dependencies
RUN npm install
 
# Copy the rest of the application code
COPY . .
 
# Step 2: Runtime Stage
FROM node:18-alpine
 
# Set the working directory
WORKDIR /app
 
# Copy only the necessary files from the build stage
COPY --from=build /app /app
 
# Expose the port the app runs on
EXPOSE 5000
 
# Command to run the application
CMD ["node", "index.js"]