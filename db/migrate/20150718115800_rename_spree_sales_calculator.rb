class RenameSpreeSalesCalculator < SpreeExtension::Migration[5.1]
  def up
    execute "UPDATE spree_calculators SET type = 'Spree::Calculator::AmountSalePriceCalculator' WHERE type = 'Spree::Calculator::DollarAmountSalePriceCalculator'"
  end

  def down
    execute "UPDATE spree_calculators SET type = 'Spree::Calculator::DollarAmountSalePriceCalculator' WHERE type = 'Spree::Calculator::AmountSalePriceCalculator'"
  end
end
