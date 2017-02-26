module  RatingAverage
  def average_rating
    if self.ratings.empty?
      return 0
    end
    sum=self.ratings.pluck(:score).inject { |summa, n| summa + n }/ratings.count
  end
  def average_rating_to_s
    sum=self.ratings.pluck(:score).inject { |summa, n| summa + n }/ratings.count
    palautettava="Has "+ ratings.count.to_s + " "+ 'rating'.pluralize(ratings.count) +", average " + sum.to_s
  end 
end
