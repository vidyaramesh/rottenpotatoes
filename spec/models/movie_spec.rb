require 'spec_helper'

 

describe Movie do

 before(:each) do

   @valid_attributes = {

     :title => "Pocahontas",

     :description => "A movie about the new world.",

     :rating => "G",

     :released_on => Time.parse("1/1/1995")

   }

 end

 

 it "should create a new instance given valid attributes" do

   Movie.create(@valid_attributes).should be_true

 end

 

 describe "when validating a movie" do

   it "should not allow a movie with no title" do

     @no_title_attributes = {

       :description => "A movie about the new world.",

       :rating => "G",

       :released_on => Time.parse("1/1/1995")

     }

     @movie = Movie.new(@no_title_attributes)

     @movie.should_not be_valid

   end

 

   it "should not allow a movie with no description" do

     @no_title_attributes = {

        :title => "A movie about the new world.",

        :rating => "G",

        :released_on => Time.parse("1/1/1995")

      }

      @movie = Movie.new(@no_title_attributes)

      @movie.should_not be_valid
     
   end


   it "should not allow a movie with a title that is not unique" do 
     
     @no_unique_title_attributes = {

       :title => "Pocahontas",
       
       :description => "A movie about a girl",

       :rating => "G",

       :released_on => Time.parse("1/1/1995")

     }

     @movie = Movie.create!(@no_unique_title_attributes)
     
     @movie2 = Movie.new(@no_unique_title_attributes)

     @movie2.should_not be_valid
     
   end

   it "should not allow a movie with a description less than 10 characters long" do
     
     @no_long_description_attributes = {

       :title => "Pocahontas 2",
       
       :description => "A",

       :rating => "G",

       :released_on => Time.parse("1/1/1995")

     }

     @movie = Movie.new(@no_long_description_attributes)

     @movie.should_not be_valid
   
   end

   it "should allow a movie with a valid movie rating" do
     
     @no_description_attributes = {

       :title => "Pocahontas 3",
       
       :description => "A movie about a girl",

       :rating => "G",

       :released_on => Time.parse("1/1/1995")

     }

     @movie = Movie.new(@no_description_attributes)

     @movie.should be_valid
  
  end 

   it "should not allow a movie with an invalid movie rating" do
     
     @no_description_attributes = {

       :title => "Pocahontas 4",
       
       :description => "A movie about a girl",

       :rating => "X",

       :released_on => Time.parse("1/1/1995")

     }

     @movie = Movie.new(@no_description_attributes)

     @movie.should_not be_valid

  end
  
 end

 
describe "when trying to create an invalid movie or a corner case movie" do
  
  it "should not allow the creation of a movie without a relased on date" do
    
     @no_released_on_attributes = {

        :title => "Pocahontas 3",

        :description => "A movie about a girl",

        :rating => "G",
      }
      
      @movie = Movie.new(@no_released_on_attributes)
      
      @movie.should_not be_valid
  
  end
  
  it "should not allow the creation of a movie with multiple ratings" do 
    
     @no_appropriate_rating_attributes = {

        :title => "Pocahontas 3",

        :description => "A movie about a girl",

        :rating => "G R",

        :released_on => Time.parse("1/1/1995")

      }
      
      @movie = Movie.new(@no_appropriate_rating_attributes)
      
      @movie.should_not be_valid
  end

 it "should not allow a movie with a blank rating" do
   
   @no_appropriate_rating_attributes = {

      :title => "Pocahontas 3",

      :description => "A movie about a girl",

      :rating => " ",

      :released_on => Time.parse("1/1/1995")

    }
    
    @movie = Movie.new(@no_appropriate_rating_attributes)
    
    @movie.should_not be_valid
   
 end 
 
 it "should not allow a movie with no rating" do
   
   @no_appropriate_rating_attributes = {

      :title => "Pocahontas 3",

      :description => "A movie about a girl",

      :released_on => Time.parse("1/1/1995")

    }
    
    @movie = Movie.new(@no_appropriate_rating_attributes)
    
    @movie.should_not be_valid
   
 end

 it "should allow multiple movies with the same description" do
   
   @same_description_attributes = {

      :title => "Pocahontas",

      :description => "A movie about a girl",

      :rating => "G",

      :released_on => Time.parse("1/1/1995")

    }
    
    @same_description_attributes2 = {

       :title => "Pocahontas 2",

       :description => "A movie about a girl",

       :rating => "R",

       :released_on => Time.parse("1/2/1995")

     }
    
    @movie = Movie.create!(@same_description_attributes)
    
    @movie2 = Movie.new(@same_description_attributes2)
    
    @movie2.should be_valid
       
 end
 
 it "should allow multiple movies with the same rating" do
   
   @same_rating_attributes = {

      :title => "Pocahontas",

      :description => "A movie about a girl 1",

      :rating => "G",

      :released_on => Time.parse("1/1/1995")

    }
    
    @same_rating_attributes2 = {

       :title => "Pocahontas 2",

       :description => "A movie about a girl 2",

       :rating => "G",

       :released_on => Time.parse("1/2/1995")

     }
    
    @movie = Movie.create!(@same_rating_attributes)
    
    @movie2 = Movie.new(@same_rating_attributes2)
    
    @movie2.should be_valid
       
 end
 
 it "should allow multiple movies with the same released on date" do
   
   @same_released_attributes = {

      :title => "Pocahontas",

      :description => "A movie about a girl 1",

      :rating => "G",

      :released_on => Time.parse("1/1/1995")

    }
    
    @same_released_attributes2 = {

       :title => "Pocahontas 2",

       :description => "A movie about a girl 2",

       :rating => "R",

       :released_on => Time.parse("1/1/1995")

     }
    
    @movie = Movie.create!(@same_released_attributes)
    
    @movie2 = Movie.new(@same_released_attributes2)
    
    @movie2.should be_valid
       
 end

 it "should allow a movie with a description of length exactly equal to 10" do
   
     @description_equals_10_attributes = {

         :title => "Pocahontas",

         :description => "1234567890",

         :rating => "G",

         :released_on => Time.parse("1/1/1995")

       }
       
      @movie = Movie.new(@description_equals_10_attributes)
      
      @movie.should be_valid
 
 end

end 

 describe "when checking if a movie is age appropriate" do 
   
   it "a G rated movie should be appropriate for newborns" do
     
     @appropriate_G_attributes = {

       :title => "Pocahontas 3",

       :description => "A movie about a girl",

       :rating => "G",

       :released_on => Time.parse("1/1/1995")

     }

     @movie = Movie.create!(@appropriate_G_attributes)
      
     result = @movie.appropriate_for_birthdate?(Time.now)
     
     result.should == true
            
    end
    
    it "a G rated movie should be appropriate for someone over 17" do

      @appropriate_17_attributes = {

        :title => "Pocahontas 3",

        :description => "A movie about a girl",

        :rating => "G",

        :released_on => Time.parse("1/1/1995")

      }

      @movie = Movie.create!(@appropriate_17_attributes)

      birthdate = Time.now-(17*365*24*60*60)
      
      result = @movie.appropriate_for_birthdate?(birthdate)

      result.should == true
      
     end
      
     it "a PG-13 rated movie should not be appropriate for a newborn" do

       @no_appropriate_newborn_attributes = {

         :title => "Spiderman 3",

         :description => "A movie about a spider-boy",

         :rating => "PG-13",

         :released_on => Time.parse("1/1/1995")

       }

       @movie = Movie.create!(@no_appropriate_newborn_attributes)

       birthdate = Time.now

       result = @movie.appropriate_for_birthdate?(birthdate)

       result.should == false

      end
      
      it "a PG-13 rated movie should be appropriate for a 13 year old" do

        @appropriate_13_attributes = {

          :title => "Spiderman 3",

          :description => "A movie about a spider-boy",

          :rating => "PG-13",

          :released_on => Time.parse("1/1/1995")

        }

        @movie = Movie.create!(@appropriate_13_attributes)

        birthdate = Time.now-(13*365*24*60*60 + 24*60*60)

        result = @movie.appropriate_for_birthdate?(birthdate)

        result.should == true

       end
       
      it "a PG-13 rated movie should be appropriate for a 17 year old" do

        @appropriate_17_attributes = {

          :title => "Spiderman 3",

          :description => "A movie about a spider-boy",

          :rating => "PG-13",

          :released_on => Time.parse("1/1/1995")

        }

        @movie = Movie.create!(@appropriate_17_attributes)

        birthdate = Time.now-(17*365*24*60*60 + 24*60*60)

        result = @movie.appropriate_for_birthdate?(birthdate)
  
        result.should == true

       end
       
        it "a R rated movie should not be appropriate for a newborn" do

          @no_appropriate_newborn_attributes = {

            :title => "Inception",

            :description => "A movie about dreams",

            :rating => "R",

            :released_on => Time.parse("1/1/1995")

          }

          @movie = Movie.create!(@no_appropriate_newborn_attributes)

          birthdate = Time.now

          result = @movie.appropriate_for_birthdate?(birthdate)

          result.should == false

         end

         it "a R rated movie should not be appropriate for a 13 year old" do

           @not_appropriate_13_attributes = {

             :title => "Inception",

             :description => "A movie about dreams",

             :rating => "R",

             :released_on => Time.parse("1/1/1995")

           }

           @movie = Movie.create!(@not_appropriate_13_attributes)

           birthdate = Time.now-(13*365*24*60*60 + 24*60*60)

           result = @movie.appropriate_for_birthdate?(birthdate)

           result.should == false

          end

         it "a R rated movie should be appropriate for a 17 year old" do

           @appropriate_17_attributes = {

             :title => "Inception",

             :description => "A movie about dreams",

             :rating => "R",

             :released_on => Time.parse("1/1/1995")

           }

           @movie = Movie.create!(@appropriate_17_attributes)

           birthdate = Time.now-(17*365*24*60*60 + 24*60*60)

           result = @movie.appropriate_for_birthdate?(birthdate)

           result.should == true

          end
         
           it "a NC-17 rated movie should not be appropriate for a newborn" do

              @no_appropriate_newborn_attributes = {

                :title => "Saving Private Ryan",

                :description => "A movie about a war",

                :rating => "NC-17",

                :released_on => Time.parse("1/1/1995")

              }

              @movie = Movie.create!(@no_appropriate_newborn_attributes)

              birthdate = Time.now

              result = @movie.appropriate_for_birthdate?(birthdate)

              result.should == false

             end

            it "a NC-17 rated movie should not be appropriate for a 13 year old" do

               @not_appropriate_13_attributes = {

                 :title => "Saving Private Ryan",

                 :description => "A movie about a war",

                 :rating => "NC-17",

                 :released_on => Time.parse("1/1/1995")

               }

               @movie = Movie.create!(@not_appropriate_13_attributes)

               birthdate = Time.now-(13*365*24*60*60 + 24*60*60)

               result = @movie.appropriate_for_birthdate?(birthdate)

               result.should == false

           end

           it "a NC-17 rated movie should be appropriate for a 17 year old" do

               @appropriate_17_attributes = {

                 :title => "Saving Private Ryan",

                 :description => "A movie about a war",

                 :rating => "NC-17",

                 :released_on => Time.parse("1/1/1995")

               }

               @movie = Movie.create!(@appropriate_17_attributes)

               birthdate = Time.now-(17*365*24*60*60 + 24*60*60)

               result = @movie.appropriate_for_birthdate?(birthdate)

               result.should == true

          end
   end
   
 describe "when checking age-appropriateness" do

   it "should be appropriate for a 15-year-old if rated G" do
     
      @no_appropriate_15_attributes = {

        :title => "Pocahontas 3",

        :description => "A movie about a girl",

        :rating => "G",

        :released_on => Time.parse("1/1/1995")

      }

      @movie = Movie.create!(@no_appropriate_15_attributes)
      
      birthdate = Time.now-(15*365*24*60)
      
      @enumerableCollection = Movie.find_all_appropriate_for_birthdate(birthdate)
      
      @enumerableCollection.should include(@movie)
      
   end
   
   it "should be appropriate for a 30-year-old if rated G" do
     
     @no_appropriate_30_G_attributes = {

       :title => "Pocahontas 3",

       :description => "A movie about a girl",

       :rating => "G",

       :released_on => Time.parse("1/1/1995")

     }

     @movie = Movie.create!(@no_appropriate_30_G_attributes)
     
     birthdate = Time.now-(30*365*24*60)
     
     @enumerableCollection = Movie.find_all_appropriate_for_birthdate(birthdate)
     
     @enumerableCollection.should include(@movie)
   
   end

   it "should not be appropriate for a 15-year-old if rated R" do
     
     @no_exclude_r_15_attributes = {

       :title => "Pocahontas Gone Wild",

       :description => "A very scary movie about Pocahontas becoming possessed",

       :rating => "R",

       :released_on => Time.parse("1/1/1995")

     }

     @movie = Movie.create!(@no_exclude_r_15_attributes)
     
     birthdate = Time.now-(15*365*24*60)
     
     @enumerableCollection = Movie.find_all_appropriate_for_birthdate(birthdate)
     
     @enumerableCollection.should_not include(@movie)
  
  end

 end

 

 describe "database finder for age-appropriateness" do

   it "should always include G rated movies" do

     @movie = Movie.create!(@valid_attributes)

     Movie.find_all_appropriate_for_birthdate(Time.now).should include(@movie)
     
   end

   it "should exclude R rated movies if age is less than 17" do 
     
     @no_exclude_r_attributes = {

       :title => "Pocahontas Gone Wild",

       :description => "A movie about a girl",

       :rating => "R",

       :released_on => Time.parse("1/1/1995")

     }

     @movie = Movie.create!(@no_exclude_r_attributes)
     
     birthdate = Time.now-(16*365*24*60 + 364*24*60)
     
     @enumerableCollection = Movie.find_all_appropriate_for_birthdate(birthdate)
     
     @enumerableCollection.should_not include(@movie)
     
    end
    
 end

end