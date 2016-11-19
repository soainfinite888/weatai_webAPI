# frozen_string_literal: true

# Search query for postings in a group by optional keywords
class WeatherQuery
  def self.call()
    
  end

  private_class_method

  def self.search_postings(group, search_terms)
    Weather.where(where_clause(search_terms), ).all
  end

  def self.where_clause(search_terms)
    search_terms.map do |term|
      Sequel.ilike()
    end.inject(&:|)
  end
end
