class Movie < ActiveRecord::Base
	validates_presence_of :title, :description, :rating, :released_on
	validates_uniqueness_of :title
	validates_length_of :description, :minimum => 10
	validates_inclusion_of :rating, :in => %w( G PG PG-13 R NC-17 )
	
	def appropriate_for_birthdate?(birthdate)
		if rating == "PG" || rating == "G"
			return true
		elsif rating == "PG-13" && ((Time.now-birthdate) >= 409968000)
			return true
		end
		return Time.now-birthdate >= 536112000
	end
	
	def self.find_all_appropriate_for_birthdate(birthdate)
		if Time.now-birthdate >= 536112000
			return Movie.find(:all)
		elsif Time.now-birthdate >= 409968000
			return Movie.find(:all, :conditions => {:rating => ["G", "PG", "PG-13"]})
		else
			return Movie.find(:all, :conditions => {:rating => ["G", "PG"]})
		end
	end		
end
