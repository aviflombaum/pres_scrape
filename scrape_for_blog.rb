require 'nokogiri'
require 'open-uri'
require 'sqlite3'


class President
  attr_accessor :name, :bio

  def self.create_presidents_from_urls
    self.collect_president_urls.collect do |url|
      begin
        President.new_from_url(url)
        sleep 1
      rescue
        next
      end
    end
  end
  
  def self.new_from_url(url)
    p = President.new
    p.get_data(url)
    p
  end
  def self.collect_president_urls
    wiki_page = "http://en.wikipedia.org"
    index_url = wiki_page + "/wiki/List_of_Presidents_of_the_United_States"
    index_doc = Nokogiri::HTML(open(index_url))
    president_anchors = index_doc.css("table.wikitable td b a")
    president_anchors.map {|a| wiki_page + a.attr('href')}
  end

  def initialize
    
  end

  def get_data(url)
    scrape = Scrape.new(url)
    scrape.get_via_scrape

    @name = scrape.name
    @bio = scrape.bio

    self.save
  end

  def save
    s = Sql.new(@name, @bio)
    s.sql_save
  end
end


class Scrape
  attr_accessor :name, :bio

  def initialize(url)
    @doc = Nokogiri::HTML(open(url))
  end

  def get_via_scrape
    self.get_name
    self.get_bio
  end

  def get_name
    if @doc.css("h1")
      @name = @doc.css("h1").inner_text
    end
    puts @name
  end

  def get_bio
    if @doc.css("p:first")
      @bio = @doc.css("p:first").inner_text
    end
  end
end


class Sql
  attr_accessor :name, :bio

  @@db = SQLite3::Database.new('presidents.db')

  def initialize(name, bio)
    @name = name
    @bio = bio
  end

  def self.create_table
    puts "+ creating presidents table +"
    @@db.execute("CREATE TABLE IF NOT EXISTS presidents ( ID INTEGER PRIMARY KEY, name TEXT, bio TEXT)")
  end

  def sql_save
    puts "+ inserting into presidents table +"
    @@db.execute("INSERT INTO presidents (name, bio) VALUES (?, ?)", [@name, @bio])
  end
end


Sql.create_table
presidents = President.create_presidents_from_urls








