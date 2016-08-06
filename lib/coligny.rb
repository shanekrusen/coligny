require "coligny/version"

module Coligny
  require 'date'
  
  def to_bg(ce)
     return ce + 1019
  end
  
  module_function :to_bg
  
  def to_ce(bg)
    return bg - 1019
  end
  
  module_function :to_ce
  
  class ColignyMonth
    attr_reader :name
    attr_accessor :days
    
    def initialize(name, days)
      @name = name
      @days = days
    end
  end
  
  class ColignyYear
    attr_accessor :months, :days 
    
    def initialize(year, is_metonic=false)
      @year = year
      @working_year = Coligny.to_ce(@year)    
      @months = [ColignyMonth.new("Samonios", 30), 
                 ColignyMonth.new("Dumanios", 29), 
                 ColignyMonth.new("Rivros", 30), 
                 ColignyMonth.new("Anagantios", 29), 
                 ColignyMonth.new("Ogronios", 30),
                 ColignyMonth.new("Cutios", 30),
                 ColignyMonth.new("Giamonios", 29),
                 ColignyMonth.new("Simiuisonna", 30),
                 ColignyMonth.new("Elembi", 29),
                 ColignyMonth.new("Aedrinni", 30),
                 ColignyMonth.new("Cantlos", 29)]
      
      if !is_metonic           
        populate_saturn_months  
      else
        populate_metonic_months
      end  
    end
    
    private
    
    def populate_saturn_earlier_equos
      if ((2015 - @working_year) % 5 == 1) || ((2015 - @working_year) % 5 == 0)
        @months.insert(8, ColignyMonth.new("Equos", 30))
      else
        @months.insert(8, ColignyMonth.new("Equos", 29))
      end
    end
    
    def populate_saturn_earlier_int
      if ((2015 - @working_year) % 5 == 0) && ((2015 - @working_year) % 30 != 5)
        @months.unshift(ColignyMonth.new("Intercalary One", 29))
      elsif ((2015 - @working_year) % 5 == 3)
        @months.insert(6, ColignyMonth.new("Intercalary Two", 30))
      end
    end
    
    def populate_saturn_later_equos
      if ((@working_year - 2015) % 5 == 0) || ((@working_year - 2015) % 5 == 4)
        @months.insert(8, ColignyMonth.new("Equos", 30))
      else
        @months.insert(8, ColignyMonth.new("Equos", 29))
      end
    end
    
    def populate_saturn_later_int
      if ((@working_year - 2015) % 5 == 0) 
        @months.unshift(ColignyMonth.new("Intercalary One", 29))
      elsif ((@working_year - 2015) % 5 == 2) && ((@working_year - 2015) % 30 != 27)
        @months.insert(6, ColignyMonth.new("Intercalary Two", 30))
      end
    end
      
    def populate_saturn_months      
      if (@year < 3034)
        populate_saturn_earlier_equos
        populate_saturn_earlier_int
      else        
        populate_saturn_later_equos
        populate_saturn_later_int
      end
    end
    
    def test_against_cases(cases)
      cases.each do |test|
        if ((@working_year - 2016) % 19) == test
          return true
        end
      end
      return false
    end
    
    def test_equos_days_metonic
      cases = [3,4,8,9,13,14,18]
      
      test_against_cases(cases)
    end
    
    def test_intone_metonic
      cases = [4,9,14]
      
      test_against_cases(cases)
    end
    
    def test_inttwo_metonic
      cases = [1,6,11,16]
      
      test_against_cases(cases)
    end
    
    def earlier_than_start_date_test_cases(cases)
      cases.each do |test|
        if ((2016 - @working_year) % 19) == test
          return true
        end
      end
      return false
    end
    
    def test_earlier_than_start_equos_days_metonic
      cases = [1,5,6,10,11,15,16]
      
      earlier_than_start_date_test_cases(cases)
    end
    
    def test_earlier_than_start_date_intone_metonic
      cases = [5,10,15]
      
      earlier_than_start_date_test_cases(cases)
    end
    
    def test_earlier_than_start_date_inttwo_metonic
      cases = [3,8,13,18]
      
      earlier_than_start_date_test_cases(cases)
    end
    
    def populate_metonic_earlier_equos
      if test_earlier_than_start_equos_days_metonic
        @months.insert(8, ColignyMonth.new("Equos", 30))
      else
        @months.insert(8, ColignyMonth.new("Equos", 29))
      end
    end
    
    def populate_metonic_earlier_int
      if test_earlier_than_start_date_intone_metonic
        @months.unshift(ColignyMonth.new("Intercalary One", 29))
      elsif test_earlier_than_start_date_inttwo_metonic
        @months.insert(6, ColignyMonth.new("Intercalary Two", 30))
      end
    end
    
    def populate_metonic_later_equos
      if test_equos_days_metonic
        @months.insert(8, ColignyMonth.new("Equos", 30))
      else
        @months.insert(8, ColignyMonth.new("Equos", 29))
      end
    end
    
    def populate_metonic_later_int
      if test_intone_metonic
        @months.unshift(ColignyMonth.new("Intercalary One", 29))
      elsif test_inttwo_metonic
        @months.insert(6, ColignyMonth.new("Intercalary Two", 30))
      end
    end
    
    def metonic_longcycle_int2_check
      if ((@working_year - 2016) % 6569 <= 4) && ((@working_year - 2016) >= 6569) && (@month[6].name = "Intercalary Two")
        @months.delete_at(6)
      end
    end
    
    def populate_metonic_months
      if @year < 3035        
        populate_metonic_earlier_equos
        populate_metonic_earlier_int
      else
        populate_metonic_later_equos     
        populate_metonic_later_int
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
        start = ColignyDate.new(3034, "Intercalary One", 1)
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
        
        start_coligny = ColignyDate.new(3034, "Intercalary One", 1)
        start_coligny.calc_days(difference)
        return start_coligny
      end
    end
  end
end
