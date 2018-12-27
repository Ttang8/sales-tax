require 'csv'

class SalesTax
  attr_accessor :path_name
  attr_reader :calculated_sales_tax, :total

  def initialize(path_name)
    @path_name = path_name
    @array = CSV.read(path_name)
    @@sales_tax = 10
    @@import_tax = 5
    @calculated_sales_tax = 0
    @total = 0
    @receipt_array = []

    #Able to continuely add to list of exempt products from tax
    @@exempt_products = ['chocolate', 'pill', 'book']

    calculate_sales_tax
    create_csv
  end

  def calculate_sales_tax
    @array[1..-1].each do |arr|
      price = arr[0].to_i * arr[2].to_f
      if arr[1].include?('import')
        if check_exempt_products(arr[1].downcase)
          tax = round_to_05(price * 0.05)
          @calculated_sales_tax += tax
          @total += (price + tax).round(2)
          @receipt_array << [arr[0], arr[1], " #{'%.2f' % (price + tax).round(2)}"]
        else
          tax = round_to_05(price * 0.15)
          @calculated_sales_tax += tax
          @total += (price + tax).round(2)
          @receipt_array << [arr[0], arr[1], " #{'%.2f' % (price + tax).round(2)}"]
        end
      elsif check_exempt_products(arr[1].downcase)
        @total += price.round(2)
        @receipt_array << [arr[0], arr[1], " #{'%.2f' % price.round(2)}"]
      else
        tax = round_to_05(price * 0.10)
        @calculated_sales_tax += tax
        @total += (price + tax).round(2)
        @receipt_array << [arr[0], arr[1], " #{'%.2f' % (price + tax).round(2)}"]
      end
    end
  end

  def check_exempt_products(str)
    @@exempt_products.each do |product|
      return true if str.include?(product)
    end
    false
  end

  def create_csv
    CSV.open("receipt_#{path_name}", "wb") do |csv|
      @receipt_array.each do |arr|
        csv << arr
      end
      csv << ["Sales Tax: #{'%.2f' % @calculated_sales_tax}"]
      csv << ["Total: #{'%.2f' % @total}"]
    end
  end

  def round_to_05(price)
    int = (price.round(2) % 0.05).round(2)
    if  int < 0.05
      return (price.round(2) + (0.05 - int)).round(2)
    else
      return price.round(2)
    end
  end
end

if __FILE__ == $0
  puts "Enter file path ex.path/to/file.csv"
  a = gets.chomp
  SalesTax.new(a)
end
