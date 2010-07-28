module CucumberFM
  class Statistic < Struct.new(:cfm)
    class Info < Struct.new(:label, :percentage_effort_done, :percentage_quantity_done)
    end

    def initialize(cfm)
      @cfm = cfm
      
    end

    def total_estimation
      @total_estimation ||= cfm.estimation
    end

    def total_quantity
      @total_quantity ||= cfm.scenarios.size
    end

  end
end
