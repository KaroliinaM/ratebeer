module  RatingAverage
  def average_rating
    sum=self.ratings.pluck(:score).inject { |summa, n| summa + n }
    sum=sum/ratings.count
    palautettava="Has "+ ratings.count.to_s + " "+ 'rating'.pluralize(ratings.count) +", average " + sum.to_s
  end 
end
