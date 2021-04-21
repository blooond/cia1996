NUMBER = 5

class Country
  require 'rexml/document'
  include REXML

  def initialize
    @doc = Document.new File.new('data.xml')
    @population = []
    @inflation = []
    @doc.elements.each('cia/country') do |element|
      @population << element.attributes['population'].to_i
      @inflation << element.attributes['inflation'].to_i
    end
  end

  def max_population
    @max_pop = 0

    @population.size.times do |i|
      @max_pop = @population[i] if @population[i] > @max_pop
    end

    @doc.elements.each('cia/country') do |element|
      @name_pop = element.attributes['name'] if element.attributes['population'].to_i == @max_pop
    end
    puts "Max population:\n#{@name_pop}, #{@max_pop} people.\n "
  end

  def max_inflation
    puts 'Top inflation: '
    @inflation = @inflation.sort!.last(NUMBER)
    NUMBER.times do |i|
      @doc.elements.each('cia/country') do |element|
        if element.attributes['inflation'].to_i == @inflation[i]
          @name_inf = element.attributes['name']
          puts "#{@name_inf}, #{@inflation[i]}."
        end
      end
    end
  end
end

class Continent
  require 'rexml/document'
  include REXML

  def initialize
    @doc = Document.new File.new('data.xml')
    @continents = []
    @doc.elements.each('cia/continent') do |element|
      @continents << element.attributes['name']
    end
  end

  def output
    puts "\nContinents from this file:"
    puts @continents.sort!
  end

  def output_with_countries
    puts "\nContinents with their countries:"
    @continents.length.times do |i|
      puts "#{@continents[i]}:"
      @doc.elements.each('cia/country') do |element|
        puts "#{element.attributes['name']}" if @continents[i] == element.attributes['continent']
      end
    end
  end
end

country = Country.new
country.max_population
country.max_inflation

continents = Continent.new
continents.output
continents.output_with_countries
