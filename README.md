# Date Idea Finder

> Find a date idea based on your preferences. It is as simple as that.

## Overview

Date Idea is a web application that helps users find date ideas tailored to their preferences. Whether you're looking for a romantic dinner, an adventurous outing, or a cozy night in, Date Idea has you covered.

## Features

- **Personalized Suggestions**: Get date ideas based on your interests and preferences.
- **Variety of Categories**: Choose from categories like outdoor activities, dining, entertainment, and more.
- **User-Friendly Interface**: Easy to navigate and find the perfect date idea.

## Prerequisites

Before you begin, ensure you have the following installed:

- **Node.js**: A JavaScript runtime environment.
- **Yarn**: A package manager for your code.

## Installation

Follow these steps to set up and run the project:

1. **Clone the Repository**

   ```sh
   git clone https://github.com/JuKa2023/Date-Idea.git
   cd Date-Idea
   ```

2. **Install Dependencies**

   Use Yarn to install the project dependencies.

   ```sh
   yarn
   ```

## Running the Project

After installing the dependencies, you can run the project in development mode. This will start a local server with hot reloading, so you can see your changes immediately.

```sh
yarn run dev
```

Open your browser and navigate to the URL output by Vite.

## Building the Project

To create an optimized build of the project for production, use the following command:

```sh
yarn run build
```

This will generate a `dist` folder with the compiled files.

## Project Structure

Here's a brief overview of the project's structure:

```
date-idea/
├── src/                # Source code
│   ├── assets/         # Images, styles, etc.
│   ├── components/     # Vue components
│   ├── App.vue         # Root component
|   ├── supabase.js     # Supabase configuration
│   ├── auth.js         # Authentication logic
│   └── main.js         # Entry point
├── .gitignore          # Files to be ignored by Git
├── index.html          # HTML template
├── package.json        # Project metadata and scripts
├── README.md           # Project documentation
|── vite.config.js      # Vite configuration
└── yarn.lock           # Yarn lock file
```
