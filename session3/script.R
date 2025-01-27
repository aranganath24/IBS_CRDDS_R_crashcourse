convert_temperature <- function(value, unit) {
  if (unit == "Fahrenheit") {
    # Convert Fahrenheit to Celsius
    celsius <- (value - 32) * 5 / 9
    return(celsius)
  } else if (unit == "Celsius") {
    # Convert Celsius to Fahrenheit
    fahrenheit <- (value * 9 / 5) + 32
    return(fahrenheit)
  } else {
    # Handle invalid input for the unit
    return("Please indicate whether your input is in Celsius or Fahrenheit")
  }
}
