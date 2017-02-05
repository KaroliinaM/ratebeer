class BeerClub < ActiveRecord::Base
  has_many :memberships, dependent: :destroy

  def select_clubs
    m=memberships.where.not(user_id:User.first.id).select(:beer_club_id).distinct
   # b=self.where(id:m)
  end
end

