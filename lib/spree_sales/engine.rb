module SpreeSales
  class Engine < Rails::Engine
    require "spree/core"
    isolate_namespace Spree
    engine_name "spree_sales"

    config.autoload_paths += %W[#{config.root}/lib]

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer "spree.sales_configuration.environment", before: :load_config_initializers do 
      Spree::SalesConfiguration::Config = Spree::SalesConfiguration.new
      Spree::SalesConfiguration::Config.calculators << Spree::Calculator::AmountSalePriceCalculator
      Spree::SalesConfiguration::Config.calculators << Spree::Calculator::PercentOffSalePriceCalculator
      puts "CONFIG LOAD DEBUG"
    end

    def self.activate
      cache_klasses = %W(#{config.root}/app/**/*_decorator*.rb #{config.root}/app/overrides/*.rb)
      Dir.glob(cache_klasses) do |klass|
        Rails.configuration.cache_classes ? require(klass) : load(klass)
      end
    end
    
    

    config.to_prepare &method(:activate).to_proc
  end
end
