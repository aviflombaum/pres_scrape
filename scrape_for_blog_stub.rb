class President  
  
  def self.create_presidents_from_urls
    # - run the method self.collect_president_urls
    #   (that method will return an array of president urls)
    # - for each of the urls, create a new instance of President
  end

  def self.collect_president_urls
    # - look through a wikipedia page to get all of the anchor nodes
    # - get a url for each president
  end

  def initialize(url)
    #   (initialize is run the moment a new instance of President is born)
    # - call the method get_data on the current instance
  end

  def get_data(url)
   # - create a new instance of Scrape
   # - call get_via_scrape on that instance

   # - make @name equal to whatever was scraped for name
   # - make @bio equal to whatever was scraped for bio

   # - call the save method
  end

  def save
   # - create a new instance of Sql, giving it @name and @bio
   # - call the method sql_save on this instance
  end
end


class Scrape

  def initialize(url)
    # - make sure this instance knows how to scrape its url via Nokogiri
  end

  def get_via_scrape
   # - run the get_name method on the current instance
   # - run the get_bio method on the current instance
  end

  def get_name
   # - if there is an "h1" node, make that node's text equal to @name
  end

  def get_bio
   # - if there is a "p:first" node, make that node's text equal to @bio 
  end
end


class Sql

  @@db = SQLite3::Database.new('presidents.db')
  # @@db now represents the database file on your computer

  def initialize(name, bio)
    # - the argument 'name' that was passed in is now equal to @name
    # - the argument 'bio' that was passed in is now equal to @bio
    #   (we do this so that this information is available across this instance)
  end

  def self.create_table
    # - execute a create table sql statement on presidents.db
  end

  def sql_save
    # - execute an insert sql statement on presidents.db
  end
end


Sql.create_table
presidents = President.create_presidents_from_urls








