convert_currencies_df <- function(usd_amount, currency) {
  # Define a lookup table for exchange rates
  exchange_rates <- c(
    "Euro" = 0.96,
    "Indian Rupee" = 86.75,
    "Mexican Peso" = 20.55
  )
  
  # Check if the provided currency exists in the lookup table
  if (currency %in% names(exchange_rates)) {
    converted_amount <- usd_amount * exchange_rates[currency]
    return(data.frame(
      USD = round(usd_amount, 2),
      Converted_Amount = round(converted_amount, 4),
      Currency = currency
    ))
  } else {
    # Handle the case where the currency is not recognized
    stop("Error: Please indicate which currency you'd like to convert to 'Euro', 'Indian Rupee', or 'Mexican Peso'")
  }
}
