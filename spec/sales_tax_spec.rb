require 'rspec'
require_relative '../lib/sales_tax.rb'

describe SalesTax do
  app = SalesTax.new("test.csv")

  describe "#round_to_05" do
    it "rounds price to the nearest 0.05" do
        expect(app.round_to_05(10.01)).to eq(10.05)
    end
  end

  describe "#check_exempt_products" do
    it "returns true for book, food, or medical products" do
      expect(app.check_exempt_products('book')).to eq(true)
    end

    it "returns false for non book, food, or medical products" do
      expect(app.check_exempt_products('music')).to eq(false)
    end
  end

  describe "#calculate_sales_tax" do
    it "returns the correct total sales tax" do
      expect(app.calculated_sales_tax).to eq(1.50)
    end

    it "returns the correct overall total" do
      expect(app.total).to eq(29.83)
    end
  end
end
