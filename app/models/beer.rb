class Beer < ActiveRecord::Base
belongs_to :brewery
has_many :ratings, dependent: :destroy

  def average_rating
    sum=self.ratings.pluck(:score).inject { |summa, n| summa + n }
    sum=sum/ratings.count
    palautettava="Has "+ ratings.count.to_s + " "+ 'rating'.pluralize(ratings.count) +", average " + sum.to_s
  end
  def to_s
    self.name + " " + self.brewery.name
    
  end
end
