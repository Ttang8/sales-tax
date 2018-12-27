# SALES TAXES

Basic sales tax is applicable at a rate of 10% on all goods, except books, food, and medical products that are exempt. Import duty is an additional sales tax applicable on all imported goods at a rate of 5%, with no exemptions.

When I purchase items I receive a receipt that lists the name of all the items and their price (including tax), finishing with the total cost of the items, and the total amounts of sales taxes paid. The rounding rules for sales tax are that for a tax rate of n%, a shelf price of p contains (np/100 rounded up to the nearest 0.05) amount of sales tax.

Write an application that prints out the receipt details for these shopping baskets; this application should be written in Ruby [1] and use Rspec [2] to test inputs and the expected outputs. The output should be to standard out or CSV.

Proper object orientated design is important. Each row in the input represents a line item of the receipt.

# How to Run Program

1. bundle install
2. ruby lib/sales_tax.rb
3. input path name of csv file

Output will be a csv file titled receipt + path name

# How to Run Rspec

1. bundle exec rspec/spec/sales_tax_spec.rb
