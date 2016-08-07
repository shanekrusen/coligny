require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'test_helper'

class ColignyTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Coligny::VERSION
  end
  
  def test_saturn_to_coligny
    year = Date.new(2045, 4, 23).to_coligny_date
    assert_equal 3063, year.year
    assert_equal 29, year.day
    assert_equal "Cantlos", year.month.name
  end
  
  def test_saturn_to_gregorian
    year = Coligny::ColignyDate.new(3062, "Cantlos", 29).to_gregorian_date
    assert_equal Date.new(2044, 5, 3), year
  end
  
  def test_metonic_to_coligny
    year = Date.new(2044, 5, 4).to_coligny_date(true)
    assert_equal 3062, year.year
    assert_equal 29, year.day
    assert_equal "Cantlos", year.month.name
  end
  
  def test_metonic_to_gregorian
    year = Coligny::ColignyDate.new(3061, "Cantlos", 29).to_gregorian_date
    assert_equal Date.new(2043, 5, 15), year
  end
  
  def test_saturn_early_to_coligny
    year = Date.new(2015, 3, 27).to_coligny_date
    assert_equal 3033, year.year
    assert_equal 30, year.day
    assert_equal "Aedrinni", year.month.name
  end
  
  def test_saturn_early_to_gregorian
    year = Coligny::ColignyDate.new(3033, "Aedrinni", 30).to_gregorian_date
    assert_equal Date.new(2015, 3, 27), year
  end
  
  def test_metonic_early_to_coligny
    year = Date.new(2016, 4, 14).to_coligny_date
    assert_equal 3034, year.year
    assert_equal 30, year.day
    assert_equal "Aedrinni", year.month.name
  end
end
