class User < ActiveRecord::Base
include RatingAverage
  has_secure_password
  validates :username, uniqueness: true, length: { minimum: 3, maximum: 30 }
  validates :password, length: { minimum: 4 }, format: {:with => /([A-Z]+[a-z]+\d+)/}
  has_many :ratings, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :beers, through: :ratings


  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end
  def favorite_style
    return nil if ratings.empty?
    rating_beer_styles
  end
  def rating_beer_styles
    ka=0
    palautettava=nil
    style=ratings.map {|rating| rating.beer.style}.uniq
    style.each do |rate|
      beers=ratings.find_all {|x| x.beer.style==rate}
      sum=beers.map {|rating| rating.score}.inject { |summa, n| summa + n }/beers.count
      puts sum
      palautettava=rate if ka<sum 
    end
    return palautettava
  end
  #def favorite_brewery
  #end
  def self.top(n)
    rated_most=User.all.sort_by{|u| -(u.ratings.count)}
    rated_most.take(n)
  end
end
