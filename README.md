# Coligny

Welcome!
Swáel!

This gem is intended to provide a resource for the use of the Coligny Calendar, according to its alignment by Helen McKay, in the Ruby Language. 

##To-DO

- Finish long-term adjustments for slippage.
- Add Inscriptions for dates
- Comments

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'coligny'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install coligny

## Usage
The main functionality of this project is the conversion of dates to and from the Coligny Calendar.
To convert a Gregorian date to Coligny:

Using the 30-year cycle of Saturn:

```ruby
example = Date.new(2016, 7, 24)
example_new = example.to_coligny_date
#=> #<ColignyDate:0x00000001a97f30>
```

Using the 19-year Metonic Cycle:

```ruby
example = Date.new(2016, 7, 24)
example_new = example.to_coligny_date(true)
#=> #<ColignyDate:0x00000001a97f30>
```

To convert to a Gregorian Date from a Coligny Date:

The method's arguments are the same as Ruby's Date object,
i.e. (year, month, day)
However, the Coligny Months **must** be passed as strings.

Using the 30-year Saturn cycle:

```ruby
example = Coligny::ColignyDate.new(3062, "Rivros", 10)
exmple_new = example.to_gregorian_date
#=> #<Date: 2043-07-24 ((2467455j,0s,0n),+0s,2299161j)>
```

Using the 19-year Metonic cycle:

```ruby
example = Coligny::ColignyDate.new(3062, "Rivros", 10, true)
exmple_new = example.to_gregorian_date
#=> #<Date: 2043-07-23 ((2467455j,0s,0n),+0s,2299161j)>
```

Attributes for dates in the Coligny calendar can be accessed:

```ruby
example = Coligny::ColignyDate.new(3062, "Rivros", 10)
example.year
#=> 3062
example.month.name
#=> "Rivros"
example.month.days
#=> 30
example.day
#=> 10
```

Days can be added to a Coligny Date to find the resulting date:

```ruby
example.calc_days(5)
```
or 

```ruby
example.calc_days(-5)
```

For the purpose of creating a calendar of the year, the ColignyYear class can be used.

```ruby
example = Coligny::ColignyYear.new(2017)
#=> #<ColignyYear:0x000000018420f0>
```

A ColignyYear class has the attribute "months" which is an array of instances of the ColignyMonths class:

```ruby
example.months

#=>[#<ColignyMonth:0x00000001599fb0 @name="Samonios", @days=30>, 
	#<ColignyMonth:0x00000001599f60 @name="Dumanios", @days=29>, 
	#<ColignyMonth:0x00000001599f10 @name="Rivros", @days=30>, 
	#<ColignyMonth:0x00000001599e70 @name="Anagantios", @days=29>, 
	#<ColignyMonth:0x00000001599da8 @name="Ogronios", @days=30>, 
	#<ColignyMonth:0x00000001599d58 @name="Cutios", @days=30>, 
	#<ColignyMonth:0x00000001599d08 @name="Giamonios", @days=29>, 
	#<ColignyMonth:0x00000001599cb8 @name="Simiuisonna", @days=30>, 
	#<ColignyMonth:0x00000001599b28 @name="Equos", @days=29>, 
	#<ColignyMonth:0x00000001599c68 @name="Elembi", @days=29>, 
	#<ColignyMonth:0x00000001599c18 @name="Aedrinni", @days=30>,
	#<ColignyMonth:0x00000001599bc8 @name="Cantlos", @days=29>]
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Credit

Developer - Shane Krusen
The model of the Coligny Calendar used for this project is the product of the work of the brilliant and lovely Helen McKay.
Support and feedback from the Modern Gaulish Community, Steve Hansen, Helen McKay, and my mentor, Klint Thrasher.
