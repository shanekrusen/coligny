# Coligny

Welcome!
Swáel!

This gem is intended to provide a resource for the use of the Coligny Calendar, according to its alignment by Helen McKay, in the Ruby Language. 

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
**The earliest available date is April 26th, 2015. I can not guarantee that any earlier dates will function properly**

The main functionality of this project is the conversion of dates to and from the Coligny Calendar.
To convert a Gregorian date to Coligny:

```ruby
example = Coligny.to_coligny_date(2016, 7, 24)
#=> #<ColignyDate:0x00000001a97f30>
```

To convert to a Gregorian Date from a Coligny Date:

The method's arguments are the same as Ruby's Date object,
i.e. (year, month, day)
However, the Coligny Months **must** be passed as strings.

```ruby
exmple = Coligny.to_gregorian_date(3062, "Ríur", 10)
#=> #<Date: 2043-07-24 ((2467455j,0s,0n),+0s,2299161j)>
```

Attributes for dates in the Coligny calendar can be accessed:

```ruby
example = Coligny::ColignyDate.new(3062, "Ríur", 10)
example.year
#=> 3062
example.month.name
#=> "Ríur"
example.month.days
#=> 30
example.day
#=> 10
```

Days can be added to a Coligny Date to find the resulting date:

```ruby
example.add_days(5)
```
or 
```ruby
example.subtract_days(5)
```

For the purpose of creating a calendar of the year, the ColignyYear class can be used.

```ruby
example = Coligny::ColignyYear.new(2017)
#=> #<ColignyYear:0x000000018420f0>
```

A ColignyYear class has the attribute "months" which is an array of instances of the ColignyMonths class:

```ruby
example.months

#=>[#<ColignyMonth:0x00000001599fb0 @name="Samon", @days=30>, 
	#<ColignyMonth:0x00000001599f60 @name="Duman", @days=29>, 
	#<ColignyMonth:0x00000001599f10 @name="Ríur", @days=30>, 
	#<ColignyMonth:0x00000001599e70 @name="Anáian", @days=29>, 
	#<ColignyMonth:0x00000001599da8 @name="Oghron", @days=30>, 
	#<ColignyMonth:0x00000001599d58 @name="Cuth", @days=30>, 
	#<ColignyMonth:0x00000001599d08 @name="Giamon", @days=29>, 
	#<ColignyMonth:0x00000001599cb8 @name="Simison", @days=30>, 
	#<ColignyMonth:0x00000001599b28 @name="Échu", @days=29>, 
	#<ColignyMonth:0x00000001599c68 @name="Elem", @days=29>, 
	#<ColignyMonth:0x00000001599c18 @name="Édhrin", @days=30>,
	#<ColignyMonth:0x00000001599bc8 @name="Canthl", @days=29>]
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Credit

Developer - Shane Krusen
The model of the Coligny Calendar used for this project is the product of the work of the brilliant and lovely Helen McKay.
Support and feedback from the Modern Gaulish Community, Steve Hansen, Helen McKay, and my mentor, Klint Thrasher.
