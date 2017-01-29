class Brewery < ActiveRecord::Base
has_many :beers, dependent: :destroy
has_many :ratings, through: :beers

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end
  def restart
    self.year = 2017
    puts "changed year to #{year}"
  end
  def average_rating
    sum=self.ratings.pluck(:score).inject { |summa, n| summa + n }
    sum=sum/ratings.count
    palautettava="Has "+ ratings.count.to_s + " "+ 'rating'.pluralize(ratings.count) +", average " + sum.to_s
  end
end
