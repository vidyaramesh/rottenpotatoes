class Choice
  attr_accessor :topFive
  
  def findTopFive(title)
    if title == nil
      return nil
    end
    title = title.gsub(/[\s]/, '+')
    url = "http://api.themoviedb.org/2.1/Movie.search/en/xml/427e9c369e1ace82a41bcc7e68bfc5cc/" + title
    doc = Hpricot(open(url))
    if doc == nil
      return nil
    end
    eles = doc.search("movie")
    if eles == nil or eles.empty?
      return nil
    end
    @topFive = Array.new()
    (0..4).each do |i|
      if eles[i] == nil: 
        break 
      end
	  if eles.length >= i:
		break
	  end
      movie = Movie.new
      movie.title = eles[i].search("name").inner_html
      movie.description = eles[i].search("overview").inner_html
      movie.score = eles[i].search("score").inner_html
      movie.rating = eles[i].search("certification").inner_html
      movie.released_on = Time.parse(eles[i].search("released").inner_html)
      @topFive << movie
    end
    @topFive.sort! { |a,b| b.score <=> a.score }
  end
  
end
