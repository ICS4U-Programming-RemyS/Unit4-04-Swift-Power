// RecPow.swift
//
// Created by Remy Skelton
// Created on 2025-April-29
// Version 1.0
// Copyright (c) Remy Skelton. All rights reserved.
//
// This program will read multiple lines of strings from the input file.
// If the data is valid then it will calculate the base to the exponent
// and write the result to an output file.

// Import Foundation
import Foundation

// Define the InputError enum to handle errors
enum InputError: Error {
    case invalidInput
}

// Do catch block to catch any errors
do {
    // Welcome message
    print("Welcome to the Recursive Power program!")
    print("This program uses recursion to calculate the base ", terminator: "")
    print("to the exponent and write the result to output.txt.")

    // Initialize output string
    var outputStr = ""

    // Define the file paths
    let inputFile = "input.txt"
    let outputFile = "output.txt"

    // Open the input file for reading
    guard let input = FileHandle(forReadingAtPath: inputFile) else {
        throw InputError.invalidInput
    }

    // Read the contents of the input file
    let inputData = input.readDataToEndOfFile()

    // Convert the data to a string
    guard let inputStr = String(data: inputData, encoding: .utf8) else {
        // Throw an error if the data cannot be converted to a string
        throw InputError.invalidInput
    }

    // Split the input into lines
    let inputLines = inputStr.components(separatedBy: "\n")

    // Create position variable
    var position = 0

    // While loop to read each line
    while position < inputLines.count {

        // Split the line into integers
        let currentLine = inputLines[position]
        let currentLineArray = currentLine.components(separatedBy: " ")

        // Check if the line does not have 2 indexes
        if currentLineArray.count != 2 {
            // Write an error message to the output string
            outputStr += "Invalid: \(currentLine) is not a valid base and exponent.\n"
            // Increment the position
            position += 1
            // Continue to the next iteration
            continue
        } else {
            // Convert the base to a integer
            guard let base = Int(currentLineArray[0]) else {
                // Write an error message to the output string
                outputStr += "Invalid: \(currentLine) is not a valid base and exponent.\n"
                // Increment the position
                position += 1
                // Continue to the next iteration
                continue
            }

            // Convert the exponent to a integer
            guard let exponent = Int(currentLineArray[1]) else {
                // Write an error message to the output string
                outputStr += "Invalid: \(currentLine) is not a valid base and exponent.\n"
                // Increment the position
                position += 1
                // Continue to the next iteration
                continue
            }

            // Check if the exponent is negative
            if exponent < 0 {
                // Write an error message to the output string
                outputStr += "Invalid: \(currentLine) is not a valid base and exponent.\n"
                // Increment the position
                position += 1
                // Continue to the next iteration
                continue
            } else {
                // Call the recPow function to calculate the power
                let valuePow = recPow(base: base, exponent: exponent)

                // Add the result to the output string
                outputStr += "\(base)^\(exponent) = \(valuePow)\n"
            }

        }
        // Increment the position
        position += 1
    }

    // Write to output.txt
    try outputStr.write(toFile: outputFile, atomically: true, encoding: .utf8)

    // Print the that the output is written to the file
    print("Power written to output.txt.")

} catch {
    // Print the error message
    print("Error: \(error)")
}

// Function to to find power of integer using recursion
func recPow(base: Int, exponent: Int) -> Int {
    // Base Case: check if the exponent is 0
    if exponent == 0 {
        // Return 1 as any number to the power of 0 is 1
        return 1
    } else {
        // Recursive Case: return the base times the
        // power of the base to the exponent - 1
        return base * recPow(base: base, exponent: exponent - 1)
    }
}