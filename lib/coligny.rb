# Copyright 2016 @shanekrusen 
# License MIT (https://opensource.org/licenses/MIT)

# require "coligny/version"

module Coligny
  require 'date'
  
  #Adds ColignyMonth object, which has a name and number of days.
  class ColignyMonth
    attr_reader :name
    attr_accessor :days
    
    #Populate these attributes when the instance of ColignyMonth is created.
    def initialize(name, days)
      @name = name
      @days = days
    end
  end
  
  #Adds ColignyYearClass, which has attributes year, months(an array of ColignyMonth instances) and 
  class ColignyYear
    attr_accessor :months
    attr_reader :is_early
    
    def initialize(year, is_metonic=false)
      @is_metonic = is_metonic
      @year = year    
      @months = [ColignyMonth.new("Samonios", 30), 
                 ColignyMonth.new("Dumanios", 29), 
                 ColignyMonth.new("Riuros", 30), 
                 ColignyMonth.new("Anagantios", 29), 
                 ColignyMonth.new("Ogronios", 30),
                 ColignyMonth.new("Cutios", 30),
                 ColignyMonth.new("Giamonios", 29),
                 ColignyMonth.new("Simiuisonna", 30),
                 ColignyMonth.new("Elembi", 29),
                 ColignyMonth.new("Aedrinni", 30),
                 ColignyMonth.new("Cantlos", 29)]
      
      is_early?
      
      if !is_metonic           
        populate_saturn_months  
      else
        populate_metonic_months
      end  
    end
    
    private
    
    def is_early?
      if @is_metonic
        if (@year < 3035)
          @is_early = true 
        else
          @is_early = false
        end
      else
        if (@year < 3034)
          @is_early = true 
        else
          @is_early = false
        end
      end
    end
    
    def year_difference
      if @is_metonic
        if @is_early
          return 3035 - @year     
        else
          return @year - 3035
        end
      else
        if @is_early
          return 3034 - @year
        else
          return @year - 3034
        end
      end
    end
    
    def populate_saturn_equos
      if @is_early
        if (year_difference % 5 == 1) || (year_difference % 5 == 0) 
          @months.insert(8, ColignyMonth.new("Equos", 30))
        else
          @months.insert(8, ColignyMonth.new("Equos", 29))
        end
      elsif (year_difference % 5 == 0) || (year_difference % 5 == 4)
        @months.insert(8, ColignyMonth.new("Equos", 30))
      else
        @months.insert(8, ColignyMonth.new("Equos", 29))
      end
    end
    
    def populate_saturn_int1
      if year_difference % 5 == 0
        @months.unshift(ColignyMonth.new("Quimonios", 29))
      end
    end
    
    def populate_saturn_int2_check(cycle_repeat, cycle_limit, exception_cycle, exception_limit)
      if (year_difference % cycle_repeat == cycle_limit) && (year_difference % exception_cycle != exception_limit)
        return true
      else
        return false
      end
    end
    
    def populate_saturn_int2 
      if (@is_early && populate_saturn_int2_check(5, 3, 30, 3)) || (!@is_early && populate_saturn_int2_check(5, 2, 30, 27))
        @months.insert(6, ColignyMonth.new("Rantaranos", 30))
      end
    end
        
    def identify_year_locator(difference, years_between_instances)
      if @is_early
        if ((year_difference) % difference >= years_between_instances) || ((year_difference) % difference == 0)
          return true
        else
          return false
        end
      else
        if ((year_difference) % difference <= years_between_instances)
          return true
        else
          return false
        end
      end
    end
    
    def saturn_cycle_check(difference, years_between_instances, cycle, cycle_remainder)
      if identify_year_locator(difference, years_between_instances) && ((year_difference) >= difference) && ((year_difference) & cycle == cycle_remainder)
        return true
      else
        return false
      end
    end
    
    def saturn_longcycle_equos_check
      if (@is_early && saturn_cycle_check(198, 194, 5, 1)) || (!@is_early && saturn_cycle_check(198, 4, 5, 4))
        @months.find { |s| s.name == "Equos" }.days = 29
      end
    end
    
    def saturn_longcycle_int2_check
      if saturn_cycle_check(635, 29, 30, 27)
        @months.insert(6, ColignyMonth.new("Rantaranos", 30))
      end
    end
    
    def saturn_reverse_longcycle_int2_check
      if saturn_cycle_check(635, 606, 30, 3)
        @months.insert(6, ColignyMonth.new("Rantaranos", 30))
      end 
    end
     
    def populate_saturn_months 
      populate_saturn_equos
      populate_saturn_int1
      populate_saturn_int2
      saturn_longcycle_equos_check
           
      if @is_early
        saturn_reverse_longcycle_int2_check
      else        
        saturn_longcycle_int2_check
      end
    end
    
    def test_against_cases(cases)
      cases.each do |test|
        if (year_difference % 19) == test
          return true
        end
      end
      return false
    end
    
    def test_equos_days_metonic
      cases = [3,4,8,9,13,14,18]
      
      return test_against_cases(cases)
    end
    
    def test_intone_metonic
      cases = [4,9,14]
      
      return test_against_cases(cases)
    end
    
    def test_inttwo_metonic
      cases = [1,6,11,16]
      
      return test_against_cases(cases)
    end

    def test_earlier_than_start_equos_days_metonic
      cases = [1,5,6,10,11,15,16]
      
      return test_against_cases(cases)
    end
    
    def test_earlier_than_start_date_intone_metonic
      cases = [5,10,15]
      
      return test_against_cases(cases)
    end
    
    def test_earlier_than_start_date_inttwo_metonic
      cases = [3,8,13,18]
      
      return test_against_cases(cases)
    end
    
    def populate_metonic_equos
      if (@is_early && (test_earlier_than_start_equos_days_metonic)) || (!@is_early && (test_equos_days_metonic))
        @months.insert(8, ColignyMonth.new("Equos", 30))
      else
        @months.insert(8, ColignyMonth.new("Equos", 29))
      end
    end
    
    def populate_metonic_int1
      if (@is_early && test_earlier_than_start_date_intone_metonic) || (!@is_early && test_intone_metonic)
        @months.unshift(ColignyMonth.new("Quimonios", 29))
      end      
    end
    
    def populate_metonic_int2
      if (@is_early && test_earlier_than_start_date_inttwo_metonic) || (!@is_early && test_inttwo_metonic)
        @months.insert(6, ColignyMonth.new("Rantaranos", 30))
      end
    end
    
    def metonic_longcycle_early_year_check(frequency_of_adjustment, case_limiter)
      if ((year_difference % frequency_of_adjustment >= case_limiter) || (year_difference % frequency_of_adjustment == 0)) && (year_difference >= frequency_of_adjustment)
        return true
      else
        return false
      end
    end

    def metonic_longcycle_late_year_check(frequency_of_adjustment, case_limiter)
      if (year_difference % frequency_of_adjustment <= case_limiter) && (year_difference >= frequency_of_adjustment)
        return true
      else
        return false
      end
    end
    
    def metonic_longcycle_year_check(frequency_of_adjustment, case_limiter)
      if @is_early
        return metonic_longcycle_early_year_check(frequency_of_adjustment, case_limiter)
      else
        return metonic_longcycle_late_year_check(frequency_of_adjustment, case_limiter)
      end
    end
    
    def metonic_longcycle_int2_check
      if metonic_longcycle_year_check(6569, 4) && (@months[6].name == "Rantaranos")
        @months.delete_at(6)
      end
    end
    
    def metonic_longcycle_equos_check
      if (metonic_longcycle_year_check(61, 4) && test_earlier_than_start_date_inttwo_metonic) || (metonic_longcycle_year_check(61, 57) && test_inttwo_metonic)
        @months.find { |s| s.name == "Equos" }.days = 29
      end
    end
    
    def metonic_longcycle_reverse_int2_check
      if metonic_longcycle_year_check(6569, 6565) && (@months[6].name == "Rantaranos")
        @months.delete_at(6)
      end
    end
    
    def populate_metonic_months
      populate_metonic_equos
      populate_metonic_int1
      populate_metonic_int2
      metonic_longcycle_equos_check
      
      if @is_early
        metonic_longcycle_reverse_int2_check
      else
        metonic_longcycle_int2_check        
      end
    end
  end
  
  class ColignyDate
    attr_accessor :year, :day, :month, :months
    
    def initialize(year, month, day, is_metonic=false)
      @is_metonic = is_metonic
      @year = year
      @day = day
      if @is_metonic
        @start_year = 3035
        @start_date = Date.new(2016, 5, 14)
        @months = ColignyYear.new(year, true).months
      else
        @start_year = 3034
        @start_date = Date.new(2015, 4, 26)
        @months = ColignyYear.new(year).months
      end
      @month = @months.find { |s| s.name == month }
    end
    
    def days_exceed_over
      if @months[@months.index(@month) + 1].nil?
        @day = @day - @month.days
        @year += 1
        if @is_metonic
          @months = ColignyYear.new(@year, true).months
        else
          @months = ColignyYear.new(@year).months
        end
        @month = @months[0]
      else
        @day = @day - @month.days
        @month = @months[@months.index(@month) + 1]
      end
    end
    
    def days_exceed_under
      if @month == @months[0]
        @year -= 1
        if @is_metonic
          @months = ColignyYear.new(@year, true).months
        else
          @months = ColignyYear.new(@year).months
        end
        @month = @months[-1]
        @day = @month.days + (@day)
      else
        @month = @months[@months.index(@month) - 1]
        @day = @month.days + (@day)
      end
    end
    
    def calc_days(add)
      @day += add
      
      while @day > @month.days
        days_exceed_over
      end
      
      while @day < 1
        days_exceed_under
      end
    end
    
    def earlier_check(check_date) 
      day_count = 0
           
      until self.month.name == check_date.month.name && self.day == check_date.day && self.year == check_date.year
        self.calc_days(1)
        day_count += 1
      end
      
      return day_count
    end
    
    def later_check(check_date)
      day_count = 0
            
      until check_date.month.name == self.month.name && check_date.day == self.day && check_date.year == self.year
        check_date.calc_days(1)
        day_count += 1
      end
      
      return day_count
    end
  
    def to_gregorian_date   
      if @is_metonic
        start = ColignyDate.new(3035, "Samonios", 1, true)
      else
        start = ColignyDate.new(3034, "Quimonios", 1)
      end  
      
      if (@year < @start_year)
        return @start_date - earlier_check(start)
      else
        return @start_date + later_check(start)
      end    
    end
  end
  
  Date.class_eval do
    def to_coligny_date(is_metonic=false)    
      if is_metonic
        start = Date.new(2016, 5, 14)
        end_date = Date.new(self.year, self.month, self.mday)
        difference = (end_date - start).to_i
        
        start_coligny = ColignyDate.new(3035, "Samonios", 1, true)
        start_coligny.calc_days(difference)
        return start_coligny
      else
        start = Date.new(2015, 4, 26)
        end_date = Date.new(self.year, self.month, self.mday)
        difference = (end_date - start).to_i
        
        start_coligny = ColignyDate.new(3034, "Quimonios", 1)
        start_coligny.calc_days(difference)
        return start_coligny
      end
    end
  end
end
